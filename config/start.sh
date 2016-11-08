#!/bin/bash
# Start 

grunt swagger
grunt watch &
http-server /home/www/

