FROM debian:8
MAINTAINER s7b4 <baron.stephane@gmail.com>

# Minecraft
ENV MC_VERSION 1.8.8
ENV MC_HOME /home/minecraft
ENV MC_USER minecraft

# set user/group IDs
RUN groupadd -r "$MC_USER" --gid=999 && useradd -r -g "$MC_USER" --uid=999 "$MC_USER"

# Base
RUN apt-get update \
	&& apt-get install --no-install-recommends --yes \
		ca-certificates \
		curl \
		nano \
		openjdk-7-jre-headless \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/

# Gosu
RUN curl -o /usr/local/sbin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.6/gosu-$(dpkg --print-architecture)" \
	&& chmod +x /usr/local/sbin/gosu

# Minecraft
RUN mkdir /opt/minecraft \
	&& curl -o /opt/minecraft/minecraft_server.jar -sSL "https://s3.amazonaws.com/Minecraft.Download/versions/$MC_VERSION/minecraft_server.$MC_VERSION.jar"

COPY scripts/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 25565
VOLUME /home/minecraft