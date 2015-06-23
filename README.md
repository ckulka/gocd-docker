
### Supported Tags

I follow the same naming scheme for the images as [gocd](https://registry.hub.docker.com/u/gocd/gocd-server/) themselves:
 - latest (corresponds to 15.1.0)
 - 15.1.0


###  Image Details

GoCD Server based on [gocd/gocd-server](https://registry.hub.docker.com/u/gocd/gocd-server/)
 - Added subversion & mercurial

GoCD Agent based on [gocd/gocd-agent](https://registry.hub.docker.com/u/gocd/gocd-agent/)
 - Replaced Java 7 JRE with Java 8 JDK
 - Added subversion & mercurial
 - Added Maven 3


### Usage

#### Build Docker Images

```
# Shell working directory is where this README.md is
docker build -t ckulka/gocd-server gocd-server
docker build -t ckulka/gocd-agent gocd-agent
```


#### Run GoCD Server & Agents

There are two ways to run the GoCD server and agents: using the service scripts and the manual way.


##### Service Script

The service script's intended use is for /etc/init.d and provides the usual commands:

```
# Shell working directory is where this README.md is
gocd-server/gocd-server.sh {start | stop | restart | status}
gocd-agent/gocd-agent.sh {start | stop | restart | status}
```

The ```gocd-agent.sh``` script assumes, that the GoCD Server is running on the same host and that its ports are exposed.


##### The Manual Way

Note that both ```docker run``` commands are running in the foreground, due to the conflicting ```-d``` and ```--rm``` flags.

```
# Create GoCD Server volume container with the name “go-server-data”
docker create --name gocd-server-data ckulka/gocd-server /bin/true

# Create GoCD Server container with the name “go-server”
docker run -p 8153:8153 --rm --name gocd-server --volumes-from go-server-data ckulka/gocd-server

# Create GoCD Agent container linked to our "go-server"
docker run -link gocd-server:go-server --rm ckulka/gocd-agent
```
