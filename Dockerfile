FROM debian:jessie
MAINTAINER Dariusz Gafka dgafka.mail@gmail.com
ENV NOTVISIBLE "in users profile"
RUN apt-get update -y && apt-get install curl supervisor -y
RUN curl http://download.geteventstore.com/binaries/EventStore-OSS-Ubuntu-14.04-v3.4.0.tar.gz | tar xz -C /opt

RUN echo "export VISIBLE=now" >> /etc/profile

ADD ./docker/supervisord/eventstore.conf /etc/supervisor/conf.d/eventstore.conf

EXPOSE 2113
EXPOSE 1113
EXPOSE 9001

VOLUME /data/db
VOLUME /data/logs

CMD ["supervisord", "-n"]