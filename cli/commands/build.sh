#!/bin/bash

this_directory="$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)"

image_name="devcontainer-web"
tag="${image_name}:beta"

_build() {
  dockerfile_path="$this_directory/../../docker/Dockerfile"
  context_path="$this_directory/../../docker"

  if [ ! -f "$dockerfile_path" ]; then
    echo "Dockerfile not found: $dockerfile_path" >&2
    exit 1
  fi

  docker build -t "$tag" -f "$dockerfile_path" "$context_path" "$@"
}

_build "$@"
