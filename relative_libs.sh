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

