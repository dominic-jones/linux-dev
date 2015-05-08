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

ideaDir=idea-IU-141.713.2
ideaVer=ideaIU-14.1.2
pushd ~/apps > /dev/null
if [ ! -d ~/apps/$ideaDir ]
then
	wget https://download.jetbrains.com/idea/$ideaVer.tar.gz
	tar xvf $ideaVer.tar.gz
	rm $ideaVer.tar.gz
	ln -s $ideaDir/bin/idea.sh idea
fi

smartGitVer=6_5_7
smartGitTar=smartgit-generic-$smartGitVer.tar.gz
smartGitUrl=http://www.syntevo.com/downloads/smartgit/$smartGitTar
smartGitDir=smartgit-generic-$smartGitVer
if [ ! -d ~/apps/$smartGitDir ]
then
	rm smartgit
	echo "SmartGit not detected, downloading."
	wget $smartGitUrl
	echo "Extracting SmartGit"
	tar xvf $smartGitTar
	mv smartgit $smartGitDir
	echo "Removing SmartGit tar"
	rm $smartGitTar
	ln -s $smartGitDir/bin/smartgit.sh smartgit
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
