FROM alpine:3.19.0

ENV USER=exie \
    GROUP=party \
    CUSTOM_UID=1001 \
    TZ=UTC \
    LANG=en_US.utf8

ENV LANGUAGE=$LANG \
    LC_ALL=$LANG \
    HOME=/home/$USER

COPY add-packages.list remove-packages.list /tmp/

RUN set -eux; \
    echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" | tee -a /etc/apk/repositories > /dev/null; \
    echo "https://dl-cdn.alpinelinux.org/alpine/edge/community" | tee -a /etc/apk/repositories > /dev/null; \
    apk -U upgrade; \
    xargs -r apk -v add < /tmp/add-packages.list; \
    addgroup --system --gid $CUSTOM_UID $GROUP; \
    adduser --system --disabled-password --uid $CUSTOM_UID $USER -G $GROUP -s /bin/bash; \
    setup-timezone -z $TZ; \
    xargs -r apk -v del < /tmp/remove-packages.list; \
    rm -rf /var/cache/apk/*; \
    rm -rf /tmp/*

SHELL ["/bin/bash", "-c"]

COPY .bashrc $HOME
RUN chown $USER:$GROUP $HOME/.bashrc

WORKDIR $HOME
USER $USER

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
