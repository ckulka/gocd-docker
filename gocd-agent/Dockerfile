# Set the base image to gocd/gocd-server
FROM gocd/gocd-agent

# File Author / Maintainer
MAINTAINER CKulka

## BEGIN INSTALLATION

# Install SVN
RUN apt-get update && apt-get install -y -q subversion

# Install Java 8 JDK, Remove Java 7 JRE
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
RUN apt-add-repository -y ppa:webupd8team/java && apt-get install -y -q oracle-java8-installer
RUN update-java-alternatives -s java-8-oracle && apt-get install -y oracle-java8-set-default
RUN apt-get remove -y -q openjdk-7-jre-headless
RUN sed -i '/JAVA_HOME/c\JAVA_HOME="/usr/bin/java"' go-agent

# Install Maven3
RUN curl http://mirror.nexcess.net/apache/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz | tar -xz -C /usr/share
RUN ln -s /usr/share/apache-maven-3.3.3/bin/mvn /usr/bin/mvn
RUN curl -o /usr/share/apache-maven-3.3.3/conf/settings.xml http://pbwebtest01.wlgore.com:9010/download/attachments/2523305/settings.xml


## IMAGE CLEANUP

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
