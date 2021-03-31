#!/bin/bash

# install a bunch of things
apt-get update && sudo apt-get dist-upgrade -y
apt-get install -y build-essential autotools-dev libdumbnet-dev libluajit-5.1-dev libpcap-dev \
zlib1g-dev pkg-config libhwloc-dev cmake liblzma-dev openssl libssl-dev cpputest libsqlite3-dev \
libtool uuid-dev git autoconf bison flex libcmocka-dev libnetfilter-queue-dev libunwind-dev \
libmnl-dev ethtool

# Create snort source folder
mkdir ~/snort_src

##########################################################
# Start downloading, configuring and install dependencies
##########################################################
cd ~/snort_src
wget https://github.com/rurban/safeclib/releases/download/v02092020/libsafec-02092020.tar.gz
tar -xzvf libsafec-02092020.tar.gz
cd libsafec-02092020.0-g6d921f
./configure
make
make install

cd ~/snort_src
wget https://ftp.pcre.org/pub/pcre/pcre-8.44.tar.gz
tar -xzvf pcre-8.44.tar.gz
cd pcre-8.44
./configure
make
sudo make install

cd ~/snort_src/
wget https://ftp.pcre.org/pub/pcre/pcre-8.44.tar.gz
tar -xzvf pcre-8.44.tar.gz
cd pcre-8.44
./configure
make
sudo make install

cd ~/snort_src
wget https://github.com/gperftools/gperftools/releases/download/gperftools-2.8/gperftools-2.8.tar.gz
tar xzvf gperftools-2.8.tar.gz
cd gperftools-2.8
./configure
make
sudo make install

cd ~/snort_src
wget http://www.colm.net/files/ragel/ragel-6.10.tar.gz
tar -xzvf ragel-6.10.tar.gz
cd ragel-6.10
./configure
make
sudo make install

cd ~/snort_src
wget https://dl.bintray.com/boostorg/release/1.74.0/source/boost_1_74_0.tar.gz
tar -xvzf boost_1_74_0.tar.gz

wget https://github.com/intel/hyperscan/archive/v5.3.0.tar.gz
tar -xvzf v5.3.0.tar.gz
mkdir ~/snort_src/hyperscan-5.3.0-build
cd hyperscan-5.3.0-build/
cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DBOOST_ROOT=~/snort_src/boost_1_74_0/ ../hyperscan-5.3.0
make
sudo make install

cd ~/snort_src
wget https://github.com/google/flatbuffers/archive/v1.12.0.tar.gz -O flatbuffers-v1.12.0.tar.gz
tar -xzvf flatbuffers-v1.12.0.tar.gz
mkdir flatbuffers-build
cd flatbuffers-build
cmake ../flatbuffers-1.12.0
make
sudo make install

cd ~/snort_src
wget https://www.snort.org/downloads/snortplus/libdaq-3.0.0.tar.gz
tar -xzvf libdaq-3.0.0.tar.gz
cd libdaq-3.0.0
./bootstrap
./configure
make
sudo make install

ldconfig

##########################################################
# finally install snort 3
##########################################################
cd ~/snort_src
wget https://www.snort.org/downloads/snortplus/snort3-3.1.0.0.tar.gz
tar -xzvf snort3-3.1.0.0.tar.gz
cd snort3-3.1.0.0
./configure_cmake.sh --prefix=/usr/local --enable-tcmalloc
cd build
make
sudo make install



##########################################################
# Create folders
##########################################################
sudo mkdir /usr/local/etc/rules
sudo mkdir /usr/local/etc/so_rules/
sudo mkdir /usr/local/etc/lists/
sudo touch /usr/local/etc/rules/snort.rules
sudo touch /usr/local/etc/rules/local.rules
sudo touch /usr/local/etc/lists/default.blocklist
sudo mkdir /var/log/snort

##########################################################
# generate rule for test
##########################################################
sudo echo "alert icmp any any -> any any ( msg:"ICMP Traffic Detected"; sid:10000001; metadata:policy security-ips alert; )" >> /var/local/etc/rules/local.rules

##########################################################
# Test snort config file and rule
# for now on snort will caputre traffic
# 
# use ctrl+c to stoping it
##########################################################
sudo snort -c /usr/local/etc/snort/snort.lua -R /usr/local/etc/rules/local.rules
sudo snort -c /usr/local/etc/snort/snort.lua -R /usr/local/etc/rules/local.rules \
-i wlp2s0b1 -A alert_fast -s 65535 -k none

##########################################################
# test snort 3
##########################################################
/usr/local/bin/snort -V
snort -c /usr/local/etc/snort/snort.lua
