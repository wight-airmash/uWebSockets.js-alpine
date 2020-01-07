#
# uWebSockets.js (https://github.com/uNetworking/uWebSockets.js) build from sources.
#
FROM node:12-alpine

WORKDIR /build

RUN apk update && apk upgrade

RUN apk add --no-cache git openssh && \
  apk add --no-cache clang llvm5-dev alpine-sdk

RUN git clone -b v16.5.0 https://github.com/uNetworking/uWebSockets.js.git ./binaries
RUN git clone --recurse-submodules https://github.com/uNetworking/uWebSockets.js.git ./sources

WORKDIR /build/sources

# Checkout v16.5.0, https://github.com/uNetworking/uWebSockets.js/commits/master
RUN git reset --hard 723efe9d2d4b139586b86d465aed241d4de311f1
RUN git submodule update --recursive

RUN make

WORKDIR /build

RUN mkdir /uWebSockets.js
RUN cp -R ./sources/dist/* /uWebSockets.js/
RUN cp -f ./binaries/index.d.ts /uWebSockets.js/
RUN cp -f ./binaries/package.json /uWebSockets.js/

WORKDIR /uWebSockets.js
