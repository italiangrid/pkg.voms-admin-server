# RPM packaging for  VOMS Admin server

## Usage

`build-images.sh` builds the Docker images used to create the packages:


- `italiangrid/pkg.voms-admin-server:centos5`
- `italiangrid/pkg.voms-admin-server:centos6`
- `italiangrid/pkg.voms-admin-server:centos7`

These images depend on the following common images:

- italiangrid/build-centos5
- italiangrid/build-centos6
- italiangrid/build-centos7

`push-images.sh` pushes the images to a private Docker registry whose host
must be defined with the `DOCKER_REGISTRY_HOST` environment variable.

## Parameters

Both images support the following parameters (expressed as environment variables)

| **PARAMETER**   | **DEFAULT VALUE**                                    | **MEANING**                                            |
| --------------- | ---------------------------------------------------- | ------------------------------------------------------ |
| BUILD_TAG       | develop                                              | The voms-admin-server branch to build                  |
| BUILD_REPO      | git://github.com/italiangrid/voms-admin-server.git   | URL of the GIT  repo                                   |
| BUILD_NUMBER    | N/A                                                  | User provided build number. Used for internal builds   |

Packages are built in the following directories: 
- /home/build/rpmbuild/RPMS
- /home/build/rpmbuild/SRPMS

## Example usage

```
## Run
$ docker run -d italiangrid/pkg.voms-admin-server:centos6
9bea23a8c8684ec23c0fe966215300ed704b6545fe42dc22ae8212d7fac5658f

$ docker logs -f 9bea23a8c8684ec23c0fe966215300ed704b6545fe42dc22ae8212d7fac5658f
...
Wrote: /home/build/rpmbuild/SRPMS/voms-admin-server-3.4.0-1.el6.src.rpm
Wrote: /home/build/rpmbuild/RPMS/noarch/voms-admin-server-3.4.0-1.el6.noarch.rpm
Executing(%clean): /bin/sh -e /var/tmp/rpm-tmp.TOvpAq
+ umask 022
+ cd /home/build/rpmbuild/BUILD
+ cd voms-admin-server
+ rm -rf /home/build/rpmbuild/BUILDROOT/voms-admin-server-3.4.0-1.el6.x86_64
+ exit 0

$ docker cp 9bea23a8c8684ec23c0fe966215300ed704b6545fe42dc22ae8212d7fac5658f:/home/build/rpmbuild/RPMS  .
$ docker cp 9bea23a8c8684ec23c0fe966215300ed704b6545fe42dc22ae8212d7fac5658f:/home/build/rpmbuild/SRPMS  .
$ ls -lR RPMS/ SRPMS/
RPMS/:
total 0
drwxr-xr-x  3 cecco  staff  102 Aug  7 12:28 noarch

RPMS//noarch:
total 120192
-rw-r--r--  1 cecco  staff  61538237 Aug  7 12:28 voms-admin-server-3.4.0-1.el6.noarch.rpm

SRPMS/:
total 1240
-rw-r--r--  1 cecco  staff  631211 Aug  7 12:28 voms-admin-server-3.4.0-1.el6.src.rpm
```
