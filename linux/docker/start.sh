#!/bin/bash

HOME=/var/lib/ice/icegrid

start_registry() {
	mkdir -p $HOME/data/registry || sleep 0
	/usr/bin/icegridregistry \
		"--Ice.Config=$HOME/icegridregistry.conf" \
		"--IceGrid.Registry.LMDB.Path=$HOME/data/registry"
}

start_node() {
	local index=$1
	mkdir -p $HOME/data/node-$index || sleep 0
	chown --from=root ice $HOME/server.jar
	# echo cp "$HOME/server.jar" "~/server.jar"
	/usr/bin/icegridnode \
		"--Ice.Config=$HOME/icegridnode.conf" \
		"--IceGrid.Node.Name=node$index" \
		"--IceGrid.Node.Data=$HOME/data/node-$index" \
		"--IceGrid.Node.Output=$HOME/data/node-$index"
}

deploy() {
	/usr/bin/icegridadmin \
		"--Ice.Config=$HOME/icegridregistry.conf" \
		-u admin -p admin \
		-e "application add $HOME/app.xml"
}

start_node_server() {
	local index=$1
	/usr/bin/icegridadmin "--Ice.Config=$HOME/icegridregistry.conf" \
		-u admin -p admin \
		-e "server start PrinterServer-$index"
}

start_registry &
sleep 5
start_node 1 &
start_node 2 &
sleep 5
deploy
start_node_server 1
start_node_server 2
