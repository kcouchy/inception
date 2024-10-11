FROM debian:bullseye

RUN     apt-get update && apt-get upgrade -y
# installs wordpress tools(wget) php fast process manager and command line interface
RUN     apt-get install                 \
                        # apt-utils       \
                        # curl            \
                        # vim             \
                        wget            \
                        php             \
                        php-fpm         \
                        php-cli         \
                        php-mysql       \
                        mariadb-client  \
                        netcat          \
                        -y

#Creat var then changes ownership recursively to the server default user(all subfiles and folders)
RUN     mkdir -p /var/www/html

# Create directory for PHP-FPM socket
RUN     mkdir -p /run/php
RUN     chown -R www-data:www-data /run/php

# Get WordPress, decompress and then delete the tar
RUN     wget https://wordpress.org/latest.tar.gz -P /var/www/ && \
        tar -xvf /var/www/latest.tar.gz -C /var/www/html --strip-components=1 && \
        rm -rf /var/www/latest.tar.gz && \
        chown -R www-data:www-data /var/www/html

# Get command-line interface, decompress and then delete the tar
RUN     wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
        chmod +x wp-cli.phar && \
        mv wp-cli.phar /usr/local/bin/wp

# overwrite php-fpm conf file to listen on 9000, and expose 9000 on the container
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
EXPOSE 9000

#copy over config script and give permissions
COPY    conf/config_wp.sh /config_wp.sh
RUN     chmod u+x /config_wp.sh

ENTRYPOINT /config_wp.sh