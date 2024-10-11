FROM debian:bullseye

RUN     apt-get update && apt-get upgrade -y
RUN     apt-get install             \
                        # apt-utils   \
                        # curl        \
                        # vim         \
                        nginx       \
                        openssl     \
                        -y

RUN     mkdir -p    /etc/nginx/ssl \
                    /var/run/nginx

#replacing default server config with mine
RUN     rm -rf /etc/nginx/sites_enabled/default
COPY    conf/inception /etc/nginx/sites-available/inception
RUN     ln -s /etc/nginx/sites-available/inception /etc/nginx/sites-enabled/inception

#setting up the ssl certificate without needing prompts
RUN     openssl req -x509 -sha256 -nodes \
            -out /etc/nginx/ssl/inception.crt \
            -keyout /etc/nginx/ssl/inception.key \
            -subj "/C=FR/ST=NOR/L=LeHavre/O=42/OU=42/CN=kcouchma.42.fr/UID=kcouchma"

#runs nginx server in foreground, container therefore stays open as long as NGINX is running
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]