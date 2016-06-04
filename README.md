# osxapt
A port of Debain's package manager (APT) for OS X


#Building Instructions

You will need to download [apt from debian (http://http.debian.net/debian/pool/main/a/apt/apt_1.0.9.8.3.tar.xz)](http://http.debian.net/debian/pool/main/a/apt/apt_1.0.9.8.3.tar.xz). Before extracting the archive, you'll need to use disk utility to create a case-sensitive disk image due to the nature of the makefiles apt uses. After copying the sources for apt to the disk image and extracting them, you'll need to copy over the osxapt files to the directory containing the apt sources. After copying the osxapt files, you will need to patch some of the sources by running `patch -p1 < osxapt.patch`. In order to build the sources, you will need to install Google Test and DPKG (which is painless compared to APT) to `/usr/local`, copy over `config.guess` and `config.sub` from `/usr/local/share/automake-X.XX/` (or wherever your package manager's prefix is) to the `buildlib` in the apt sources. Run `./configure`, then `make LDFLAGS+="-L/usr/local/lib -L/Volumes/apt/apt-1.0.9.8.3/bin -lbz2 -llzma -liconv -lz -lintl"` (change `/Volumes/apt/apt-X.X.X.X.X` to wherever your APT sources on the case-sensitive volume are, and change `/usr/local/lib` to wherever `libbzip2`, `liblzma`, `libiconv`, `zlib`, and `gettext`/`libintl` are installed to.
Good Luck!
