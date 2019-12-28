FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -yq --no-install-recommends apache2 php7.2 php7.2-mysql php7.2-dom php7.2-curl php7.2-zip
RUN a2enmod ssl rewrite php7.2
COPY ./extra-conf.ini /etc/php/7.2/apache2/conf.d/extra-conf.ini
CMD service apache2 start && tail -F /var/log/apache2/error.log
