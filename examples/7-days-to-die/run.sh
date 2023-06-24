#!/bin/bash

_term() {
  7dtd-shutdown
}

trap _term SIGTERM

./7DaysToDieServer.x86_64 \
  -configfile=serverconfig.xml \
  -quit \
  -batchmode \
  -nographics \
  -dedicated &

child=$!
wait "$child"
