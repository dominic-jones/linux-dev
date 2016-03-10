#!/bin/bash

echo Installing from apt-get
sudo apt-get install geany chromium
echo

if type java >/dev/null 2>&1; then
	echo Java installation not detected
	pushd /usr/lib/jvm
	javaFile=jdk-8u73-linux-x64.tar.gz
	javaUrl=http://download.oracle.com/otn-pub/java/jdk/8u73-b02/$javaFile
	sudo wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" $javaUrl
	sudo tar xvf $javaFile
	sudo ln -s jdk1.8.0_73/bin/java java
	sudo ln -s /usr/lib/jvm/jdk1.8.0_73/bin/java /usr/bin/java
	popd
	echo
else
	echo Java installation detected
	echo
fi

if [ ! -d ~/apps ]
then
	mkdir ~/apps
fi

ideaDir=idea-IU-141.3056.4
ideaVer=ideaIU-14.1.6
pushd ~/apps > /dev/null
if [ -d ~/apps/$ideaDir ]
	echo IntelliJ not detected
	#wget https://download.jetbrains.com/idea/$ideaVer.tar.gz
	tar xvf $ideaVer.tar.gz
	rm $ideaVer.tar.gz
	rm idea
	ln -s $ideaDir/bin/idea.sh idea
	echo
then
	echo IntelliJ detected
	echo
fi

smartGitVer=6_5_7
smartGitTar=smartgit-generic-$smartGitVer.tar.gz
smartGitUrl=http://www.syntevo.com/downloads/smartgit/$smartGitTar
smartGitDir=smartgit-generic-$smartGitVer
if [ -d ~/apps/$smartGitDir ]
	rm smartgit
	echo "SmartGit not detected, downloading."
	wget $smartGitUrl
	echo "Extracting SmartGit"
	tar xvf $smartGitTar
	mv smartgit $smartGitDir
	echo "Removing SmartGit tar"
	rm $smartGitTar
	ln -s $smartGitDir/bin/smartgit.sh smartgit
then
	echo SmartGit detected
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
