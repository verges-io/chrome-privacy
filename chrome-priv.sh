#!/bin/bash

if [ x"$(pax11publish -d)" = x ]; then
    start-pulseaudio-x11
fi

readonly user_uid=$(id -u)
readonly user_gid=$(id -g)

docker run -d -it \
  --net host \
  -v /etc/localtime:/etc/localtime:ro \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=unix$DISPLAY \
  -v /var/lib/dbus:/var/lib/dbus \
  -v $HOME:/home/chrome/parent_home \
  -v $HOME/Downloads:/home/chrome/Downloads \
  -e USER_UID=${user_uid} \
  -e USER_GID=${user_gid} \
  --group-add audio \
  --group-add video \
  --device /dev/dri \
  -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket:ro \
  -v /dev/shm:/dev/shm \
  -v /run/dbus/:/run/dbus/:rw \
  -v /dev/snd:/dev/snd \
  --privileged \
  sotapanna108/chrome-privacy

