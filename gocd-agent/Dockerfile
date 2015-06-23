# Set the base image to gocd/gocd-server
FROM gocd/gocd-agent:latest

# File Author / Maintainer
MAINTAINER CKulka

## BEGIN INSTALLATION

# Install Java 8 JDK, Remove Java 7 JRE
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
RUN apt-add-repository -y ppa:webupd8team/java && apt-get update && apt-get install -y -q oracle-java8-installer
RUN update-java-alternatives -s java-8-oracle && apt-get install -y oracle-java8-set-default
RUN apt-get remove -y -q openjdk-7-jre-headless
RUN sed -i '/JAVA_HOME/c\JAVA_HOME="/usr/lib/jvm/java-8-oracle"' /etc/default/go-agent

# Install SVN
RUN apt-get install -y -q subversion mercurial

# Install Maven3
ENV mavenVersion 3.3.3
RUN curl http://mirror.nexcess.net/apache/maven/maven-3/${mavenVersion}/binaries/apache-maven-${mavenVersion}-bin.tar.gz | tar -xz -C /usr/share
RUN ln -s /usr/share/apache-maven-${mavenVersion}/bin/mvn /usr/bin/mvn


## IMAGE CLEANUP

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
