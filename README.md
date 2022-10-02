## docker-mosquitto

[![docker hub](https://img.shields.io/badge/docker_hub-link-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/r/hydaz/mosquitto) ![docker image size](https://img.shields.io/docker/image-size/hydaz/mosquitto?style=for-the-badge&logo=docker) [![auto build](https://img.shields.io/badge/docker_builds-automated-blue?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-mosquitto/actions?query=workflow%3A"Auto+Builder+CI")

[Mosquitto](https://github.com/eclipse/mosquitto) is an open source implementation of a server for version 5.0, 3.1.1, and 3.1 of the MQTT protocol. It also includes a C and C++ client library, and the mosquitto_pub and mosquitto_sub utilities for publishing and subscribing.

The default configuration should be enough to get started.

## Usage

```bash
docker run -d \
  --name=mosquitto \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Australia/Melbourne \
  -p 1883:1883 \
  -v <path to appdata>:/config \
  --restart unless-stopped \
  hydaz/mosquitto
```

## Upgrading Mosquitto

To upgrade, all you have to do is pull the latest Docker image. We automatically check for Mosquitto updates daily. When a new version is released, we build and publish an image both as a version tag and on `:latest`.