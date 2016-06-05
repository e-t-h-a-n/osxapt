### This file is just a script to use install_name_tool to stop executables from depending on libraries with absolute paths.
### Maybe someday this will be fixed in the actual build system, but I can't be bothered for now.

set -e

if [ ! `dirname` -eq bin ]; then
    cd bin
fi

mkdir -p ../lib     # Move .dylib(s) to ../lib
mv *.dylib ../lib/  # This is where they go on OS X

### We have 3 problem dylibs here, libapt-pkg, libapt-inst and libapt-private. We need to use install_name_tool to get the
### executable to load them relative to the executable's own path.

PRIVATE_MAJ=0.0
PRIVATE_MIN=0
INST_MAJ=1.5
INST_MIN=0
PKG_MAJ=4.12
PKG_MIN=0

PRIVATE=$PRIVATE_MAJ.$PRIVATE_MIN
INST=$INST_MAJ.$INST_MIN
PKG=$PKG_MAJ.$PKG_MIN

mv ../lib/libapt-private.$PRIVATE.dylib ../lib/libapt-private-$PRIVATE.dylib # This breaks symlinks but ah well.
mv ../lib/libapt-inst.$INST.dylib ../lib/libapt-inst-$INST.dylib             # 
mv ../lib/libapt-pkg.$PKG.dylib ../lib/libapt-pkg-$PKG.dylib                 # 

ln -s ../lib/libapt-private-$PRIVATE.dylib ../lib/libapt-private-$PRIVATE_MAJ.dylib
ln -s ../lib/libapt-private-$PRIVATE_MAJ.dylib ../lib/libapt-private.dylib

ln -s ../lib/libapt-inst-$INST.dylib ../lib/libapt-inst-$INST_MAJ.dylib
ln -s ../lib/libapt-inst-$INST_MAJ.dylib ../lib/libapt-inst.dylib

ln -s ../lib/libapt-pkg-$PKG.dylib ../lib/libapt-pkg-$PKG_MAJ.dylib
ln -s ../lib/libapt-pkg-$PKG_MAJ.dylib ../lib/libapt-pkg.dylib

### First executable: apt. Depends on: libapt-pkg.dylib and libapt-private.dylib
install_name_tool -change `otool -L apt | grep libapt-pkg | sed 's/\t//g;s/\.dylib.*)/.dylib/g'` @executable_path/../lib/libapt-pkg-$PKG.dylib apt
install_name_tool -change `otool -L apt | grep libapt-private | sed 's/\t//g;s/\.dylib.*)/.dylib/g'` @executable_path/../lib/libapt-private-$PRIVATE.dylib apt

### 2nd executable: apt-cache. Depends on: libapt-pkg.dylib and libapt-private.dylib
install_name_tool -change `otool -L apt-cache | grep libapt-pkg | sed 's/\t//g;s/\.dylib.*)/.dylib/g'` @executable_path/../lib/libapt-pkg-$PKG.dylib apt-cache
install_name_tool -change `otool -L apt-cache | grep libapt-private | sed 's/\t//g;s/\.dylib.*)/.dylib/g'` @executable_path/../lib/libapt-private-$PRIVATE.dylib apt-cache

### 3rd executable: apt-cdrom. Depends on: libapt-pkg.dylib and libapt-private.dylib
install_name_tool -change `otool -L apt-cdrom | grep libapt-pkg | sed 's/\t//g;s/\.dylib.*)/.dylib/g'` @executable_path/../lib/libapt-pkg-$PKG.dylib apt-cdrom
install_name_tool -change `otool -L apt-cdrom | grep libapt-private | sed 's/\t//g;s/\.dylib.*)/.dylib/g'` @executable_path/../lib/libapt-private-$PRIVATE.dylib apt-cdrom

### 4th executable: apt-config. Depends on: libapt-pkg.dylib and libapt-private.dylib
install_name_tool -change `otool -L apt-config | grep libapt-pkg | sed 's/\t//g;s/\.dylib.*)/.dylib/g'` @executable_path/../lib/libapt-pkg-$PKG.dylib apt-config
install_name_tool -change `otool -L apt-config | grep libapt-private | sed 's/\t//g;s/\.dylib.*)/.dylib/g'` @executable_path/../lib/libapt-private-$PRIVATE.dylib apt-config

### 5th executable: apt-dump-solver. Depends on: libapt-pkg.dylib only
install_name_tool -change `otool -L apt-dump-solver | grep libapt-pkg | sed 's/\t//g;s/\.dylib.*)/.dylib/g'` @executable_path/../lib/libapt-pkg-$PKG.dylib apt-dump-solver

### 6th executable: apt-extracttemplates. Depends on: libapt-pkg.dylib and libapt-inst.dylib
install_name_tool -change `otool -L apt-extracttemplates | grep libapt-pkg | sed 's/\t//g;s/\.dylib.*)/.dylib/g'` @executable_path/../lib/libapt-pkg-$PKG.dylib apt-extracttemplates
install_name_tool -change `otool -L apt-extracttemplates | grep libapt-inst | sed 's/\t//g;s/\.dylib.*)/.dylib/g'` @executable_path/../lib/libapt-inst-$INST.dylib apt-extracttemplates

### 7th executable: apt-get. Depends on: libapt-pkg.dylib and libapt-private.dylib
install_name_tool -change `otool -L apt-get | grep libapt-pkg | sed 's/\t//g;s/\.dylib.*)/.dylib/g'` @executable_path/../lib/libapt-pkg-$PKG.dylib apt-get
install_name_tool -change `otool -L apt-get | grep libapt-private | sed 's/\t//g;s/\.dylib.*)/.dylib/g'` @executable_path/../lib/libapt-private-$PRIVATE.dylib apt-get

### 8th executable: apt-helper. Depends on: libapt-pkg.dylib and libapt-private.dylib
install_name_tool -change `otool -L apt-helper | grep libapt-pkg | sed 's/\t//g;s/\.dylib.*)/.dylib/g'` @executable_path/../lib/libapt-pkg-$PKG.dylib apt-helper
install_name_tool -change `otool -L apt-helper | grep libapt-private | sed 's/\t//g;s/\.dylib.*)/.dylib/g'` @executable_path/../lib/libapt-private-$PRIVATE.dylib apt-helper

### 9th executable: apt-internal-solver. Depends on: libapt-pkg.dylib and libapt-private.dylib
install_name_tool -change `otool -L apt-internal-solver | grep libapt-pkg | sed 's/\t//g;s/\.dylib.*)/.dylib/g'` @executable_path/../lib/libapt-pkg-$PKG.dylib apt-internal-solver
install_name_tool -change `otool -L apt-internal-solver | grep libapt-private | sed 's/\t//g;s/\.dylib.*)/.dylib/g'` @executable_path/../lib/libapt-private-$PRIVATE.dylib apt-internal-solver

### 10th executable: apt-mark. Depends on: libapt-pkg.dylib and libapt-private.dylib
install_name_tool -change `otool -L apt-mark | grep libapt-pkg | sed 's/\t//g;s/\.dylib.*)/.dylib/g'` @executable_path/../lib/libapt-pkg-$PKG.dylib apt-mark
install_name_tool -change `otool -L apt-mark | grep libapt-private | sed 's/\t//g;s/\.dylib.*)/.dylib/g'` @executable_path/../lib/libapt-private-$PRIVATE.dylib apt-mark

### 11th executable: apt-sortpkgs. Depends on: libapt-pkg.dylib only
install_name_tool -change `otool -L apt-sortpkgs | grep libapt-pkg | sed 's/\t//g;s/\.dylib.*)/.dylib/g'` @executable_path/../lib/libapt-pkg-$PKG.dylib apt-sortpkgs


### Now onto methods :(

mv methods/ ../lib/

cd ../lib/methods

for i in ./*; do
    install_name_tool -change `otool -L $i | grep libapt-pkg | sed 's/\t//g;s/\.dylib.*)/.dylib/g'` @executable_path/../libapt-pkg-$PKG.dylib $i
