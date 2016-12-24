update: init genkeys
	find members -type f | xargs -n1 ./genconf.sh

genkeys:
	find members -type f | xargs -n1 ./genkey.sh

init: mkdirs binaries keys/ca.pem

keys/ca.pem:
	./genca.sh

binaries: bin/cfssl bin/cfssljson

bin/cfssl:
	wget https://pkg.cfssl.org/R1.2/cfssl_linux-amd64 -O bin/cfssl
	chmod +x bin/cfssl

bin/cfssljson:
	wget https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64 -O bin/cfssljson
	chmod +x bin/cfssljson

mkdirs:
	mkdir -p bin keys members configs

clean:
	rm -fr keys configs

dist-clean:
	rm -fr bin keys members configs
