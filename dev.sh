#!/bin/bash

sudo apt-get install geany chromium

#if command -v java >/dev/null 2>&1; then
#	echo Java installation detected
#else
	pushd /usr/lib/jvm
	#sudo wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u45-b14/jdk-8u45-linux-x64.tar.gz
	#sudo tar xvf jdk-8u45-linux-x64.tar.gz
	sudo ln -s jdk1.8.0_45/bin/java java
	sudo ln -s /usr/lib/jvm/jdk1.8.0_45/bin/java /usr/bin/java
	popd
#fi

if [ ! -d ~/apps ]
then
	mkdir ~/apps
fi

pushd ~/apps > /dev/null
if [ ! -d ~/apps/idea-IU-141.178.9 ]
then
	wget https://download.jetbrains.com/idea/ideaIU-14.1.1.tar.gz
	tar xvf ideaIU-14.1.1.tar.gz
	rm ideaIU-14.1.1.tar.gz
	ln -s idea-IU-141.178.9/bin/idea.sh idea
fi

if [ ! -d ~/apps/apache-maven-3.3.1 ]
then
	wget http://mirror.csclub.uwaterloo.ca/apache/maven/maven-3/3.3.1/binaries/apache-maven-3.3.1-bin.tar.gz
	tar xvf apache-maven-3.3.1-bin.tar.gz
	rm apache-maven-3.3.1-bin.tar.gz
	ln -s apache-maven-3.3.1/bin/mvn mvn
fi

popd > /dev/null

cp .bashrc ~/.bashrc
