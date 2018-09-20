#!/bin/bash
mkdir /tmp/distro
mount -o loop,rw  /tmp/distro.iso /tmp/distro
mkdir /tmp/working-iso
cp -a /tmp/distro/* /tmp/working-iso
cp /tmp/preseed.cfg /tmp/working-iso/preseed/
cp /tmp/isolinux.cfg /tmp/working-iso/isolinux/
cp /tmp/txt.cfg /tmp/working-iso/isolinux/
mkisofs -r -V "Capture Agent Install" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o lc.iso /tmp/working-iso/
isohybrid lc.iso
