#!/bin/bash

HADOOP_DOWNLOAD_URL=http://mirror.cc.columbia.edu/pub/software/apache/hadoop/common/hadoop-2.9.2/hadoop-2.9.2.tar.gz

sudo apt update
sudo apt install -y openjdk-8-jdk

if [ ! -f /tmp/hadoop-2.9.2.tar.gz ]; then
	wget -P /tmp ${HADOOP_DOWNLOAD_URL}
fi

mkdir -p ~/apps
rm -rf ~/apps/hadoop*
tar xfz /tmp/hadoop-2.9.2.tar.gz -C ~/apps
ln -s ~/apps/hadoop-2.9.2 ~/apps/hadoop

sudo groupadd hadoop
sudo usermod -a -G hadoop ubuntu

cat<<\EOF >>~/.bashrc
#HADOOP VARIABLES START
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
export HADOOP_HOME=/home/ubuntu/apps/hadoop
export PATH=$PATH:$HADOOP_HOME/bin
export PATH=$PATH:$HADOOP_HOME/sbin
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
#HADOOP VARIABLES END
EOF

eval "$(cat ~/.bashrc | tail -n +12)"

hadoop version

cp etc/hadoop/*.xml ~/apps/hadoop/etc/hadoop/

echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh

sudo apt install -y ssh
ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

hdfs namenode -format

start-dfs.sh
start-yarn.sh
mr-jobhistory-daemon.sh start historyserver
jps

hdfs dfs -mkdir /user
hdfs dfs -mkdir /user/ubuntu

hdfs dfs -put $HADOOP_HOME/etc/hadoop input
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.9.2.jar grep input output 'dfs[a-z.]+'
hdfs dfs -cat output/*

