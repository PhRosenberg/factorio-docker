#!/bin/bash
set -eu

mkdir -p /factorio/config /factorio/mods /factorio/saves /factorio/scenarios

if [[ ! -f /opt/factorio/config/map-gen-settings.json ]]; then
    echo "/opt/factorio/data/map-gen-settings.json not found, copying example file"
    cp /opt/factorio/data/map-gen-settings.example.json /opt/factorio/config/map-gen-settings.json
fi

if [[ ! -f /opt/factorio/config/map-settings.json ]]; then
    echo "/opt/factorio/data/map-settings.json not found, copying example file"
    cp /opt/factorio/data/map-settings.example.json /opt/factorio/config/map-settings.json
fi

if [[ ! -f /opt/factorio/config/server-settings.json ]]; then
    echo "/opt/factorio/data/server-settings.json not found, copying example file"
    cp /opt/factorio/data/server-settings.example.json /opt/factorio/config/server-settings.json
fi

if [[ ! -f /opt/factorio/config/server-whitelist.json ]]; then
    echo "/opt/factorio/data/server-whitelist.json not found, copying example file"
    cp /opt/factorio/data/server-whitelist.example.json /opt/factorio/config/server-whitelist.json
fi

if [[ ! -f /opt/factorio/config/server-adminlist.json ]]; then
    echo "/opt/factorio/data/server-adminlist.json not found, copying example file"
    cp /opt/factorio/data/server-whitelist.example.json /opt/factorio/config/server-adminlist.json
fi

sed -i '/write-data=/c\write-data=\/factorio/' /opt/factorio/config/config.ini

if [[ ! -f /opt/factorio/saves/${SAVE} ]]; then
    echo "creating map ${SAVE}"
    /opt/factorio/bin/x64/factorio \
        --create "/factorio/saves/${SAVE}" \
        --map-gen-settings /factorio/config/map-gen-settings.json
fi

/opt/factorio/bin/x64/factorio \
    --start-server "/factorio/saves/${SAVE}" \
    --server-adminlist /factorio/config/server-adminlist.json \
    --server-settings /factorio/config/server-settings.json
