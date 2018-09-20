FROM ubuntu:16.04
ARG DISTRO_IMAGE_URL=http://releases.ubuntu.com/xenial/ubuntu-16.04.5-desktop-amd64.iso
WORKDIR /tmp
RUN apt update 
RUN apt -y install mkisofs syslinux-utils vim wget
RUN wget ${DISTRO_IMAGE_URL} -O /tmp/distro.iso
COPY preseed.cfg /tmp
COPY isolinux.cfg /tmp
COPY txt.cfg /tmp
COPY build-lc-iso.sh /tmp/build-lc-iso.sh
#ENTRYPOINT ["/tmp/build-lc-iso.sh"]
