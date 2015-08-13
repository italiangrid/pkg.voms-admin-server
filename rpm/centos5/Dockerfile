FROM  italiangrid/build-centos5

run yum -y install oracle-instantclient-basic
user build
add build.sh Makefile ./voms-admin-server.spec.in /home/build/
workdir /home/build

CMD /bin/bash build.sh
