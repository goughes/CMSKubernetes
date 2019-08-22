FROM wmagentdb:20190807

ENV WDIR=/data/srv
RUN mkdir -p $WDIR

RUN yum clean all

# WMAgent dependencies
RUN yum -y install python2-pip python-virtualenv gcc libcurl-devel jemalloc

ENV ORACLE_HOME=/data/srv/db/oracle

# Build configuration for pip, needed for oracle include dir
ADD pydistutils.cfg /root/.pydistutils.cfg

# Add install script
ADD install.sh ${WDIR}/install.sh

WORKDIR ${WDIR}

RUN ${WDIR}/install.sh

RUN echo "Installation completed!"

RUN rm /root/.pydistutils.cfg

ENTRYPOINT ["/bin/bash"]
