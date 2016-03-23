FROM boot2docker/boot2docker
MAINTAINER Evan Hazlett <ejhazlett@gmail.com>

ENV SERIES 1.10
ENV VERSION 1.10.3-cs1

RUN curl -fL -o $ROOTFS/usr/local/bin/docker https://packages.docker.com/$SERIES/builds/linux/amd64/docker-$VERSION && \
    chmod +x $ROOTFS/usr/local/bin/docker

RUN echo "" >> $ROOTFS/etc/motd
RUN echo "  Using Docker CS Version ${VERSION}." >> $ROOTFS/etc/motd
RUN echo "" >> $ROOTFS/etc/motd

RUN /make_iso.sh
CMD ["cat", "boot2docker.iso"]
