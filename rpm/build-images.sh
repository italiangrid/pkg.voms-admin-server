#!/bin/bash
tags=$(find . -type d -maxdepth 1 -mindepth 1| sed -e "s/\.//" -e "s#/##")

for t in ${tags}; do
  docker build -t italiangrid/voms-admin-server-packager:${t} ${t}/
done
