# Docker image for working with

## Description

This Docker image can be used for workinig with swagger files.

It provides live reloading web server which hosts you swagger files and allows to edit them in real time.

## Config for docker-compose

To make it work you should connect your folder with output swagger files into volume /home/www/swaggers, and
your folder with sources of swagger files you want to join into /src/swagger.

This image start two services on 8080 and 8081 ports. 8080 provides web interface itself, and 8081 provides
livereloading feature.

## Example of docker-compose

```
version: '2'
services:
  swagger:
    image: docker.saritasa.com/swagger-ui-local:latest
    ports:
      - "8080:8080"
      - "8081:8081"
    volumes:
      - ./artifacts/:/home/www/swaggers
      - ./docs/swagger/:/src/swagger

```
