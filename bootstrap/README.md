# Lecture Capture Agent Bootstrap

## How to create a custom ISO image which can be used to install a Lecture Capture Agent

Download a copy of the linux distribution ISO image (currently Ubuntu 16.04.5), add it to the directory that holds these files.

### Build the docker image:

`docker build -t lc-iso-ubuntu .`

### Run the docker container (needs to be privileged to do the loopback mount):

`docker run -t -i --privileged lc-iso-ubuntu bash`

### Build the ISO image:

`cd /tmp`

`./build-lc-iso.sh`

### Copy the ISO amge out of the container to the docker host:

On the docker host

`docker cp <container>:/tmp/lc.iso .`

This can then be flashed to a USB stick, with dd or on mac OSX I use etcher.
