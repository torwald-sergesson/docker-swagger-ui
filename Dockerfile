FROM node:latest 

MAINTAINER https://www.saritasa.com

RUN npm install -g grunt \
  && npm install -g swagger-cli \
  && npm install -g http-server \
  && npm install -g yamljs 

ADD config/ /home/grunt/

# install local npm libraries
RUN npm install grunt \
  && npm install grunt-contrib-watch \
  && npm install grunt-exec \
  && npm install load-grunt-tasks \
  && npm install grunt-shell \
  && npm install time-grunt \
  && npm install jit-grunt

ADD swagger-ui/ /home/www/
WORKDIR /home/grunt/

EXPOSE 8080
EXPOSE 8081

ENTRYPOINT bash start.sh

