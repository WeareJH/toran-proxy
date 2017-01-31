FROM php:7.0-fpm
MAINTAINER Michael Woodward <michael@wearejh.com>

ARG VERSION=1.5.3

RUN apt-get update && apt-get install -y \
    cron \
    gettext \
    git

RUN rm -rf /var/www/* \
    && curl -sL https://toranproxy.com/releases/toran-proxy-v${VERSION}.tgz | tar xzC /tmp \
    && mv /tmp/toran/* /var/www \
    && chown www-data:www-data /var/www/app/bootstrap.php.cache \
    && mv /var/www/app/config/parameters.yml.dist /var/www/app/config/parameters.yml

COPY config/toran/bin/toran-configure /usr/local/bin/

RUN chmod +x /usr/local/bin/toran-configure /var/www/app/console /var/www/bin/cron

COPY config/toran/auth.json.template /var/www/app/toran/composer/auth.json.template

RUN mkdir /var/www/repos && chown www-data:www-data /var/www/repos

RUN echo "* * * * * cd /var/www && /usr/local/bin/php bin/cron" | crontab -u www-data -

ENTRYPOINT ["toran-configure"]
CMD ["php-fpm"]

