# This script is based off of the spec file for the CMS oracle rpm
# https://github.com/cms-sw/cmsdist/blob/comp_gcc630/oracle.spec

set -x

# Set installation and client directories
INSTALLDIR=/data/srv/db/oracle
CLIENTDIR=$INSTALLDIR/instantclient_11_2

# Set vars for downloading the Linux client
ORACLEMIRROR=http://cmsrep.cern.ch/cmssw/oracle-mirror
COPYDATE=20150918
VERSION=11.2.0.4.0
ARCH=linux.x64

mkdir -p $INSTALLDIR
cd $INSTALLDIR

# Grab instant client from cmsrep
wget $ORACLEMIRROR/$COPYDATE-instantclient-basic-$ARCH-$VERSION.zip
wget $ORACLEMIRROR/$COPYDATE-instantclient-basiclite-$ARCH-$VERSION.zip
wget $ORACLEMIRROR/$COPYDATE-instantclient-jdbc-$ARCH-$VERSION.zip
wget $ORACLEMIRROR/$COPYDATE-instantclient-sdk-$ARCH-$VERSION.zip
wget $ORACLEMIRROR/$COPYDATE-instantclient-sqlplus-$ARCH-$VERSION.zip
wget $ORACLEMIRROR/oracle-license

# Unzip the files
for f in $(ls *.zip); do
  unzip -o $f
done

# Delete the zips
rm -f $INSTALLDIR/*.zip

# Set up directory structure and move files to appropriate places
mkdir -p $INSTALLDIR/{bin,lib,java,demo,include,doc}
mv $CLIENTDIR/*_README $CLIENTDIR/sdk/*_README       $INSTALLDIR/doc
mv $CLIENTDIR/lib*                                   $INSTALLDIR/lib
mv $CLIENTDIR/glogin.sql                             $INSTALLDIR/bin
mv $CLIENTDIR/*.jar $CLIENTDIR/sdk/*.zip             $INSTALLDIR/java
mv $CLIENTDIR/sdk/demo/*                             $INSTALLDIR/demo
mv $CLIENTDIR/sdk/include/*                          $INSTALLDIR/include

cd $CLIENTDIR
for f in sqlplus adrci genezi uidrvci sdk/ott; do
  [ -f $f ] || continue
  mv $f $INSTALLDIR/bin
done

cd $INSTALLDIR/lib
for f in lib*.{dylib,so}.[0-9]*; do
  [ -f $f ] || continue
  dest=$(echo $f | sed 's/\.[.0-9]*$//')
  rm -f $dest
  ln -s $f $dest
done

# Cleanup
rm -rf $CLIENTDIR
