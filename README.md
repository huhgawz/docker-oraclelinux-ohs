# huhgawz/oraclelinux-ohs

## Introduction

> NOTE: THIS PROJECT IS IN ACTIVE DEVELOPMENT. SOME THINGS CAN CHANGE RADICALLY.

Dockerized `Oracle Linux` with `Oracle HTTP Server` (`OHS`).

## Requirements

- [Docker 1.9.x](http://docs.docker.com/engine/installation/mac/)

## Installation

1. Download `OHS`:
  1. Go to [Oracle Web Tier Downloads](http://www.oracle.com/technetwork/middleware/webtier/downloads/)
  2. Click the **Accept License Agreement** radio button
  3. In the **Web Tier 11gR1 - 11.1.x.x** combo box, select the **Linux 64-bit** option
  4. Click the **Download File** button
  5. Save the file in `Downloads` folder (i.e. `~/Downloads/ofm_webtier_linux_11.1.x.x.x_64_disk1_1of1.zip`)
2. Clone the repo: `$ git clone https://github.com/huhgawz/docker-oraclelinux-ohs.git && cd docker-oraclelinux-ohs`
3. Move `OHS` file to the cloned repo: `$ mv ~/Downloads/ofm_webtier_linux_11.1.x.x.x_64_disk1_1of1.zip .`
4. Build the image:
  - `$ docker build --rm --tag=$USER/oraclelinux-ohs .`
    - It is possible to set a proxy: `$ docker build --rm --build-arg http_proxy=$HTTP_PROXY --tag=$USER/oraclelinux-ohs .`
    - It is also possible to set `OHS` version: `$ docker build --rm  --build-arg OHS_VERSION=11.1.1.9.0 --tag=$USER/oraclelinux-ohs .`
5. Run a container: `$ docker run --interactive --tty --publish 9777:7777 --name ohs $USER/oraclelinux-ohs`
6. In the running container, start `OHS`: `$ ./opmnctl startall`
7. Verify that `OHS` is running:
  - Get the IP address:
    - In Mac OS: `$ docker-machine env default | grep HOST`
    - In Linux: `$ docker inspect ohs | grep IP`
  - Open this URL in a browser: http://\<ip-address\>:9777

## TODO

- Get `OHS` zip installation file via `wget` or `curl`?
- Automatically start `OHS` when a container is run (i.e. `$ docker run --detach --publish 9777:7777 --name ohs $USER/oraclelinux-ohs`)
- Expose volume for configuration files

## References

- [Docker run](https://docs.docker.com/reference/commandline/run/)
- [Docker run reference](https://docs.docker.com/reference/run/)
- [Docker exec](https://docs.docker.com/reference/commandline/exec/)
- [Mac OS X - Uninstall Docker Toolbox](http://docs.docker.com/engine/installation/mac/#uninstall-docker-toolbox)
- [Oracle HTTP Server](http://www.oracle.com/technetwork/middleware/webtier/overview/index.html#OHS)
- [Oracle Web Tier Downloads](http://www.oracle.com/technetwork/middleware/webtier/downloads/)
- [Oracle Fusion Middleware Installation Guide for Oracle Web Tier](https://docs.oracle.com/middleware/11119/webtier/install-ohs/toc.htm)
- [Oracle Fusion Middleware Installation Planning Guide - Silent Oracle Fusion Middleware Installation and Deinstallation](https://docs.oracle.com/middleware/11119/core/ASINS/silent_install.htm#ASINS235)
- [Installing and Configuring the Oracle HTTP Server](http://docs.oracle.com/html/E12405_15/wcadm_security_sso.htm#CEGEJJBE)
- [How to download Oracle software using wget or curl](http://www.pythian.com/blog/how-to-download-oracle-software-using-wget-or-curl/)
- [Download Oracle using wget, A tiny HowTo](http://nayyares.blogspot.com/2008/07/download-oracle-using-wget-tiny-howto.html)
- [Download Oracle software with wget](http://nayyares.blogspot.com/2008/07/download-oracle-using-wget-tiny-howto.html)
- [Configure Oracle HTTP Server (OHS) on port 80 / 443](http://onlineappsdba.com/index.php/2013/05/30/configure-oracle-http-server-ohs-on-port-80-443/)
- [Getting Started with Oracle HTTP Server](http://docs.oracle.com/cd/E16764_01/web.1111/e10144/getstart.htm#BEHFGCAE)
- [get_files.sh gist](https://gist.github.com/jpiwowar/6725209#file-get_files-sh)
