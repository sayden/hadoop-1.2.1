#! /bin/bash

#Check if the JAVA_HOME is set and set it if not
if grep -q "^export JAVA_HOME" ~/.bashrc; then
	echo 'JAVA_HOME already set'
else
	echo 'JAVA_HOME not set'
	echo 'export JAVA_HOME=/usr/lib/jvm/java-openjdk' >> ~/.bashrc
	source ~/.bashrc
fi

#Check if the HADOOP_INSTALL is set and set it if not
if grep -q "^export HADOOP_INSTALL" ~/.bashrc; then
	echo 'HADOOP_INSTALL already set'
else
	echo 'HADOOP_INSTALL not set'
	echo 'export HADOOP_INSTALL=/var/hadoop' >> ~/.bashrc
	source ~/.bashrc
fi

#Check if the HADOOP_CONF_DIR is set and set it if not
if grep -q "^export HADOOP_CONF_DIR" ~/.bashrc; then
	echo 'HADOOP_CONF_DIR already set'
else
	echo 'HADOOP_CONF_DIR not set'
	echo 'export HADOOP_CONF_DIR=/var/hadoop/conf' >> ~/.bashrc
	source ~/.bashrc
fi

#Check if the HIVE_HOME is set and set it if not
if grep -q "^export HIVE_HOME" ~/.bashrc; then
	echo 'HIVE_HOME already set'
else
	echo 'HIVE_HOME not set'
	echo 'export HIVE_HOME=${HADOOP_INSTALL}/hive' >> ~/.bashrc
	source ~/.bashrc
fi

#Check if the PIG_HOME is set and set it if not
if grep -q "^export PIG_HOME" ~/.bashrc; then
	echo 'PIG_HOME already set'
else
	echo 'PIG_HOME not set'
	echo 'export PIG_HOME=${HADOOP_INSTALL}/pig' >> ~/.bashrc
	source ~/.bashrc
fi

#Check if the PIG_CLASSPATH is set and set it if not
if grep -q "^export PIG_CLASSPATH" ~/.bashrc; then
	echo 'PIG_CLASSPATH already set'
else
	echo 'PIG_CLASSPATH not set'
	echo 'export PIG_CLASSPATH=${HADOOP_CONF_DIR}' >> ~/.bashrc
	source ~/.bashrc
fi