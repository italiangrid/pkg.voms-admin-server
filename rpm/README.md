# RPM packaging for  VOMS Admin server

## Usage

`build-images.sh` builds the Docker images used to create the packages:


- `italiangrid/pkg.voms-admin-server:centos5`
- `italiangrid/pkg.voms-admin-server:centos6`
- `italiangrid/pkg.voms-admin-server:centos7`

These images depend on the following common images:

- italiangrid/build:centos5
- italiangrid/build:centos6
- italiangrid/build:centos7

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
