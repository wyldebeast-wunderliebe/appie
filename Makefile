VERSION := $(shell cat VERSION)
PRODUCT = appie
PACKAGE := appie-$(VERSION)

default:
	@echo $(VERSION)
	@echo $(PACKAGE)

dist: struct
	export PACKAGE=$(PACKAGE)
	cp appie.conf build/$(PACKAGE)/etc
	cp appie_sudo build/$(PACKAGE)/etc/sudoers.d/appie
	cp includes build/$(PACKAGE)/usr/lib/appie
	cp -r modules build/$(PACKAGE)/usr/lib/appie
	cp appie build/$(PACKAGE)/usr/bin
	chmod 0440 build/$(PACKAGE)/etc/sudoers.d/appie
	chmod a+x build/$(PACKAGE)/usr/bin/appie
	cp -r DEBIAN build/$(PACKAGE)
	cd build; dpkg-deb --build $(PACKAGE)
	cp build/$(PACKAGE).deb dist

struct:
	make realclean
	mkdir dist
	mkdir -p build/$(PACKAGE)/etc/sudoers.d
	mkdir -p build/$(PACKAGE)/usr/bin
	mkdir -p build/$(PACKAGE)/usr/lib/appie

clean:
	rm -f `find . -name '*~'`
	rm -f `find . -name '#*'`

realclean: clean
	rm -rf dist
	rm -rf build
