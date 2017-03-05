#!/bin/bash -xeu
# This script
PHP_MAJOR_VERSION=$(php -r "echo PHP_MAJOR_VERSION;");

if expr "$PHP_MAJOR_VERSION" ">=" "7" ; then
	git clone --depth 1 https://github.com/runkit7/runkit7.git
	pushd runkit7
	phpize && ./configure && make && make install || exit 1
	echo 'extension = runkit.so' >> ~/.phpenv/versions/$(phpenv version-name)/etc/conf.d/travis.ini
	popd
else
	pecl install runkit
fi
# Configuration settings needed for running tests.
# One test emits E_DEPRECATED for gmmktime
echo 'runkit.internal_override = On' >> ~/.phpenv/versions/$(phpenv version-name)/etc/conf.d/travis.ini
echo 'error_reporting = E_ALL & ~E_DEPRECATED' >> ~/.phpenv/versions/$(phpenv version-name)/etc/conf.d/travis.ini
