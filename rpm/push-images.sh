#!/bin/bash
set -ex
tags=$(find . -type d -maxdepth 1 -mindepth 1| sed -e "s/\.//" -e "s#/##")

if [ -z "${DOCKER_REGISTRY_HOST}" ]; then
  echo "Please define the DOCKER_REGISTRY_HOST environment variable before running this script."
  exit 1
fi

for t in ${tags}; do
  docker tag -f  italiangrid/pkg.voms-admin-server:${t} ${DOCKER_REGISTRY_HOST}/italiangrid/pkg.voms-admin-server:${t}
  docker push ${DOCKER_REGISTRY_HOST}/italiangrid/pkg.voms-admin-server:${t}
done
