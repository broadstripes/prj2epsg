FROM openjdk:8-jdk-stretch

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install maven

ADD ./pom.xml /build/pom.xml
ADD ./src /build/src

WORKDIR /build

RUN mvn install


FROM jetty:jre8

COPY --from=0 /build/target/prj2epsg-1.0-SNAPSHOT /var/lib/jetty/webapps/ROOT
