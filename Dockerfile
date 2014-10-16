FROM gregory90/java

RUN rm -fr zookeeper-3.4.6.tar.gz
RUN wget http://apache.mirrors.pair.com/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz
RUN tar -zxvf zookeeper-3.4.6.tar.gz -C /opt
RUN mkdir -p /var/lib/zookeeper

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper-3.4.6

ADD zoo.cfg /opt/zookeeper-3.4.6/conf/zoo.cfg
ADD run /opt/zookeeper-3.4.6/.docker/

CMD ["/opt/zookeeper-3.4.6/.docker/run"]

