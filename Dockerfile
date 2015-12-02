FROM huhgawz/oraclelinux-oraclejdk

MAINTAINER Huhgawz <huhgawz@gmail.com>

USER root

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C

RUN yum install -y \
        compat-libstdc++-33 \
        cpp \
        gcc \
        gcc-c++ \
        glibc-devel \
        glibc-headers \
        ksh \
        libaio \
        libaio-devel \
        make \
        sysstat \
    && yum clean all \
    && rm -rf /var/cache/yum/*

ENV DOCKER_BUILD_OHS_VERSION 11.1.1.9.0

COPY ofm_webtier_linux_${DOCKER_BUILD_OHS_VERSION}_64_disk1_1of1.zip /tmp/

RUN unzip /tmp/ofm_webtier_linux_${DOCKER_BUILD_OHS_VERSION}_64_disk1_1of1.zip -d /tmp/ohs \
    && rm -f /tmp/ofm_webtier_linux_${DOCKER_BUILD_OHS_VERSION}_64_disk1_1of1.zip

ENV DOCKER_BUILD_OHS_VERSION ""

COPY ohs.rsp /tmp/
COPY oraInst.loc /etc/
COPY sysctl.conf /etc/

RUN useradd -d /oracle oracle \
    && echo "oracle:oracle" | chpasswd \
    && chown -R oracle:oracle /tmp/ohs \
    && chown oracle:oracle /tmp/ohs.rsp \
    && chown oracle:oracle /etc/oraInst.loc \
    && chmod 664 /etc/oraInst.loc \
    && touch /etc/profile.d/ohs.sh \
    && chmod 0755 /etc/profile.d/ohs.sh \
    && echo "export ORACLE_INSTANCE=/oracle/Middleware/Oracle_WT1/instances/instance1" >> /etc/profile.d/ohs.sh

USER oracle

ENV ORACLE_INSTANCE /oracle/Middleware/Oracle_WT1/instances/instance1

RUN cd /tmp/ohs/Disk1 \
    && ./runInstaller -silent -waitforcompletion -force -ignoreSysPrereqs -response /tmp/ohs.rsp \
    && cd /oracle/Middleware/Oracle_WT1/opmn/bin \
    && ./opmnctl stopall

USER root

RUN rm -rf \
    /tmp/ohs \
    /tmp/ohs.rsp \
    /tmp/OraInstall* \
    /tmp/hsperfdata_oracle \
    /tmp/tmpInvPtrLoc*

COPY entrypoint.sh /oracle/

RUN chown oracle:oracle /oracle/entrypoint.sh \
    && chmod +x /oracle/entrypoint.sh

EXPOSE 7777

USER oracle

WORKING_DIR /oracle/Middleware/Oracle_WT1/opmn/bin

ENTRYPOINT ["/bin/bash"]
#ENTRYPOINT ["/oracle/entrypoint.sh"]
