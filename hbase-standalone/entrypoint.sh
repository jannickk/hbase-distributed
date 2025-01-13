#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#

set -x
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x


export HBASE_HOME="/hbase"
export JAVA_HOME="${JAVA_HOME:-/usr}"

echo "================================================================================"
echo "                              HBase Docker Container"
echo "================================================================================"
echo
# shell breaks and doesn't run zookeeper without this
mkdir -pv "$HBASE_HOME/logs"


start_master(){
    echo "Starting HBase Master..."
    "$HBASE_HOME/bin/hbase-daemon.sh" start master
    echo
}

start_stargate(){
    # kill any pre-existing rest instances before starting new ones
    pgrep -f proc_rest && pkill -9 -f proc_rest
    echo "Starting HBase Stargate Rest API server..."
    "$HBASE_HOME/bin/hbase-daemon.sh" start rest
    echo
}


start_master
start_stargate

wait || :
