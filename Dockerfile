FROM golang:alpine AS builder

ENV PKGVER 1.5.0

RUN apk add --no-cache ca-certificates curl \
    && mkdir -p /go \
    && cd /go \
    && mkdir -p src/github.com/syncthing \
    && export SRCDIR=$PWD \
    && cd src/github.com/syncthing \
    && curl -L https://github.com/syncthing/syncthing/releases/download/v${PKGVER}/syncthing-source-v${PKGVER}.tar.gz | tar xzf - \
    && cd syncthing \
    && export GOPATH="$SRCDIR" GOROOT_FINAL="/usr/bin" \
    && go run build.go -no-upgrade -version v${PKGVER} build strelaysrv \
    && go run build.go -no-upgrade -version v${PKGVER} build stdiscosrv
