#!/bin/bash
# LICENSE CDDL 1.0 + GPL 2.0
#
# Copyright (c) 1982-2016 Oracle and/or its affiliates. All rights reserved.
# 
# Since: November, 2016
# Author: gerald.venzl@oracle.com
# Description: Installs new Perl binaries if not present
# 
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
# 


# Install latest Perl
cd $INSTALL_DIR
mv $ORACLE_HOME/perl $ORACLE_HOME/perl.old
wget http://www.cpan.org/src/5.0/perl-5.22.0.tar.gz
tar -xzf perl-5.22.0.tar.gz
cd perl-5.22.0
./Configure -des -Dprefix=$ORACLE_HOME/perl -Doptimize=-O3 -Dusethreads -Duseithreads -Duserelocatableinc
make clean
make
make install

# Copy old binaries into new Perl dir
cd $ORACLE_HOME/perl
rm -rf lib/ man/
cp -r ../perl.old/lib/ .
cp -r ../perl.old/man/ .
cp ../perl.old/bin/dbilogstrip bin/
cp ../perl.old/bin/dbiprof bin/
cp ../perl.old/bin/dbiproxy bin/
cp ../perl.old/bin/ora_explain bin/
cd $ORACLE_HOME/lib
ln -sf ../javavm/jdk/jdk8/lib/libjavavm12.a

# Relink Oracle
cd $ORACLE_HOME/bin
relink all

# Cleanup
rm -rf $ORACLE_HOME/perl.old
rm -rf $INSTALL_DIR/perl-5.22.0*