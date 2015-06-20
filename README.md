#### Dockerfiles

GoCD Server based on gocd/gocd-server (https://github.com/gocd/gocd-docker)
 - Added subversion

GoCD Agent based on gocd/gocd-agent (https://github.com/gocd/gocd-docker)

- Replaced Java 7 JRE with Java 8 JDK
- Added subversion
- Added Maven 3


#### Build Docker Images

```
# Shell working directory is where this README.md is
docker build -t ckulka/gocd-server gocd-server
docker build -t ckulka/gocd-agent gocd-agent
```


#### Run GoCD Server & Agents

Note that both ```docker run``` commands are both running in the foreground, due to the conflicting -d and --rm flags.

```
# Create GoCD Server volume container with the name “go-server-data”
docker create --name go-server-data ckulka/gocd-server /bin/true

# Create GoCD Server container with the name “go-server”
docker run -p 8153:8153 --rm --name go-server --volumes-from go-server-data ckulka/gocd-server

# Create GoCD Agent container linked to our "go-server"
docker run -link go-server:go-server --rm ckulka/gocd-agent
```
