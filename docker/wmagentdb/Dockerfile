FROM cmssw/cmsweb:20190710

ENV WDIR=/data

# Install oracle client
ADD install.sh $WDIR/install.sh
RUN sh $WDIR/install.sh
RUN rm -f $WDIR/install.sh

# Install mariadb
RUN yum clean all
# mariadb-devel provides mysql_config
# not necessary if we can install mariadb package from comp repos
RUN yum -y install mariadb mariadb-devel

#Finished
