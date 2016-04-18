#!/bin/bash

readonly user_uid=$(id -u)
readonly user_gid=$(id -g)

docker run --rm -it \
    --net host \
    --cpuset-cpus 0 \
    --memory 512mb \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e USER_UID=${user_uid} \
    -e USER_GID=${user_gid} \
    -e DISPLAY=unix$DISPLAY \
    -v /var/lib/dbus:/var/lib/dbus \
    -v $HOME:/root/parent_home \
    -v $HOME/Downloads:/root/Downloads \
    --device /dev/snd \
    -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket:ro \
    -v /dev/shm:/dev/shm \
    --name chrome \
    sotapanna108/chrome-privacy
