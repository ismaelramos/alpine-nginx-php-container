FROM alpine:3.12.3
RUN apk update && apk upgrade
RUN apk add nginx --no-cache
RUN apk add php7 php7-fpm php7-opcache && apk add php7-mysqli php7-curl php7-gd php7-zlib --no-cache
RUN mkdir /run/nginx && touch /run/nginx/nginx.pid && mkdir /var/www/html && rm -R /var/www/localhost && mkdir /docker-entrypoint.d
COPY default.conf /etc/nginx/conf.d/
COPY docker-entrypoint.sh /
COPY 10-listen-on-ipv6-by-default.sh /docker-entrypoint.d
COPY 20-envsubst-on-templates.sh /docker-entrypoint.d
RUN chmod 775 /docker-entrypoint.sh && chmod 775 /docker-entrypoint.d/20-envsubst-on-templates.sh  && chmod 775 /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
CMD ["nginx"]