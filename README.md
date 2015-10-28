# huhgawz/oraclelinux-ohs

## Introduction

Dockerized `Oracle Linux` with `Oracle HTTP Server` (`OHS`).

## Installation

Automated builds of the image are available at: [huhgawz/oraclelinux-ohs](https://hub.docker.com/r/huhgawz/oraclelinux-ohs/)

This is the recommended installation method:

```sh
$ docker pull huhgawz/oraclelinux-ohs
```

Alternatively you can build the image locally:

```sh
$ git clone https://github.com/huhgawz/docker-oraclelinux-ohs.git
$ cd docker-oraclelinux-ohs
$ docker build --tag=$USER/oraclelinux-ohs .
```
## TODO

- Run `OHS` when image is run
