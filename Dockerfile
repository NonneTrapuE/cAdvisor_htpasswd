FROM alpine:latest AS build_secret

COPY .env /

RUN apk update && apk add apache2-utils

RUN USERNAME=$(cat .env | cut -d : -f 1) && PASSWORD=$(cat .env | cut -d : -f 2) && htpasswd -Bbc /.htpasswd $USERNAME $PASSWORD

#======== cAdvisor ========#

FROM gcr.io/cadvisor/cadvisor

COPY --from=build_secret /.htpasswd /.htpasswd

ENTRYPOINT ["/usr/bin/cadvisor","--http_auth_file","/.htpasswd"]
