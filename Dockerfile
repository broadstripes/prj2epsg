FROM jetty
USER root

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install maven

ADD ./pom.xml /build/pom.xml
ADD ./src /build/src

WORKDIR /build

RUN mvn install

RUN cp -R target/prj2epsg-1.0-SNAPSHOT /var/lib/jetty/webapps/ROOT

WORKDIR /var/lib/jetty/

USER jetty
