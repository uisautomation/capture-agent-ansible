FROM ubuntu:16.04
# Set the BASE_IMAGE_URL environment variable to base image on a different
# flavour of Ubuntu
#
# Override with "--build-arg BASE_IMAGE_URL={some url}
ARG BASE_IMAGE_URL=http://www.mirrorservice.org/sites/releases.ubuntu.com/16.04.5/ubuntu-16.04.5-desktop-amd64.iso

# "coreutils" provides "sha1sum".
RUN \
  apt-get -y update && \
  apt-get -y install coreutils mkisofs syslinux-utils curl && \
  mkdir /workspace && \
  curl -o /workspace/base.iso "${BASE_IMAGE_URL}"

ADD ./workspace/ /workspace
WORKDIR /workspace
ENV IMAGE_NAME=lc-agent
ENTRYPOINT ["/workspace/entrypoint.sh"]
