FROM alpine:3.3
MAINTAINER s7b4 <baron.stephane@gmail.com>

# Minecraft
ENV MC_VERSION 1.9.4
ENV APP_USER minecraft
ENV APP_HOME /home/$APP_USER

# set user/group IDs
RUN addgroup -g 999 $APP_USER && \
	adduser -G $APP_USER -D -H -u 999 -s /bin/bash -h $APP_HOME $APP_USER

# Base
RUN apk add --update bash \
		curl \
		su-exec \
		openjdk8-jre-base \
	&& rm -rf /var/cache/apk/*

# Minecraft
RUN mkdir -p /opt/minecraft \
	&& curl -o /opt/minecraft/minecraft_server.jar -sSL "https://s3.amazonaws.com/Minecraft.Download/versions/$MC_VERSION/minecraft_server.$MC_VERSION.jar"

COPY scripts/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 25565 25575
VOLUME $APP_HOME