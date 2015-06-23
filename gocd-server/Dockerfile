# Set the base image to gocd/gocd-server
FROM gocd/gocd-server:latest

# File Author / Maintainer
MAINTAINER CKulka


## BEGIN INSTALLATION

# Remove 30s delay
ENV MSG_TIME 0

# Install SVN and mercurial
RUN apt-get update && apt-get install -y -q subversion mercurial


## IMAGE CLEANUP

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
