FROM ubuntu

RUN echo steam steam/question select "I AGREE" | debconf-set-selections && \
    echo steam steam/license note '' | debconf-set-selections && \
    dpkg --add-architecture i386 && \
    apt-get -q -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -q -y --no-install-recommends \
      lib32gcc-s1 steamcmd ca-certificates gosu wine wine32 wine64 xvfb && \
    ln -sf /usr/games/steamcmd /usr/bin/steamcmd && \
    DEBIAN_FRONTEND=noninteractive apt-get autoremove -q -y && \
    rm -rf /var/lib/apt/lists/*

RUN userdel ubuntu && \
    addgroup --gid 1000 steam && \
    adduser --system --home /home/steam --shell /bin/false --uid 1000 --ingroup steam steam && \
    usermod -a -G tty steam && \
    mkdir -m 777 /data && \
    mkdir -p /home/steam/.local/share && \
    chown -R steam:steam /data /home/steam

ADD entrypoint.sh /entrypoint.sh
ADD run.sh /run.sh
ADD steamcmd-* /usr/local/bin/
RUN chmod +x /run.sh /entrypoint.sh /usr/local/bin/steamcmd-*

ENV STEAMCMD_LOGIN=anonymous
ENV USER_GID=1000
ENV USER_UID=1000

ENTRYPOINT ["/entrypoint.sh"]

CMD ["steamcmd-wrapper", "/run.sh"]

