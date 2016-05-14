#!/bin/bash

if [ x"$(pax11publish -d)" = x ]; then
    start-pulseaudio-x11
fi

readonly user_uid=$(id -u)
readonly user_gid=$(id -g)

docker run --rm -it \
    --net host \
    --cpuset-cpus 0 \
    --memory 512mb \
    -v /etc/localtime:/etc/localtime:ro \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=unix$DISPLAY \
    -v /var/lib/dbus:/var/lib/dbus \
    -v $HOME:/root/parent_home \
    -v $HOME/Downloads:/root/Downloads \
    -e PULSE_SERVER=tcp:127.0.0.1:4713 \
    -e PULSE_COOKIE_DATA=`pax11publish -d | grep --color=never -Po '(?<=^Cookie: ).*'` \
    -e USER_UID=${user_uid} \
    -e USER_GID=${user_gid} \
    --group-add audio \
    --group-add video \
    --device /dev/dri \
    -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket:ro \
    -v /dev/shm:/dev/shm \
    -v /run/dbus/:/run/dbus/:rw \
    -v /dev/snd:/dev/snd --privileged \
    sotapanna108/chrome-privacy 

#     -e USER_UID=${user_uid} \
#    -e USER_GID=${user_gid} \
#--user `id -u`:`getent group video | cut -d: -f3` \
#--device /dev/snd \
