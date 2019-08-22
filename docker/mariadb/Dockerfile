FROM oratest:20190807

ENV WDIR=/data

RUN yum clean all

# Install mariadb
# mariadb-devel provides mysql_config
# not necessary if we can install mariadb package from comp repos
RUN yum -y install mariadb mariadb-devel

#Finished
