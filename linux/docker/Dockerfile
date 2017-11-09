FROM ubuntu:16.04

MAINTAINER ZeroC, Inc. docker-maintainers@zeroc.com

ENV ICEGRID_VERSION 3.7.0

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv B6391CB2CFBA643D \
    && echo "deb http://download.zeroc.com/Ice/3.7/ubuntu16.04 stable main" >> /etc/apt/sources.list.d/ice.list \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
            zeroc-icegrid=${ICEGRID_VERSION}-*
	
RUN apt-get install -y openjdk-8-jre \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD start.sh /usr/bin/start-icegrid.sh

EXPOSE 4061 4062

VOLUME ["/var/lib/ice/icegrid"]

CMD /usr/bin/start-icegrid.sh