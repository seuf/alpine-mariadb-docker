FROM alpine:edge

#Setting up Environment
ENV MYSQL_USER=mysql \
    MYSQL_DATA_DIR=/var/lib/mysql


#Install Mariadb
RUN apk --update upgrade
RUN apk add bash
RUN apk add mariadb mariadb-client 

#Remove Cache
RUN rm -rf /var/cache/apk/*

#Setting up EntryPoint
COPY init_mysql /sbin/init_mysql
RUN chmod 755 /sbin/init_mysql

#Expose TCP 3306
EXPOSE 3306/tcp

#Setting up Mariadb Data dir and Mariadb Run directory
VOLUME ["${MYSQL_DATA_DIR}"]

#Entrypoint
ENTRYPOINT ["/sbin/init_mysql"]

#CMD
CMD ["/usr/bin/mysqld_safe"]
