ARG BASEIMAGE=arm64v8/golang:1.17.2-alpine
FROM ${BASEIMAGE}

ARG HUGO_VERSION=0.88.1
ARG OPERATING_SYSTEM=Linux
ARG ARCH=ARM
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL mantainer="mpw <x@mpw.sh>" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name=$BASEIMAGE \
    org.label-schema.description="Hugo extended for armv8" \
    org.label-schema.url="https://mpw.sh" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/mpwsh/rpi-hugo" \
    org.label-schema.vendor="mpw" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0"

ENV HUGO_BIND="0.0.0.0" \
    HUGO_EDITION="extended" \
    HUGO_CACHEDIR="/tmp" \
    NODE_PATH=".:/usr/local/node/lib/node_modules" \
    PATH="/go/bin:/usr/local/go/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/node/bin" \
    GOPATH="/go" \
    HOME="/tmp"

RUN apk add --no-cache --update \
    zip unzip git gcc g++ musl-dev
RUN mkdir /src /target
RUN chmod a+w /src /target
ADD https://github.com/gohugoio/hugo/archive/refs/tags/v${HUGO_VERSION}.zip /tmp
RUN unzip /tmp/v${HUGO_VERSION}.zip -d /tmp
WORKDIR /tmp/hugo-${HUGO_VERSION}
RUN go build --tags extended -o hugo
RUN mkdir -p /usr/local/sbin
RUN mv hugo /usr/local/sbin/hugo && rm -rf /tmp/*

VOLUME /src
VOLUME /target

WORKDIR /src

ENTRYPOINT ["hugo"]


EXPOSE 1313

ONBUILD ARG HUGO_CMD
ONBUILD ARG HUGO_DESTINATION
ONBUILD ARG HUGO_ENV
ONBUILD ARG HUGO_DESTINATION="${HUGO_DESTINATION:/target}" HUGO_ENV="${HUGO_ENV:-DEV}"
