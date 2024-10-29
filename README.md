# Apache HBase

https://hbase.apache.org/

Apache HBase NoSQL columnar datastore

Starts a single distributed HBase cluster including HBase Master, RegionServer, Thrift Server and Stargate Rest Server.

It uses a containerized hadoop hdfs deployment as persistent storage.

As there are a lot of dependencies between hdfs, zookeeper and a distributed hbase, you need to use
docker compose which starts all containers in the right order
