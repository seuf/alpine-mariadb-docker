FROM alpine:latest

#Install Mariadb
RUN apk --update upgrade && \
    apk add bash mariadb mariadb-client

#Remove Cache
RUN rm -rf /var/cache/apk/*

#Configuration
COPY mariadb-server.cnf /etc/mysql/mariadb-server.cnf
COPY mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

#Setting up EntryPoint
COPY init_mysql /sbin/init_mysql
RUN chmod 755 /sbin/init_mysql && mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

#RUN addgroup mysql && \
#    adduser  -h /var/lib/mysql -s /bin/bash -D mysql mysql && \
#    apk --update add mariadb mariadb-client


#Expose TCP 3306
EXPOSE 3306/tcp

#Setting up Mariadb Data dir and Mariadb Run directory
VOLUME ["/var/lib/mysql"]

#Entrypoint
ENTRYPOINT ["/sbin/init_mysql"]

#USER mysql
#CMD
CMD ["/usr/bin/mysqld_safe", "--bind-address=0.0.0.0", "--port=3306"]
#CMD ["tail", "-f", "/etc/hosts"]
