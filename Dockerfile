FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -yq --no-install-recommends apache2 php7.3 php7.3-mysql php7.3-dom php7.3-curl php7.3-zip
RUN a2enmod ssl rewrite php7.3
COPY ./extra-conf.ini /etc/php/7.3/apache2/conf.d/extra-conf.ini
CMD service apache2 start && tail -F /var/log/apache2/error.log
