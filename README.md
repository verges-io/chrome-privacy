# chrome-privacy

## Basics

A dockerized Chrome in privacy mode, based in jfrazelle's Dockerfile.

It comes with 

* _Ghostery_ installed 
* _AdBlock Plus_ installed
* hardware acceleration disabled, as I had issues playing videos

## chrome-priv.sh

You can symlink this file in you `/usr/local/bin` folder. It contains a `docker run` command which mounts your whole home directory within `/root/parent_home` of the container, so you can access it. Additionally, your `Downloads` folder is mounted to `/root/Downloads` so that new downloads will end up in the good spot. 

The `--rm` argument is used which throws away the container when you exit Chrome.
