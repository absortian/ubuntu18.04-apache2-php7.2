FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -yq --no-install-recommends fontconfig xfonts-base libssl-dev xfonts-75dpi apache2 php7.2 php7.2-mysql php7.2-dom php7.2-curl php7.2-zip curl ca-certificates xz-utils libfontconfig1 libxrender1 libxext6 wget
RUN a2enmod ssl rewrite php7.2
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN wget http://ftp.br.debian.org/debian/pool/main/libj/libjpeg-turbo/libjpeg62-turbo_1.5.2-2+b1_amd64.deb
RUN wget http://ftp.br.debian.org/debian/pool/main/g/glibc/libc6_2.28-10_amd64.deb
RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.buster_amd64.deb
RUN dpkg -i libjpeg62-turbo_1.5.2-2+b1_amd64.deb
RUN dpkg -i libc6_2.28-10_amd64.deb
RUN dpkg -i wkhtmltox_0.12.5-1.buster_amd64.deb
COPY ./extra-conf.ini /etc/php/7.2/apache2/conf.d/extra-conf.ini
CMD service apache2 start && tail -F /var/log/apache2/error.log
