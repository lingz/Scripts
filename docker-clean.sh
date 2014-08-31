#!/bin/bash

untagged_containers() {
  # Print containers using untagged images: $1 is used with awk's print: 0=line, 1=column 1.
  docker ps -a | awk '$2 ~ "[0-9a-f]{12}" {print $'$1'}'
}

untagged_images() {
  # Print untagged images: $1 is used with awk's print: 0=line, 3=column 3.
  # NOTE: intermediate images (via -a) seem to only cause
  # "Error: Conflict, foobarid wasn't deleted" messages.
  # Might be useful sometimes when Docker messed things up?!
  # docker images -a | awk '$1 == "<none>" {print $'$1'}'
  docker images | tail -n +2 | awk '$1 == "<none>" {print $'$1'}'
}

# Dry-run.
if [ "$#" == 0 ]; then
  echo "=== Containers: ==="
  echo
  echo "= Active ="
  docker ps
  echo
  echo "= Untagged ="
  untagged_containers 0
  echo
  echo "= Stopped ="
  docker ps -a | grep Exited
  echo
  echo


  echo "=== images: ==="
  echo
  echo "= Active ="
  docker images | grep MB
  echo
  echo "= Untagged ="
  untagged_images 0
  echo
  echo


  echo "Pass in either 'images', 'containers', 'inactive' or 'all'"
  exit
else
  # Clean
  if [ "$1" == images ]; then
    if [ "$2" == untagged ]; then
      untagged_images 3 | xargs --no-run-if-empty docker rmi
    elif [ "$2" == all ]; then
      docker rmi `docker images -aq`
    else
      echo 1>&2 "Pass in either 'untagged' or 'all'"
    fi
  elif [ "$1" == containers ]; then
    if [ "$2" == stopped ]; then
      docker ps -a | grep Exited | awk '{print $1 }' | xargs --no-run-if-empty docker rm --volumes=true
    elif [ "$2" == untagged ]; then
      untagged_containers 1 | xargs --no-run-if-empty docker rm --volumes=true
    elif [ "$2" == all ]; then
      docker ps -aq --no-trunc | xargs --no-run-if-empty docker rm --volumes=true -f
    else
      echo 1>&2 "Pass in either 'stopped', 'untagged', or 'all'"
    fi
  elif [ "$1" == inactive ]; then
    # untagged images and stopped containers
    docker ps -a | grep Exited | awk '{print $1 }' | xargs --no-run-if-empty docker rm --volumes=true
    untagged_images 3 | xargs --no-run-if-empty docker rmi
  elif [ "$1" == all ]; then
    docker ps -aq --no-trunc | xargs --no-run-if-empty docker rm --volumes=true -f
    docker rmi `docker images -aq`
  fi
fi


