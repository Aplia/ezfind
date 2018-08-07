FROM debian:jessie
MAINTAINER Aplia
LABEL solr.version=4.10.1

ENV DEBIAN_FRONTEND noninteractive

# Base packages
# -----------------------------------------------------------------------------
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -qqy \
    openjdk-7-jre-headless

COPY ./bin/scripts/docker/solr /etc/init.d/solr
RUN chmod 755 /etc/init.d/solr

run mkdir -p /opt/solr/cores
run mkdir /opt/solr/data
run mkdir /opt/solr/logs
COPY ./java /opt/solr/java

# -----------------------------------------------------------------------------

# Clear archives in apt cache folder
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

COPY bin/scripts/bootstrap.sh /opt/bootstrap.sh
RUN chmod 755 /opt/bootstrap.sh

EXPOSE 8983

WORKDIR /opt/solr

CMD ["/opt/bootstrap.sh"]
