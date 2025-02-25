#Image de base alpine renommée
FROM alpine:latest AS build_secret
# Copie du fichier .env de la racine du dossier à  la racine  du conteneur 
COPY .env /
# MaJ et installation du paquet  apache2-utils
RUN apk update && apk add apache2-utils
#Parse du fichier  .env et génération  du fichier .htpasswd 
RUN USERNAME=$(cat .env | cut -d : -f 1) && PASSWORD=$(cat .env | cut -d : -f 2) && htpasswd -Bbc /.htpasswd $USERNAME $PASSWORD

#======== cAdvisor ========#
#Image de base de cadvisor
FROM gcr.io/cadvisor/cadvisor
#Copie du  fichier .htpasswd générer pendant le stage précédent dans la  nouvelle image
COPY --from=build_secret /.htpasswd /.htpasswd
#Exécution de la commande lors du  lancement du  container
ENTRYPOINT ["/usr/bin/cadvisor","--http_auth_file","/.htpasswd"]
