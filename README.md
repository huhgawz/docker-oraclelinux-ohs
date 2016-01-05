# huhgawz/oraclelinux-ohs

## Introduction

Dockerized `Oracle Linux` with `Oracle HTTP Server` (`OHS`).

## Requirements

- [Docker 1.9.x](http://docs.docker.com/engine/installation/mac/)

## Installation

1. Download `OHS`:
  1. Go to [Oracle Web Tier Downloads](http://www.oracle.com/technetwork/middleware/webtier/downloads/)
  2. Click the **Accept License Agreement** radio button
  3. In the **Web Tier 11gR1 - 11.1.x.x** combo box, select the **Linux 64-bit** option
  4. Click the **Download File** button
  5. Save the file in the `Downloads` folder (i.e. `~/Downloads/ofm_webtier_linux_11.1.x.x.x_64_disk1_1of1.zip`)
2. Clone this repo: `$ git clone https://github.com/huhgawz/docker-oraclelinux-ohs.git && cd docker-oraclelinux-ohs`
3. Move `OHS` file to the cloned repo: `$ mv ~/Downloads/ofm_webtier_linux_11.1.x.x.x_64_disk1_1of1.zip .`
4. Build an image:
  - `$ docker build --rm --tag=oraclelinux-ohs .`
    - To set a proxy: `$ docker build --rm --build-arg http_proxy=$HTTP_PROXY --tag=oraclelinux-ohs .`
    - To set `OHS` version: `$ docker build --rm  --build-arg OHS_VERSION=11.1.1.9.0 --tag=oraclelinux-ohs .`
5. Run a container: `$ docker run --interactive --tty --publish 7777:7777 --name ohs oraclelinux-ohs`
6. In the running container:
  - Start `OHS`:
    - `$ cd /oracle/Middleware/Oracle_WT1/opmn/bin && ./opmnctl startall`
    - `$ ps aux`
      You should see an output similar to this one:
      ```
      USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
      oracle       1  0.1  0.0  11764  2932 ?        Ss   17:14   0:00 /bin/bash
      oracle      21  0.0  0.1  72796 10644 ?        Ss   17:14   0:00 /oracle/Middleware/Oracle_WT1/opmn/bin/opmn -d
      oracle      22  1.1  0.3  79228 27404 ?       Sl   17:14   0:00 /oracle/Middleware/Oracle_WT1/opmn/bin/opmn -d
      oracle      40  1.9  0.4  15098 35108 ?        S    17:14   0:00 /oracle/Middleware/Oracle_WT1/ohs/bin/httpd.worker -DSSL
      oracle      48  0.0  0.0  30532  2952 ?        S    17:14   0:00 /oracle/Middleware/Oracle_WT1/ohs/bin/odl_rotatelogs -l /oracle/Middleware/Oracle_WT1/instances/instance1/diagnostics/logs/OHS/ohs1/ohs1-%Y
      oracle      49  0.0  0.0  30532  1856 ?        S    17:14   0:00 /oracle/Middleware/Oracle_WT1/ohs/bin/odl_rotatelogs /oracle/Middleware/Oracle_WT1/instances/instance1/diagnostics/logs/OHS/ohs1/access_log
      oracle      50  0.0  0.2  14884 20108 ?        S    17:14   0:00 /oracle/Middleware/Oracle_WT1/ohs/bin/httpd.worker -DSSL
      oracle      51  0.0  0.0  30532  1896 ?        S    17:14   0:00 /oracle/Middleware/Oracle_WT1/ohs/bin/odl_rotatelogs -l -h:/oracle/Middleware/Oracle_WT1/instances/instance1/config/OHS/ohs1/component_even
      oracle      52  0.0  0.2  28257 23544 ?        Sl   17:14   0:00 /oracle/Middleware/Oracle_WT1/ohs/bin/httpd.worker -DSSL
      oracle      54  0.0  0.3  45477 29536 ?        Sl   17:14   0:00 /oracle/Middleware/Oracle_WT1/ohs/bin/httpd.worker -DSSL
      oracle      56  0.0  0.3  52031 29428 ?        Sl   17:14   0:00 /oracle/Middleware/Oracle_WT1/ohs/bin/httpd.worker -DSSL
      ```
    - Use the escape sequence `CTRL-P` + `CTRL-Q` in order to detach the tty without exiting the shell. The container will continue to exist in a stopped state once exited (see [Docker Running an Interactive Shell](http://docs.docker.com/engine/userguide/basics/#running-an-interactive-shell)).
7. Verify that `OHS` is running by opening this URL in a browser: http://localhost:7777

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
