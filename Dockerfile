# syntax=docker/dockerfile:1

FROM ghcr.io/imagegenius/baseimage-alpine:3.17

# set version label
ARG BUILD_DATE
ARG VERSION
ARG MOSQUITTO_VERSION
LABEL build_version="ImageGenius Version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="hydazz"

RUN \
  if [ -z ${MOSQUITTO_VERSION+x} ]; then \
    MOSQUITTO_VERSION=$(curl -sL "http://dl-cdn.alpinelinux.org/alpine/v3.17/main/x86_64/APKINDEX.tar.gz" | tar -xz -C /tmp \
      && awk '/^P:mosquitto$/,/V:/' /tmp/APKINDEX | sed -n 2p | sed 's/^V://'); \
  fi && \
  echo "**** install packages ****" && \
  apk add -U --upgrade --no-cache \
    mosquitto==${MOSQUITTO_VERSION} \
    mosquitto-clients==${MOSQUITTO_VERSION} && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 1883
VOLUME /config
