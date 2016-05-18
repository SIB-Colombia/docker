FROM centos:7
MAINTAINER "Valentina Grajales" <valegrajales@gmail.com>

RUN yum -y update \
		&& yum -y install httpd php php-pgsql php-gd php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-snmp php-soap curl curl-devel wget \
		&& yum clean all \
		&& wget https://github.com/yiisoft/yii/releases/download/1.1.17/yii-1.1.17.467ff50.tar.gz \
		&& tar zxvf yii-1.1.17.467ff50.tar.gz \
		&& mv yii-1.1.17.467ff50/framework/ /var/www/ \
		&& chown -R root:root /var/www/framework/ \
		&& rm -rf yii-1.1.17.467ff50 yii-1.1.17.467ff50.tar.gz

EXPOSE 80

VOLUME ["/var/www/html"]

COPY run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

CMD ["/run-httpd.sh"]