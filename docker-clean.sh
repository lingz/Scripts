#!/bin/bash

# Clean

if [ "$1" == images ]; then
  docker rmi `docker images -aq`
elif [ "$1" == containers ]; then
  docker rm `docker ps -a | grep Exited | awk '{print $1 }'`
else
  echo 1>&2 "Pass in either 'images' or 'containers'"
fi

