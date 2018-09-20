FROM ubuntu:16.04
WORKDIR /tmp
RUN apt update 
RUN apt -y install mkisofs syslinux-utils vim
RUN wget http://releases.ubuntu.com/xenial/ubuntu-16.04.5-desktop-amd64.iso -O /tmp/ubuntu-16.04.5-desktop-amd64.iso
COPY preseed.cfg /tmp
COPY isolinux.cfg /tmp
COPY txt.cfg /tmp
COPY build-lc-iso.sh /tmp/build-lc-iso.sh
#ENTRYPOINT ["/tmp/build-lc-iso.sh"]
