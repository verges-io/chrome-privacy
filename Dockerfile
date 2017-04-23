# Run Chrome in a container
#
#        docker run -d -it \
#            --net host \
#            --cpuset-cpus 0 \
#            --memory 512mb \
#            -v /etc/localtime:/etc/localtime:ro \
#            -v /tmp/.X11-unix:/tmp/.X11-unix \
#            -e DISPLAY=unix$DISPLAY \
#            -v /var/lib/dbus:/var/lib/dbus \
#            -v $HOME:/root/parent_home \
#            -v $HOME/Downloads:/root/Downloads \
#            -e PULSE_SERVER=tcp:127.0.0.1:4713 \
#            -e PULSE_COOKIE_DATA=`pax11publish -d | grep --color=never -Po '(?<=^Cookie: ).*'` \
#            -e USER_UID=${user_uid} \
#            -e USER_GID=${user_gid} \
#            --group-add audio \
#            --group-add video \
#            --device /dev/dri \
#            -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket:ro \
#            -v /dev/shm:/dev/shm \
#            -v /run/dbus/:/run/dbus/:rw \
#            -v /dev/snd:/dev/snd --privileged \
#        sotapanna108/chrome-privacy
#

# Base docker image
FROM ubuntu:16.04
MAINTAINER Dennis Winter <git@verges.io>

ADD google-talkplugin_current_amd64.deb /src/google-talkplugin_current_amd64.deb

# Install Chrome
RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf && \
    apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    pulseaudio \
    hicolor-icon-theme \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    libexif-dev \
    libv4l-0 \
    fonts-symbola \
    --no-install-recommends \
    && curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list \
    && apt-get update && apt-get install -y \
    google-chrome-stable \
    --no-install-recommends \
    && dpkg -i '/src/google-talkplugin_current_amd64.deb' \
    && apt-get purge --auto-remove -y curl \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /src/*.deb

COPY local.conf /etc/fonts/local.conf
ADD chrome-state /data

RUN \
    useradd -ms /bin/bash chrome && \
    mkdir -p /home/chrome/parent_home && \
    chmod -R 777 /home/chrome/parent_home && \
    chown -R chrome. /data /home/chrome

USER chrome

# Autorun chrome
ENTRYPOINT [ "google-chrome" ]
CMD [ "--user-data-dir=/data", "--disable-sync", "--incognito" ]
