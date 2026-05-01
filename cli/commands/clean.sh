#!/bin/bash

this_directory="$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)"

image_name="devcontainer-web"
tag="${image_name}:beta"

_clean() {
  if docker image inspect "$tag" > /dev/null 2>&1; then
    docker rmi "$tag" "$@"
  else
    echo "Image not found: $tag"
  fi
}

_clean $@
