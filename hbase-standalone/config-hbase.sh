

export HBASE_MANAGES_ZK=true
export HBASE_DISABLE_HADOOP_CLASSPATH_LOOKUP=true


# Set Java home for hbase servers
sed -i "s,^. export JAVA_HOME.*,export JAVA_HOME=$JAVA_HOME," /hbase/conf/hbase-env.sh

# Set Java home for hbase servers
sed -i "s,^. export HBASE_MANAGES_ZK.*,export HBASE_MANAGES_ZK=$HBASE_MANAGES_ZK," /hbase/conf/hbase-env.sh