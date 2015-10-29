# huhgawz/oraclelinux-ohs

## Introduction

**NOTICE: THIS IS A WORK IN PROGRESS. THIS NOTICE WILL BE REMOVED ONCE I FEEL COMFORTABLE WITH IT. CONTRIBUTIONS ARE WELCOME.**

Dockerized `Oracle Linux` with `Oracle HTTP Server` (`OHS`).

## Installation

1. Download `OHS` zip installation file
  1. Go to [Oracle Web Tier Downloads](http://www.oracle.com/technetwork/middleware/webtier/downloads/index.html)
  2. Click the **Accept License Agreement** radio button
  3. In the **Web Tier 11gR1 - 11.1.x.x** combo box, select the **Linux 64-bit** option
  4. Click the **Download File** button
2. Clone this repo: `$ git clone https://github.com/huhgawz/docker-oraclelinux-ohs.git && cd docker-oraclelinux-ohs`
3. Move `OHS` zip installation file to the cloned repo: `$ mv ~/Downloads/ofm_webtier_linux_11.1.x.x.x_64_disk1_1of1.zip  .`
4. Update the value of the [OHS_VERSION](https://github.com/huhgawz/docker-oraclelinux-ohs/blob/master/Dockerfile#L15) environment variable accordingly: `$ vi Dockerfile`
5. Build the image: `$ docker build --rm --tag=oraclelinux-ohs .`
6. Run a container: `$ docker run --detach --publish 9000:7777 --name ohs oraclelinux-ohs`
7. Create a new Bash session in the running container: `$ docker exec --interactive -tty ohs bash` 
8. In the docker container, start `OHS`: `$ ./oracle/Middleware/Oracle_WT1/opmn/bin/opmnctl startall` 
9. Get the IP addres of the running container: `$ docker inspect --format='{{.NetworkSettings.IPAddress}}' ohs`
10. Open the following URL in a browser: [http://localhost:9000]()

## TODO

- Get `OHS` zip installation file via `wget` or `curl`?
- Automatically start `OHS` when the image is run
- Expose volume for configuration files

## References

- [Docker run](https://docs.docker.com/reference/commandline/run/)
- [Docker run reference](https://docs.docker.com/reference/run/)
- [Docker exec](https://docs.docker.com/reference/commandline/exec/)
- [Oracle HTTP Server](http://www.oracle.com/technetwork/middleware/webtier/overview/index.html#OHS)
- [Oracle Web Tier Downloads](http://www.oracle.com/technetwork/middleware/webtier/downloads/index.html)
- [Oracle Fusion Middleware Installation Guide for Oracle Web Tier](https://docs.oracle.com/middleware/11119/webtier/install-ohs/toc.htm)
- [Oracle Fusion Middleware Installation Planning Guide - Silent Oracle Fusion Middleware Installation and Deinstallation](https://docs.oracle.com/middleware/11119/core/ASINS/silent_install.htm#ASINS235)
- [How to download Oracle software using wget or curl](http://www.pythian.com/blog/how-to-download-oracle-software-using-wget-or-curl/)
- [Download Oracle using wget, A tiny HowTo](http://nayyares.blogspot.com/2008/07/download-oracle-using-wget-tiny-howto.html)
- [Downlaod Oracle software with wget](http://nayyares.blogspot.com/2008/07/download-oracle-using-wget-tiny-howto.html)
- [Configure Oracle HTTP Server (OHS) on port 80 / 443](http://onlineappsdba.com/index.php/2013/05/30/configure-oracle-http-server-ohs-on-port-80-443/)
- [Getting Started with Oracle HTTP Server](http://docs.oracle.com/cd/E16764_01/web.1111/e10144/getstart.htm#BEHFGCAE)
- [get_files.sh gist](https://gist.github.com/jpiwowar/6725209#file-get_files-sh)
