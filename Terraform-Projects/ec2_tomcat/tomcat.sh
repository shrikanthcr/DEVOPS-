#!/bin/bash
sudo su
yum update -y
yum install java-11 -y
wget https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.83/bin/apache-tomcat-8.5.83.tar.gz
tar -zvxf apache-tomcat-8.5.83.tar.gz
/home/ec2-user/apache-tomcat-8.5.83/bin/startup.sh
