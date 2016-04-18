plugins/cordova-plugin-file-node-like:
	cordova plugin add cordova-plugin-file-node-like

plugins/cordova-plugin-scrypt:
	cordova plugin add cordova-plugin-scrypt

plugins/done: plugins/cordova-plugin-file-node-like plugins/cordova-plugin-scrypt
	touch plugins/done

setup-lc: bower_components/lawncipher
	cp bower_components/lawncipher/lawncipher.js www/js/
	cp bower_components/lawncipher/test.js www/js/lawncipher-test.js
	cp bower_components/libsodium.js/dist/browsers/combined/sodium.min.js www/js/

bower_components/lawncipher:
	bower install lawncipher

update-lawncipher:
	-rm -r bower_components
	make bower_components/lawncipher

platforms/ios: plugins/done
	cordova platform add ios

platforms/android: plugins/done
	cordova platform add android

ios: platforms/ios setup-lc
	cordova -d build ios

android: platforms/android setup-lc
	cordova -d build android

run-ios: platforms/ios setup-lc
	cordova -d run ios

run-android: platforms/android setup-lc
	cordova -d run android

clear-all:
	cordova platform remove ios
	cordova platform remove android
	cordova plugin remove cordova-plugin-file-node-like
	cordova plugin remove cordova-plugin-scrypt
	-rm -r bower_components
	-rm www/js/lawncipher*
	-rm www/js/sodium.min.js
