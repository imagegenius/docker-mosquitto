<!-- DO NOT EDIT THIS FILE MANUALLY  -->

# [imagegenius/mosquitto](https://github.com/imagegenius/docker-mosquitto)

[![GitHub Release](https://img.shields.io/github/release/imagegenius/docker-mosquitto.svg?color=007EC6&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/imagegenius/docker-mosquitto/releases)
[![GitHub Package Repository](https://img.shields.io/static/v1.svg?color=007EC6&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=imagegenius.io&message=GitHub%20Package&logo=github)](https://github.com/imagegenius/docker-mosquitto/packages)
![Image Size](https://img.shields.io/docker/image-size/imagegenius/mosquitto/latest.svg?color=007EC6&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=docker)
[![Jenkins Build](https://img.shields.io/jenkins/build?labelColor=555555&logoColor=ffffff&style=for-the-badge&jobUrl=https%3A%2F%2Fci.imagegenius.io%2Fjob%2FDocker-Pipeline-Builders%2Fjob%2Fdocker-mosquitto%2Fjob%2Fmain%2F&logo=jenkins)](https://ci.imagegenius.io/job/Docker-Pipeline-Builders/job/docker-mosquitto/job/main/)

[Mosquitto](https://mosquitto.org/) an open source (EPL/EDL licensed) message broker that implements the MQTT protocol versions 5.0, 3.1.1 and 3.1. Mosquitto is lightweight and is suitable for use on all devices from low power single board computers to full servers.

[![mosquitto](https://mosquitto.org/images/mosquitto-text-side-28.png)](https://mosquitto.org/)

## Supported Architectures

We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list).

Simply pulling `ghcr.io/imagegenius/mosquitto:latest` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Available | Tag |
| :----: | :----: | ---- |
| x86-64 | ✅ | amd64-\<version tag\> |
| arm64 | ❌ | |

## Application Setup

The default configuration should be enough to get started.

## Usage

Here are some example snippets to help you get started creating a container.

### docker-compose

```yaml
---
version: "2.1"
services:
  mosquitto:
    image: ghcr.io/imagegenius/mosquitto:latest
    container_name: mosquitto
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Australia/Melbourne
    volumes:
      - path_to_appdata:/config
    ports:
      - 1883:1883
      - 8883:8883
      - 9001:9001
    restart: unless-stopped
```

### docker cli ([click here for more info](https://docs.docker.com/engine/reference/commandline/cli/))

```bash
docker run -d \
  --name=mosquitto \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Australia/Melbourne \
  -p 1883:1883 \
  -p 8883:8883 \
  -p 9001:9001 \
  -v path_to_appdata:/config \
  --restart unless-stopped \
  ghcr.io/imagegenius/mosquitto:latest
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 1883` | MQTT Port |
| `-p 8883` | MQTT TLS Port |
| `-p 9001` | MQTT Websockets Port |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Australia/Melbourne` | Specify a timezone to use eg. Australia/Melbourne. |
| `-v /config` | Contains the configuration file |

## Environment variables from files (Docker secrets)

You can set any environment variable from a file by using a special prepend `FILE__`.

As an example:

```bash
-e FILE__PASSWORD=/run/secrets/mysecretpassword
```

Will set the environment variable `PASSWORD` based on the contents of the `/run/secrets/mysecretpassword` file.

## Umask for running applications

For all of our images we provide the ability to override the default umask settings for services started within the containers using the optional `-e UMASK=022` setting.
Keep in mind umask is not chmod it subtracts from permissions based on it's value it does not add. Please read up [here](https://en.wikipedia.org/wiki/Umask) before asking for support.

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```bash
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```

## Support Info

* Shell access whilst the container is running: `docker exec -it mosquitto /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f mosquitto`
* container version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' mosquitto`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' ghcr.io/imagegenius/mosquitto:latest`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.

Below are the instructions for updating containers:

### Via Docker Compose

* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull mosquitto`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d mosquitto`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Run

* Update the image: `docker pull ghcr.io/imagegenius/mosquitto:latest`
* Stop the running container: `docker stop mosquitto`
* Delete the container: `docker rm mosquitto`
* Recreate a new container with the same docker run parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* You can also remove the old dangling images: `docker image prune`

## Building locally

If you want to make local modifications to these images for development purposes or just to customize the logic:

```bash
git clone https://github.com/imagegenius/docker-mosquitto.git
cd docker-mosquitto
docker build \
  --no-cache \
  --pull \
  -t ghcr.io/imagegenius/mosquitto:latest .
```

The ARM variants can be built on x86_64 hardware using `multiarch/qemu-user-static`

```bash
docker run --rm --privileged multiarch/qemu-user-static:register --reset
```

Once registered you can define the dockerfile to use with `-f Dockerfile.aarch64`.

## Versions

* **02.01.23:** - Initial Release.
