FROM debian:bullseye

RUN     apt-get update && apt-get upgrade -y
RUN     apt-get install                 \
                        # apt-utils       \
                        # curl            \
                        # vim             \
                        mariadb-server  \
                        -y

RUN     mkdir -p /run/mysqld/
RUN     chown -R mysql:mysql /run/mysqld/

COPY    conf/50-server.conf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY    conf/config_mariadb.sh /config_mariadb.sh

#give execution rights to the shell script and create database
RUN     chmod u+x /config_mariadb.sh
RUN     mariadb-install-db

#run mariadb setup script
ENTRYPOINT /config_mariadb.sh