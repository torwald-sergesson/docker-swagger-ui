FROM node:latest 

MAINTAINER https://www.saritasa.com

WORKDIR /home/
COPY config/Gruntfile.js /home/

# install npm dependencies
RUN npm install -g grunt \
  && npm install -g swagger-cli \
  && npm install -g http-server \
  && npm install -g yamljs \ 
  && npm install grunt \
  && npm install grunt-contrib-watch \
  && npm install grunt-exec \
  && npm install load-grunt-tasks \
  && npm install grunt-shell \
  && npm install time-grunt \
  && npm install jit-grunt

ADD swagger-ui/ /home/www/
COPY config/* /home/

EXPOSE 8080
# port for livereload server
EXPOSE 8081

CMD bash start.sh

