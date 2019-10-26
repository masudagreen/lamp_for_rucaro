FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive \
TZ=Asia/Tokyo


RUN apt-get update && apt-get install -y software-properties-common \
&& add-apt-repository ppa:ondrej/php \
&& add-apt-repository ppa:ondrej/apache2 \
&& apt-get update && apt-get install -y php5.6 \  
php5.6-mbstring \
php5.6-mysqli \
php5.6-xml \
php5.6-curl \
wget \
unzip \
less \
vim \
git \
apache2 \
mysql-server \
mysql-client \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*


RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.1/phpMyAdmin-4.9.1-all-languages.zip -O phpmyadmin.zip \
&& mv phpmyadmin.zip /var/www/html \
&& cd /var/www/html \
&& unzip /var/www/html/phpmyadmin.zip \
&& mv phpMyAdmin-4.9.1-all-languages phpmyadmin


RUN cd /var/www/html \
&& git clone https://github.com/masudagreen/accounting.git \
&& chmod 777 -R /var/www/html/accounting


RUN echo "[mysqld]\ncharacter-set-server=utf8\n[client]\ndefault-character-set=utf8" > /etc/mysql/conf.d/chara.cnf && service mysql start && echo "create user 'rucaro'@'localhost' identified by 'rucaro';grant all privileges on *.* to 'rucaro'@'localhost';flush privileges;create database rucaro default character set=utf8;" | mysql -u root


CMD service mysql start && service apache2 start && /bin/bash

