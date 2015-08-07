FROM  italiangrid/build-centos6

run yum -y install oracle-instantclient-basic
user build
add Makefile ./voms-admin-server.spec.in /home/build/
workdir /home/build

entrypoint make
