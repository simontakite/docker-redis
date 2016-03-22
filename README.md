[![](https://badge.imagelayers.io/absolootly/docker-redis:latest.svg)](https://imagelayers.io/?images=absolootly/docker-redis:latest 'Get your own badge on imagelayers.io')

# About absolootly/docker-redis

- [Introduction](#introduction)
- [Getting started](#getting-started)
  - [Installation](#installation)
  - [Quickstart](#quickstart)
  - [Command-line arguments](#command-line-arguments)
  - [Persistence](#persistence)
  - [Authentication](#authentication)
  - [Logs](#logs)
- [Maintenance](#maintenance)
  - [Upgrading](#upgrading)
  - [Shell Access](#shell-access)

# Introduction

This is a`Dockerfile`method to create a [Docker](https://www.docker.com/) container image for [Redis](http://redis.io/).

Redis is an open source, BSD licensed, advanced key-value cache and store. It is often referred to as a data structure server since keys can contain strings, hashes, lists, sets, sorted sets, bitmaps and hyperloglogs.

# Getting started

## Installation

Automated builds of the image are available on [Dockerhub](https://hub.docker.com/r/absolootly/docker-redis) and is the recommended method of installation.

```bash
docker pull absolootly/docker-redis:latest
```

Alternatively you can build the image yourself.

```bash
docker build -t absolootly/docker-redis github.com/simontakite/docker-redis
```

## Quickstart

Start Redis using:

```bash
docker run --name redis -d --restart=always \
  --publish 6379:6379 \
  --volume /srv/docker/redis:/var/lib/redis \
  absolootly/docker-redis:latest
```

*Alternatively, you can use the sample [docker-compose.yml](docker-compose.yml) file to start the container using [Docker Compose](https://docs.docker.com/compose/)*

## Command-line arguments

You can customize the launch command of Redis server by specifying arguments to `redis-server` on the `docker run` command. For example the following command will enable the Append Only File persistence mode:

```bash
docker run --name redis -d --restart=always \
  --publish 6379:6379 \
  --volume /srv/docker/redis:/var/lib/redis \
  absolootly/docker-redis:latest --appendonly yes
```

Please refer to http://redis.io/topics/config for further details.

## Persistence

For Redis to preserve its state across container shutdown and startup you should mount a volume at `/var/lib/redis`.

> *The [Quickstart](#quickstart) command already mounts a volume for persistence.*

SELinux users should update the security context of the host mountpoint so that it plays nicely with Docker:

```bash
mkdir -p /srv/docker/redis
chcon -Rt svirt_sandbox_file_t /srv/docker/redis
```

## Authentication

To secure your Redis server with a password, specify the password in the `REDIS_PASSWORD` variable while starting the container.

```bash
docker run --name redis -d --restart=always \
  --publish 6379:6379 \
  --env 'REDIS_PASSWORD=redispassword' \
  --volume /srv/docker/redis:/var/lib/redis \
  absolootly/docker-redis:latest
```

Clients connecting to the Redis server will now have to authenticate themselves with the password `redispassword`.

Alternatively, the same can also be achieved using the [Command-line arguments](#command-line-arguments) feature to specify the `--requirepass` argument.

## Logs

By default the Redis server logs are sent to the standard output. Using the [Command-line arguments](#command-line-arguments) feature you can configure the Redis server to send the log output to a file using the `--logfile` argument:

```bash
docker run --name redis -d --restart=always \
  --publish 6379:6379 \
  --volume /srv/docker/redis:/var/lib/redis \
  absolootly/docker-redis:latest --logfile /var/log/redis/redis-server.log
```

To access the Redis logs you can use `docker exec`. For example:

```bash
docker exec -it redis tail -f /var/log/redis/redis-server.log
```

# Maintenance

## Upgrading

To upgrade to newer releases:

  1. Download the updated Docker image:

  ```bash
  docker pull absolootly/docker-redis:latest
  ```

  2. Stop the currently running image:

  ```bash
  docker stop redis
  ```

  3. Remove the stopped container

  ```bash
  docker rm -v redis
  ```

  4. Start the updated image

  ```bash
  docker run --name redis -d \
    [OPTIONS] \
    absolootly/docker-redis:latest
  ```

## Shell Access

```bash
docker exec -it redis bash
```
