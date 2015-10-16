# docker-minecraft

## Variables d'environnement

* EULA: true si https://account.mojang.com/documents/minecraft_eula accepté
* START_MEMORY: Paramètre -Xms de java (défaut = 1024M)
* MAX_MEMORY: Paramètre -Xmx de java (défaut = 1024M)

## docker-compose.yml

    worker:
      image: s7b4/minecraft
      ports:
        - "25565:25565"
      environment:
        - EULA=true
        - START_MEMORY=2048M
        - MAX_MEMORY=2048M