NAME=mongodb
VERSION=1.8.1
ARCHITECTURE=`dpkg --print-architecture`
MONGO_ARCHITECTURE=x86_64
TARFILE=$(NAME)-linux-$(MONGO_ARCHITECTURE)-$(VERSION)
TARBALL=$(TARFILE).tgz
TARDIR=build
DOWNLOAD=http://fastdl.mongodb.org/linux/$(TARBALL)
POSTINSTALL= ./postinstall.sh
PREFIX=/

.PHONY: default
default: deb
package: deb

.PHONY: clean
clean:
	rm -f $(NAME)-* $(NAME)_* || true
	rm -fr $(TARDIR) || true
	rm -fr ./tmp || true
	rm -f *.deb

$(TARBALL):
	wget "$(DOWNLOAD)"

$(TARDIR): $(TARBALL)
	mkdir -p ./build/etc/init.d
	mkdir -p ./tmp
	mkdir -p ./build/opt
	cp mongodb.init.d ./build/etc/init.d/mongodb
	chmod +x ./build/etc/init.d/mongodb
	tar -C ./tmp -zxf $(TARBALL)
	mv ./tmp/$(TARFILE) ./build/opt/mongodb
	mkdir -p ./build/opt/mongodb/log

.PHONY: deb
deb: $(TARDIR)
	fpm -s dir -t deb -v $(VERSION) -n $(NAME)-autocargo -a $(ARCHITECTURE) --prefix $(PREFIX) -C $(TARDIR) . \
	  --post-install $(POSTINSTALL)

