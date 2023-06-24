#!/bin/bash

set -e

umask 0002
chmod g+w /data
chmod o+w /dev/stdout /dev/stderr

cd /data
export LD_LIBRARY_PATH=.

if [ "$(id -u)" = 0 ]; then
  echo "Preparing to drop privileges"

  if [[ -v USER_UID && "$USER_UID" != "0" ]]; then
    echo "Adjusting uid to $USER_UID"
    usermod -u "$USER_UID" steam
  fi

  if [[ -v USER_GID ]]; then
    echo "Adjusting gid to $USER_GID"
    groupmod -o -g "$USER_GID" steam
  fi

  if [[ -v USER_UID && $(stat -c "%u" /data) != $USER_UID ]]; then
    echo "Adjusting file permissions"
    chown -R steam:steam /data /home/steam
  fi

  echo "Running command as normal user"
  exec gosu steam:steam "$@"
else
  echo "Running $@"
  exec "$@"
fi
