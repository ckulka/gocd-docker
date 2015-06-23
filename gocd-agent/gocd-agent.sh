#!/bin/bash

### BEGIN INIT INFO
# Provides:           gocd-agent
# Required-Start:     $network docker
# Required-Stop:      
# Should-Start:       
# Should-Stop:        
# Default-Start:      2 3 4 5
# Default-Stop:       0 1 6
# Short-Description:  GoCD docker agent container
### END INIT INFO

# Docker image that is used
IMAGE="ckulka/gocd-agent:latest"

# Number of GoCD Agents to spawn
AGENT_COUNT="1 2"

# Address of the GoCD Server
GO_SERVER=$(hostname  -I | cut -f1 -d' ')

start() {
	for IDX in $AGENT_COUNT 
	do
		echo -n "Spawning new GoCD Agent $IDX for $GO_SERVER: "
		docker run -d -e GO_SERVER=$GO_SERVER $IMAGE
	done
}

stop() {
	echo "Stopping GoCD Server & removing old runtime container: $NAME"
	CONTAINER_IDS=$(docker ps | grep ckulka/gocd-agent | sed -rn 's/^([^ ]+) .*/\1 /p')
	docker stop $CONTAINER_IDS && docker rm $CONTAINER_IDS
}

restart() {
	silentStatus && stop
	start
}

status() {
	docker inspect $(docker ps | grep ckulka/gocd-agent | sed -rn 's/^([^ ]+) .*/\1 /p')
}

silentStatus() {
	docker inspect $(docker ps | grep ckulka/gocd-agent | sed -rn 's/^([^ ]+) .*/\1 /p') &> /dev/null
}

case "$1" in
	start)
		silentStatus || $1
		;;
	stop)
		silentStatus || exit 0
		$1
		;;
	restart)
		$1
		;;
	status)
		$1
		;;
	*)
		echo "Usage: $0 {start | stop | status}"
		exit 2
		;;
esac

exit $?
