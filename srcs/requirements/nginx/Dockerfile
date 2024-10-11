FROM debian:bullseye

RUN     apt-get update && apt-get upgrade -y && \
        apt-get install apt-utils   \
                        nginx   \
#                        curl    \
#                        vim     \
                        openssl \
                        -y

RUN     mkdir -p    /etc/nginx/ssl \
                    /var/run/nginx

#replacing default server config with mine
RUN     rm -rf /etc/nginx/sites_enabled/default
COPY    conf/inception /etc/nginx/sites-enabled/inception
#TODO overwrite older conf file instead of deleting and replacing
#COPY conf/nginx.conf /etc/nginx/sites-enabled/nginx.conf

#default port to access the internets
EXPOSE  443

#restricts read and write perms for other users, changes ownership recursively to the server default user(all subfiles and folders)
RUN     chmod 755 /var/www/html
RUN     chown -R www-data:www-data /var/www/html

#setting up the ssl certificate without needing prompts
RUN     openssl req -x509 -sha256 -nodes \
            -out /etc/nginx/ssl/inception.crt \
            -keyout /etc/nginx/ssl/inception.key \
            -subj "/C=FR/ST=IDF/L=LeHavre/O=42/OU=42/CN=kcouchma.42.fr/UID=kcouchma"

#runs nginx server in foreground, container therefore stays open as long as NGINX is running
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]