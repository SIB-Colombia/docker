FROM java:8

MAINTAINER Valentina Grajales Olarte <valegrajales@gmail.com>

## Version
ENV NEXUS_MAJOR   		3.0
ENV NEXUS_VERSION 		3.0.0-03
ENV NEXUS_DOMAIN			localhost
ENV NEXUS_IP_ADDRESS	192.168.11.78
ENV SSL_PORT					18443

## Packages
RUN \
  mkdir -p /usr/share/nexus &&\
  mkdir -p /var/lib/nexus   &&\
  curl -fsSL "http://download.sonatype.com/nexus/3/nexus-${NEXUS_VERSION}-unix.tar.gz" | tar -zxvf - --strip-components=1 -C /usr/share/nexus &&\
  mkdir -p /usr/share/nexus/etc/ssl &&\
  cd /usr/share/nexus/etc/ssl &&\
  keytool -genkeypair -keystore keystore.jks -storepass password -keypass password -alias jetty -keyalg RSA -keysize 2048 -validity 5000 -dname "CN=*.${NEXUS_DOMAIN}, OU=Example, O=Sonatype, L=Unspecified, ST=Unspecified, C=US" -ext "SAN=DNS:${NEXUS_DOMAIN},IP:${NEXUS_IP_ADDRESS}" -ext "BC=ca:true"

## Environments
ENV PATH /usr/share/nexus/bin:$PATH

COPY org.sonatype.nexus.cfg /usr/share/nexus/etc/org.sonatype.nexus.cfg
COPY jetty-https.xml /usr/share/nexus/etc/jetty-https.xml

EXPOSE 8081 18443

VOLUME ["/usr/share/nexus/data"]

CMD ["nexus", "run"]