#!/bin/bash

ln -s /factorio/config /opt/factorio
ln -s /factorio/data /opt/factorio
ln -s /factorio/saves /opt/factorio
ln -s /factorio/mods /opt/factorio
set -eu

# Create Map if it does not exist
if [[ ! -f /opt/factorio/saves/${SAVE} ]]; then
	echo creating map
	/opt/factorio/bin/x64/factorio \
		--create "/opt/factorio/saves/${SAVE}" \
        	--map-gen-settings /opt/factorio/config/map-gen-settings.json
fi
/opt/factorio/bin/x64/factorio \
	--start-server "/opt/factorio/saves/${SAVE}" \ 
	--server-adminlist /opt/factorio/config/server-adminlist.json \
	--server-settings /opt/factorio/config/server-settings.json
