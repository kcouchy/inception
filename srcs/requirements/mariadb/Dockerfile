FROM debian:bullseye

RUN     apt-get update && apt-get upgrade -y && \
        apt-get install apt-utils       \
                        mariadb-server   \
                        curl            \
                        vim             \
                        -y

RUN     mkdir -p /run/mysqld/
RUN     chown -R mysql:mysql /run/mysqld/

COPY    conf/50-server.conf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY    conf/run_mariadb.sh /run_mariadb.sh

#give execution rights to the shell script and create database
RUN     chmod u+x /run_mariadb.sh
RUN     mariadb-install-db

#run mariadb setup script
ENTRYPOINT /run_mariadb.sh