FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -yq --no-install-recommends apache2 php7.2 php7.2-mysql php7.2-dom php7.2-curl php7.2-zip curl ca-certificates xz-utils libfontconfig1 libxrender1 libxext6
RUN a2enmod ssl rewrite php7.2
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN php -r "copy('https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz', 'wkhtmltox-0.12.4_linux-generic-amd64.tar.xz');" 
RUN tar xvf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
RUN mv wkhtmltox/bin/wkhtmlto* /usr/bin 
COPY ./extra-conf.ini /etc/php/7.2/apache2/conf.d/extra-conf.ini
CMD service apache2 start && tail -F /var/log/apache2/error.log
