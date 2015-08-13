name=voms-admin-server

# The tag to build
tag=develop

ifdef BUILD_TAG
tag=$(BUILD_TAG)
endif

# the Github repo
git=git://github.com/italiangrid/voms-admin-server.git

ifdef BUILD_REPO
git=$(BUILD_REPO)
endif

# needed dirs
source_dir=sources
rpmbuild_dir=$(shell pwd)/rpmbuild

# spec file and its src
spec_src=$(name).spec.in
spec=$(name).spec

# determine the pom version and the rpm version
pom_version=$(shell grep "<version>" $(source_dir)/$(name)/pom.xml | head -1 | sed -e 's/<version>//g' -e 's/<\/version>//g' -e "s/[ \t]*//g")
rpm_version=$(shell grep "Version:" $(spec) | sed -e "s/Version://g" -e "s/[ \t]*//g")

# shared maven setting URL
mirror_conf_url=https://raw.github.com/italiangrid/build-settings/master/maven/cnaf-mirror-settings.xml

# name of the mirror settings file as packaged in the  decorated source tarball
mirror_conf_name=mirror-settings.xml

# directory where jar deps will be searched for
libs_dir=/var/lib/$(name)/lib

# python runtime dep
python=python26

.PHONY: clean rpm

all: rpm

print-info:
	@echo
	@echo
	@echo "Packaging $(name) fetched from $(git) for tag $(tag)."
	@echo

prepare-sources: clean
	@mkdir -p $(source_dir)/$(name)
	git clone $(git) $(source_dir)/$(name) 
	cd $(source_dir)/$(name) && git checkout $(tag)
	@cd $(source_dir)/$(name) && git archive --format=tar --prefix=$(name)/ $(tag) > $(name).tar
	# Maven mirror settings 
	wget --no-check-certificate $(mirror_conf_url) -O $(source_dir)/$(name)/$(mirror_conf_name)
	@cd $(source_dir) && tar -r -f $(name)/$(name).tar $(name)/$(mirror_conf_name) && gzip $(name)/$(name).tar
	@cp $(source_dir)/$(name)/$(name).tar.gz $(source_dir)/$(name).tar.gz

prepare-spec: prepare-sources
	sed -e 's#@@POM_VERSION@@#$(pom_version)#g' \
    	-e 's#@@PYTHON@@#$(python)#g' $(spec_src) > $(spec)

rpm: prepare-spec
	mkdir -p $(rpmbuild_dir)/BUILD \
		$(rpmbuild_dir)/RPMS \
		$(rpmbuild_dir)/SOURCES \
		$(rpmbuild_dir)/SPECS \
		$(rpmbuild_dir)/SRPMS
	cp $(source_dir)/$(name).tar.gz $(rpmbuild_dir)/SOURCES/$(name).tar.gz
ifndef BUILD_NUMBER
	rpmbuild --nodeps -v -ba $(spec) --define "_topdir $(rpmbuild_dir)"
else
	rpmbuild --nodeps -v -ba $(spec) --define "_topdir $(rpmbuild_dir)" --define "build_number $(BUILD_NUMBER)"
endif

clean:
	rm -rf $(source_dir) $(rpmbuild_dir) $(spec)
