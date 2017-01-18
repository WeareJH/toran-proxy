FROM nginx:stable-alpine
MAINTAINER Michael Woodward <michael@wearejh.com>

RUN apk add --no-cache \
    apache2-utils

RUN rm /etc/nginx/conf.d/default.conf

COPY config/nginx/toran.conf /etc/nginx/conf.d/toran.conf
COPY config/nginx/bin/nginx-configure /usr/local/bin/

RUN chmod +x /usr/local/bin/nginx-configure

ENTRYPOINT ["/usr/local/bin/nginx-configure"]
CMD ["nginx", "-g", "daemon off;"]