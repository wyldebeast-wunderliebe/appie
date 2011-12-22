VERSION=`cat VERSION`
PRODUCT=appie

default:
	@echo $(VERSION)

install:
	@mkdir -p /usr/local/$(PRODUCT)-$(VERSION)
	@ln -f -s -T /usr/local/$(PRODUCT)-$(VERSION) /usr/local/$(PRODUCT)
	@cp -r * /usr/local/$(PRODUCT)-$(VERSION)
	@find /usr/local/$(PRODUCT)-$(VERSION) -type d -name '.svn' -print0 | xargs -0 rm -rf 
	./install.sh

upgrade:
	@mkdir -p /usr/local/$(PRODUCT)-$(VERSION)
	@cp -r * /usr/local/$(PRODUCT)-$(VERSION)
	@cp /usr/local/appie/appie.conf /usr/local/$(PRODUCT)-$(VERSION)
	@ln -f -s -T /usr/local/$(PRODUCT)-$(VERSION) /usr/local/$(PRODUCT)

update:
	@cp -r * /usr/local/$(PRODUCT)-$(VERSION)

dist: struct
	@fakeroot tar -czvf $(PRODUCT)-$(VERSION).tgz -C build ${PRODUCT}-${VERSION}

struct:
	make realclean
	@mkdir -p build/${PRODUCT}-${VERSION}
	@cp VERSION includes install.sh appie appie.conf.example TODO INSTALL README Makefile --target-directory build/${PRODUCT}-${VERSION}
	@cp -r modules build/${PRODUCT}-${VERSION}
	rm -rf `find build -name CVS`

clean:
	rm -f `find . -name '*~'`
	rm -f `find . -name '#*'`

realclean: clean
	rm -f *.tgz
	rm -rf build
