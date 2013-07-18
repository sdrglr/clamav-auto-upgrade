#/bin/bash
 
#############################################################
# ClamAV Auto Installation/Upgrade Script by SERDAR GULER   #
# https://twitter.com/sdrglr                                #
#############################################################
# - Make sure you take backups before run this script!      #
# - I suggest you to check configuration after installation #
#############################################################
# Installation Tested on OpenSUSE 11.4, 20130625            #
#############################################################
 
VERSION="0.97.8"
BUILDDIR="/scripts/clamav"
CLAMURL="http://downloads.sourceforge.net/project/clamav/clamav/${VERSION}/clamav-${VERSION}.tar.gz"
 
echo "=========================================="
echo "Preparing Source"
echo "=========================================="
mkdir $BUILDDIR
cd $BUILDDIR
wget $CLAMURL
 
tar zxvf clamav-${VERSION}.tar.gz
cd clamav-${VERSION}
 
echo "=========================================="
echo "Installing dependencies if necessary"
echo "=========================================="
yast -i gcc
yast -i glibc
yast -i zlib-devel
yast -i gmp-devel
#yast -i bzip2-devel
 
echo "=========================================="
echo "Adding CLAMAV User/Group"
echo "=========================================="
groupadd clamav
useradd -g clamav -s /bin/false -c "Clam AntiVirus" clamav
 
echo "=========================================="
echo "Compiling & initializing"
echo "=========================================="
 
mkdir /var/lib/clamav
chown clamav.clamav /var/lib/clamav
 
mkdir /usr/local/share/clamav
chown clamav.clamav /usr/local/share/clamav
 
./configure
make
make install
sed -i s/"Example"/"#Example"/g /usr/local/etc/freshclam.conf
sed -i s/"Example"/"#Example"/g /usr/local/etc/clamd.conf
#sed -i s/"#LocalSocket"/"LocalSocket"/g /usr/local/etc/clamd.conf
 
ldconfig
