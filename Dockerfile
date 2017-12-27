FROM nginx:1.13.8-alpine

ENV NGINX_BASE_CONFIG_PATH=/etc/nginx/nginx.conf \
    NGINX_CONFIG_DIR=/etc/nginx/conf.d \
    NGINX_PAGES_DIR=/home/nginx/www

ADD ./entrypoint.sh /docker-entrypoint.sh
RUN chown nginx:nginx /docker-entrypoint.sh \
    && chmod 744 /docker-entrypoint.sh

ENTRYPOINT /docker-entrypoint.sh
