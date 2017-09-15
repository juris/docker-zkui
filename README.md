# docker-zkui
Docker image with zkui

Easy way to run a container:
`docker run --rm -p 9090:9090 -e ZK_SERVER=zookeeper:2181 juris/zkui`

Multiple zk instances are coma separated. eg: `zookeeper1:2181,zookeeper2:2181`. First server should always be the leader.
