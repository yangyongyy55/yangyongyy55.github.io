#!/bin/sh

rm -rf Packages Packages.gz Packages.bz2

# 生成新的package
dpkg-scanpackages debs /dev/null > Packages
tar zcvf Packages.gz Packages
bzip2 -k Packages Packages.bz2

