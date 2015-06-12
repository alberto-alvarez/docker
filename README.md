# docker
Create good Dockerfiles and Compose configuration files for a specific LAMP Application

Keep in mind that docker images should be a generic piece of the whole system.

Hints:
# enable non-root use
https://docs.docker.com/installation/ubuntulinux/#create-a-docker-group

# remove running containers from a given pattern
docker ps -a | grep pattern | awk '{print $1}' | xargs docker rm
