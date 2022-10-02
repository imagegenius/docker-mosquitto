FROM hydaz/baseimage-alpine:latest

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Mosquitto version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="hydaz"

RUN set -xe && \
	if [ -z ${VERSION+x} ]; then \
		VERSION=$(curl -sL  "http://dl-cdn.alpinelinux.org/alpine/v3.16/main/x86_64/APKINDEX.tar.gz" | tar -xz -C /tmp \
			&& awk '/^P:mosquitto$/,/V:/' /tmp/APKINDEX | sed -n 2p | sed 's/^V://'); \
	fi && \
	echo "**** install packages ****" && \
	apk add -U --upgrade --no-cache \
		mosquitto==${VERSION} \
		mosquitto-clients==${VERSION} && \
	echo "**** cleanup ****" && \
	apk del --purge \
		build-dependencies && \
	rm -rf \
		/tmp/* \

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 1883
VOLUME /config
