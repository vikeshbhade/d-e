#!/bin/bash

echo "Starting SSH..."
service ssh start

echo "Formatting HDFS if not already done..."
if [ ! -d "/tmp/hadoop-root" ]; then
  $HADOOP_HOME/bin/hdfs namenode -format
fi

echo "Starting Hadoop..."
$HADOOP_HOME/sbin/start-dfs.sh
$HADOOP_HOME/sbin/start-yarn.sh

echo "Starting Spark..."
$SPARK_HOME/sbin/start-master.sh
$SPARK_HOME/sbin/start-worker.sh spark://localhost:7077

echo "All services started. Container is ready."

# Keep container alive
exec /bin/bash
