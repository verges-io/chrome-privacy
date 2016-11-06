PWD=$(shell pwd)
HOME=$(shell echo $HOME)
DISPLAY=$(shell echo $DISPLAY)
USERID=$(shell id -u)
GROUPID=$(shell id -g)

build:
	sudo chown -R dennisw. . && docker build -f ./Dockerfile -t sotapanna108/chrome-privacy .

dev:
	docker run -v $(PWD)/chrome-state-dev:/data --net host -v /etc/localtime:/etc/localtime:ro -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix:1 -v /var/lib/dbus:/var/lib/dbus -e USER_UID=$(USERID) -e USER_GID=$(GROUPID) --group-add audio --group-add video --device /dev/dri -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket:ro -v /dev/shm:/dev/shm -v /run/dbus/:/run/dbus/:rw -v /dev/snd:/dev/snd --privileged sotapanna108/chrome-privacy --user-data-dir=/data --disable-sync
