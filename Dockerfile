FROM ubuntu:14.04
MAINTAINER Usman Ismail <usman@techtraits.com>
RUN apt-get -qq update
RUN apt-get install -y software-properties-common
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer
RUN apt-get -qq install wget
RUN mkdir -p /opt/sonatype-nexus /opt/sonatype-work /opt/sonatype-work/nexus
RUN ["wget", "-O", "/tmp/nexus-latest-bundle.tar.gz", "http://www.sonatype.org/downloads/nexus-latest-bundle.tar.gz"]
RUN tar -zxvf /tmp/nexus-latest-bundle.tar.gz -C /opt/sonatype-nexus --strip-components=1
RUN useradd --user-group --system --home-dir /opt/sonatype-nexus nexus
RUN chown -R nexus:nexus /opt/sonatype-work /opt/sonatype-nexus /opt/sonatype-work/nexus

USER nexus

CMD ["/opt/sonatype-nexus/bin/nexus","console"]
VOLUME /opt/sonatype-work
EXPOSE 8081
