#!/usr/bin/env bash

# Exit on errors
set -e

[ -z "${IMAGE_NAME}" ] && (echo "Image name not set" >&2; exit 1)

# Move to workspace directory
cd /workspace

# Show SHA1 checksum of downloaded image for comparison
echo "SHA1 checksum of downloaded image:"
sha1sum base.iso

# Log future commands
set -x

# Mount base image via loopback
mkdir -p base
mount -o loop,rw base.iso base

# Update base image
mkdir -p lc-agent
cp -a ./base/* lc-agent/
cp preseed.cfg lc-agent/preseed/
cp isolinux.cfg lc-agent/isolinux/
cp txt.cfg lc-agent/isolinux/

# Create lc-agent image in images directory
mkdir -p /images
mkisofs -r -V "Capture Agent Install" \
  -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat \
  -no-emul-boot -boot-load-size 4 -boot-info-table \
  -o /images/${IMAGE_NAME}.iso lc-agent/
isohybrid /images/${IMAGE_NAME}.iso

set +x
echo "Wrote image to /images/${IMAGE_NAME}.iso"

# vim:sw=2:sts=2:et
