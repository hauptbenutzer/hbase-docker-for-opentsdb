# Start with latest CentOS image
FROM centos

MAINTAINER Moritz Flucht m.flucht@gmail.com

# Switch to root user
USER root

# Update yum
RUN yum update -y

# Install tar
RUN yum install -y tar

# Install java
RUN yum install -y java-1.7.0-openjdk

## Install hbase from local
#ADD hbase-1.1.2-bin.tar.gz /usr/local/hbase

## Install hbase from apache
WORKDIR /usr/local/hbase
RUN curl -SsfLO "https://www.apache.org/dist/hbase/stable/hbase-1.1.5-bin.tar.gz"
RUN tar -xvzf /usr/local/hbase/hbase-1.1.5-bin.tar.gz

# Set JAVA_HOME (used by HBase)
ENV JAVA_HOME /usr/lib/jvm/jre-1.7.0-openjdk

# Add hbase to path
ENV PATH /usr/local/hbase/hbase-1.1.5/bin:$PATH

# Insert config file from local
ADD hbase-site.xml /usr/local/hbase/hbase-1.1.5/conf/hbase-site.xml

# Run opentsdb provisioning
WORKDIR /usr/local/cmls
ADD provisioning.sh /usr/local/cmls/provisioning.sh
RUN /usr/local/cmls/provisioning.sh

# EXPOSE PORTS
# zookeeper
EXPOSE 2181

# hbase.master.port
EXPOSE 16000

# hbase.master.info.port (http)
EXPOSE 16010

# hbase.regionserver.port
EXPOSE 16020

# hbase.regionserver.info.port (http)
EXPOSE 16030

# hbase.rest.port
EXPOSE 8080

# Start HBase
CMD hbase master start