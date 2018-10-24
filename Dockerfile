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

#Configuration
COPY mariadb-server.cnf /etc/mysql/mariadb-server.cnf
COPY mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

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
CMD ["/usr/bin/mysqld_safe", "--bind-address=0.0.0.0", "--port=3306"]
