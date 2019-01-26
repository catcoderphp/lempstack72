FROM ubuntu:18.04
RUN apt-get update
RUN apt-get install -y tzdata
RUN ln -fs /usr/share/zoneinfo/America/Mexico_City /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN apt-get dist-upgrade -y
RUN apt-get install -y  curl \ 
    build-essential tcl \
    unzip \
    nginx \
    libcurl4 \
    php-redis \
    php7.2-cli \
    php7.2-cgi \
    php7.2-dev \
    php7.2-json \
    php7.2-mysql \
    php7.2-xml \
    php7.2-gd \
    php7.2-common \
    php7.2-curl \
    supervisor \
    php7.2-bcmath \
    php7.2-bz2 \
    php7.2-enchant \
    php7.2-fpm \
    php7.2-imap \
    php7.2-interbase \
    php7.2-dba \
    php7.2-phpdbg \
    php7.2-soap \
    php7.2-xsl \
    php7.2-zip \
    php7.2-sybase \
    php7.2-mbstring \
    php-memcached memcached \
    nano \ 
    git \
    vim 
ENV MYSQL_PWD cfh23
RUN echo "mysql-server mysql-server/root_password password $MYSQL_PWD" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password $MYSQL_PWD" | debconf-set-selections
RUN apt-get -y install mysql-server 
RUN useradd -s /bin/bash sites
RUN mkdir -p /var/www/sites/web
ADD conf/supervisord.conf /etc/supervisord.conf
ADD start.sh /start.sh
RUN chmod 777 /start.sh
ADD index.php /var/www/sites/web
ADD site /etc/nginx/sites-available/
RUN rm -r /etc/nginx/sites-enabled/default
RUN ln -s /etc/nginx/sites-available/site /etc/nginx/sites-enabled/
#CREATING A SOCKET FILE TO START FPM FROM SUPERVISORD
RUN service php7.2-fpm start
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
ADD php-fpm  /var/log/ 
CMD ["/bin/bash","start.sh"]
MAINTAINER "Christian Fuentes" <Christian.fuentes.234@gmail.com>
MAINTAINER "Jose Luis Gomez Jaen" <catcoder.php@gmail.com>
