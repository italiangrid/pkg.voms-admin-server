#!/bin/bash
set -ex
tags="centos5 centos6 centos7"

for t in ${tags}; do
  docker build -t italiangrid/pkg.voms-admin-server:${t} -f Dockerfile.${t} .
done
