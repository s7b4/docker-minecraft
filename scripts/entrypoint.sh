#! /bin/bash
set -e

# EULA
if [ ! -f "$APP_USER/eula.txt" ]; then
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
chown -R "$APP_USER":"$APP_USER" "$APP_HOME"

# Démarrage de minecraft
cd "$APP_HOME"
exec su-exec "$APP_USER" java -Xms${START_MEMORY:="1024M"} -Xmx${MAX_MEMORY:="$START_MEMORY"} -jar /opt/minecraft/minecraft_server.jar nogui