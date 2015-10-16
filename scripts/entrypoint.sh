#! /bin/bash
set -e

# EULA
if [ ! -f "$MC_HOME/eula.txt" ]; then
	: ${EULA:=false}

	if [ "$EULA" = "true" ]; then
		echo "# Docker on $(date)" > "$MC_HOME/eula.txt"
		echo "eula=$EULA" >> "$MC_HOME/eula.txt"
	else
		echo >&2 'error: EULA environment variable is invalid, set it to true'
		echo >&2 '-> https://account.mojang.com/documents/minecraft_eula'
		exit 1
	fi
fi

# Droits sur volume
chown -R minecraft:minecraft "$MC_HOME"

# Démarrage de minecraft
cd "$MC_HOME"
exec gosu "$MC_USER" java -Xms${START_MEMORY:="1024M"} -Xmx${MAX_MEMORY:="1024M"} -jar /opt/minecraft/minecraft_server.jar nogui