From ubuntu:16.04
RUN apt update 
RUN apt -y install mkisofs syslinux-utils vim
COPY ubuntu-16.04.5-desktop-amd64.iso /tmp
#COPY lubuntu-16.04.5-desktop-amd64.iso /tmp
COPY preseed.cfg /tmp
COPY isolinux.cfg /tmp
COPY txt.cfg /tmp
COPY build-lc-iso.sh /tmp/build-lc-iso.sh
#ENTRYPOINT ["/tmp/build-lc-iso.sh"]
