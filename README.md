# huhgawz/oraclelinux-ohs

**NOTICE: THIS IS A WORK IN PROGRESS. USE IT AT YOUR OWN RISK. THIS NOTICE WILL BE REMOVED ONCE THIS WORKS CORRECTLY.**

## Introduction

Dockerized `Oracle Linux` with `Oracle HTTP Server` (`OHS`).

## Installation

1. Clone this repo: `$ git clone https://github.com/huhgawz/docker-oraclelinux-ohs.git && cd docker-oraclelinux-ohs`
2. Go to [Oracle Web Tier Downloads](http://www.oracle.com/technetwork/middleware/webtier/downloads/index.html)
3. Click the **Accept License Agreement** radio button
4. In the **Web Tier 11gR1 - 11.1.x.x** combo box, select the **Linux 64-bit** option
5. Click the **Download File** button and save the file at the folder in which you git cloned this repo (i.e. `docker-oracle-linux-ohs/ofm_webtier_linux_11.1.x.x.x_64_disk1_1of1.zip`)
6. Update the value of the [OHS_VERSION](https://github.com/huhgawz/docker-oraclelinux-ohs/blob/master/Dockerfile#L15) environment variable accordingly: `$ vi Dockerfile`
7. Build the image: `$ docker build --tag=oraclelinux-ohs .`

## TODO

- Get `OHS` installation zip file via `wget` or `curl`
- Start `OHS` when the image is run
- Make possible to set external configuration files via [docker volumes](https://docs.docker.com/userguide/dockervolumes/#mount-a-host-directory-as-a-data-volume)

## References

- [Oracle HTTP Server](http://www.oracle.com/technetwork/middleware/webtier/overview/index.html#OHS)
- [Oracle Web Tier Downloads](http://www.oracle.com/technetwork/middleware/webtier/downloads/index.html)
- [Oracle Fusion Middleware Installation Guide for Oracle Web Tier](https://docs.oracle.com/middleware/11119/webtier/install-ohs/toc.htm)
