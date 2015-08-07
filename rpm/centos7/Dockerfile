FROM  italiangrid/build-centos7

user build
add Makefile ./voms-admin-server.spec.in /home/build/
workdir /home/build

entrypoint make
