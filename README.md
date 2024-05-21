# cAdvisor_htpasswd
cAdvisor with htpasswd generate with multistage build


## Multi-stage image

Multi stage can generate secrets with no artifacts in final image. It's a PoC, not very useful.

## Download Dockerfile

```
git clone https://github.com/NonneTrapuE/cAdvisor_htpasswd.git
```

## Create .env file

```
cat << EOF >> .env
user:password
EOF
```

## Generate image

```
docker build -t <image name> .
```



