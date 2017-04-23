# chrome-privacy

[![](https://images.microbadger.com/badges/version/sotapanna108/chrome-privacy.svg)](https://microbadger.com/images/sotapanna108/chrome-privacy "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/sotapanna108/chrome-privacy.svg)](https://microbadger.com/images/sotapanna108/chrome-privacy "Get your own image badge on microbadger.com")

## Basics

A dockerized Chrome in privacy mode, based in jfrazelle's Dockerfile.

It comes with 

* _Ghostery_ installed 
* _AdBlock Plus_ installed
* hardware acceleration disabled, as I had issues playing videos

## chrome-priv.sh

You can symlink this file in you `/usr/local/bin` folder. It contains a `docker run` command which mounts your whole home directory within `/root/parent_home` of the container, so you can access it. Additionally, your `Downloads` folder is mounted to `/root/Downloads` so that new downloads will end up in the good spot. 

The `--rm` argument is used which throws away the container when you exit Chrome.

# usage

To run Chrome in a container
```
        docker run -d -it \
            --net host \
            --cpuset-cpus 0 \
            --memory 512mb \
            -v /etc/localtime:/etc/localtime:ro \
            -v /tmp/.X11-unix:/tmp/.X11-unix \
            -e DISPLAY=unix$DISPLAY \
            -v /var/lib/dbus:/var/lib/dbus \
            -v $HOME:/home/chrome/parent_home \
            -v $HOME/Downloads:/home/chrome/Downloads \
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
```
