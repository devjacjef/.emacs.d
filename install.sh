#!/bin/sh

echo "Compiling and Installing Emacs for Performance"

sudo apt update
sudo apt build-dep emacs

find ~/.emacs.d/ -name '*.eln' -delete

git clone https://github.com/emacs-mirror/emacs /tmp/emacs
cd /tmp/emacs
git checkout "emacs-30.2"

git reset --hard HEAD
git clean -f -d -x
rm -fr .git/hooks/*

./autogen.sh

export CFLAGS="-O2 -pipe -march=native -mtune=native -fno-omit-frame-pointer -fno-plt -flto=auto"
export LDFLAGS="-Wl,-O2 -Wl,-z,now -Wl,-z,relro -Wl,--sort-common -Wl,--as-needed -Wl,-z,pack-relative-relocs -flto=aut"

./configure \
  --without-x \
  --with-pgtk \
  --with-toolkit-scroll-bars \
  --with-cairo \
  --without-xft \
  --with-harfbuzz \
  --without-libotf \
  --with-gnutls \
  --without-xdbe \
  --without-xim \
  --without-gpm \
  --disable-gc-mark-trace \
  --enable-link-time-optimization \
  --with-gsettings \
  --with-modules \
  --with-threads \
  --with-libgmp \
  --with-xml2 \
  --with-tree-sitter \
  --with-zlib \
  --without-included-regex \
  --with-native-compilation \
  --with-file-notification=inotify \
  --without-compress-install

make -j "$(nproc)" -l "$(nproc --ignore=1)"

sudo make install-strip
