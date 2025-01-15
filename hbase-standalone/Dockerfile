#
#  Author: Jannick Kappelmann (jannick.kappelmann@massflows.de)
#  vim:ts=4:sts=4:sw=4:et
#

FROM ubuntu:22.04

ARG HBASE_VERSION=2.6.1

ARG DOWNLOAD_URL=https://archive.apache.org/dist/hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-hadoop3-bin.tar.gz

LABEL org.opencontainers.image.description="HBase" \
      org.opencontainers.image.version="$HBASE_VERSION" \
      org.opencontainers.image.authors="Jannick Kappelmann"

ENV PATH $PATH:/hbase/bin

ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

ENV LD_LIBRARY_PATH=/hadoop/lib/native
ENV HBASE_LIBRARY_PATH=/hadoop/lib/native

ENV HADOOP_COMMON_LIB_NATIVE_DIR = /hadoop/lib/native
ENV JAVA_LIBRARY_PATH=/hadoop/lib/native:$JAVA_LIBRARY_PATH

ENV HADOOP_HOME=/hadoop
ENV HBASE_HOME=/hbase


WORKDIR /

RUN apt-get update && apt-get install wget tar netcat openjdk-17-jdk libsnappy-java libsnappy-dev -y && \
    wget -t 10 --max-redirect 1 --retry-connrefused -O "hbase-$HBASE_VERSION-bin.tar.gz" "$DOWNLOAD_URL" && \
    mkdir "hbase-$HBASE_VERSION" && \
    mkdir "hadoop" && \
    mkdir "hadoop/lib" && \
    mkdir "hadoop/lib/native" && \
    tar zxf "hbase-$HBASE_VERSION-bin.tar.gz" -C "hbase-$HBASE_VERSION" --strip 1 && \
    ln -sv "hbase-$HBASE_VERSION" hbase && \
    ln -sf "/usr/lib/x86_64-linux-gnu/libsnappy.so" "/hadoop/lib/native/" && \
    ln -sf "/usr/lib/x86_64-linux-gnu/libsnappy.a" "/hadoop/lib/native/" && \
    rm -fv "hbase-$HBASE_VERSION-bin.tar.gz" && \
    rm -rf hbase/docs hbase/src && \
    mkdir /hbase-data

COPY entrypoint.sh /
COPY conf/hbase-site.xml /hbase/conf/
COPY config-hbase.sh /build/
COPY profile.d/java.sh /etc/profile.d/

RUN chmod +x /entrypoint.sh && chmod +x /build/config-hbase.sh && chmod +x /etc/profile.d/java.sh

RUN /build/config-hbase.sh


# Stargate  8080  / 8085
# Thrift    9090  / 9095
# HMaster   16000 / 16010
# RS        16201 / 16301
EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
