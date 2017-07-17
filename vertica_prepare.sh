#!/bin/bash

# Install ODBC linux support
sudo apt-get install -y unixodbc-dev

# Download Vertica ODBC Driver
sudo mkdir -p /opt/vertica
sudo chown datascience:datascience -R /opt/vertica/
wget https://my.vertica.com/client_drivers/8.1.x/8.1.1-0/vertica-client-8.1.1-0.x86_64.tar.gz -O - | tar -xvz -C /

# Download vertica spark connector
sudo wget --no-check-certificate https://github.com/msmluca/vertica/raw/master/vertica-8.1.1_spark2.1_scala2.11-20170623.jar -O /opt/vertica/java/lib/vertica-8.1.1_spark2.1_scala2.11-20170623.jar
sudo chown datascience:datascience -R /opt/vertica/*


# Configure Spark
{
echo 'spark.jars /opt/vertica/java/lib/vertica-jdbc.jar,/opt/vertica/java/lib/vertica-8.1.1_spark2.1_scala2.11-20170623.jar'
echo 'spark.io.compression.codec org.apache.spark.io.SnappyCompressionCodec'
} > /usr/local/spark-2.1.0-bin-without-hadoop/conf/spark-defaults.conf


# Create Folder for Vertica
mkdir ~/VerticaDocker

#
# Run Vertica with
#
# docker run -p 5433:5433 -v ~/VerticaDocker:/home/dbadmin/docker jbfavre/vertica:8.10-1_ubuntu-14.04
# 
# Resume docker container with
# docker ps -a # shows list of containers
# docker start CONTAINER_ID
