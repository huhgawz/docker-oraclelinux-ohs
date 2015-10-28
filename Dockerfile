FROM huhgawz/oraclelinux-oraclejdk

MAINTAINER Huhgawz <huhgawz@gmail.com>

USER root

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL C

RUN yum install -y compat-libstdc++-33 cpp gcc gcc-c++ glibc-devel glibc-headers ksh libaio libaio-devel make sysstat && \
    yum clean all && \
    rm -rf /var/cache/yum/*

ENV OHS_VERSION 11.1.1.9.0

COPY ofm_webtier_linux_${OHS_VERSION}_64_disk1_1of1.zip /tmp/

RUN unzip /tmp/ofm_webtier_linux_${OHS_VERSION}_64_disk1_1of1.zip -d /tmp/ohs && \
    rm -f /tmp/ofm_webtier_linux_${OHS_VERSION}_64_disk1_1of1.zip

ENV OHS_VERSION ""

COPY ohs.rsp /tmp/
COPY oraInst.loc /etc/
COPY sysctl.conf /etc/

RUN useradd -d /oracle oracle && \
    echo "oracle:oracle" | chpasswd && \
    chown -R oracle:oracle /tmp/ohs && \
    chown oracle:oracle /tmp/ohs.rsp && \
    chown oracle:oracle /etc/oraInst.loc && \
    chmod 664 /etc/oraInst.loc && \
    echo "ORACLE_INSTANCE=/oracle/Middleware/Oracle_WT1/instances/instance1" >> /oracle/.bashrc

USER oracle

ENV ORACLE_INSTANCE /oracle/Middleware/Oracle_WT1/instances/instance1

RUN source /oracle/.bashrc && \
    cd /tmp/ohs/Disk1 && \
    ./runInstaller -silent -waitforcompletion -response /tmp/ohs.rsp && \
    cd /oracle/Middleware/Oracle_WT1/opmn/bin && \
    ./opmnctl stopall

USER root

RUN rm -rf /tmp/ohs /tmp/ohs.rsp /tmp/OraInstall* /tmp/hsperfdata_oracle /tmp/tmpInvPtrLoc*

EXPOSE 7777

USER oracle
