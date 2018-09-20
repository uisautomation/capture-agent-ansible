# Lecture Capture Agent Bootstrap

This directory contains a Docker-ised script to build a custom Ubuntu image for
a Lecture Capture Agent.

## Short version

```bash
$ docker run --privileged --rm -v $PWD/images:/images $(docker build -q .)
```

After some time a new lecture capture agent image is available at
``images/lc-agent.iso``.

## Changing base Ubuntu version

The ``BASE_IMAGE_URL`` build argument can be used to specify a different base
image to download when building the image. E.g. to use the lubuntu:

```bash
$ docker build -t lc-lubuntu \
  --build-arg BASE_IMAGE_URL=http://www.mirrorservice.org/sites/cdimage.ubuntu.com/cdimage/lubuntu/releases/16.04.5/release/lubuntu-16.04-desktop-amd64.iso \
  .
$ docker run --privileged --rm -v $PWD/images:/images \
  -e IMAGE_NAME=lc-agent-lubuntu lc-lubuntu
```

A lubuntu flavoured image is then available at ``images/lc-agent-lubuntu.iso``.

## Changing image name

By default, the script writes the output image to ``/images/lc-agent.iso``. The
basename of this file is configurable via the ``IMAGE_NAME`` environment
variable. So, with ``IMAGE_NAME=my-image``, the script writes the image to
``/images/my-image.iso``.
