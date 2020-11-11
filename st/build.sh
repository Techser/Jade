#! /bin/sh

workingDir=$(dirname $(realpath $0))

getConfig() {
	grep "^$1 " $workingDir/config | cut -d' ' -f 1 --complement
}

cd $workingDir/src

ls -1 $workingDir/patches |\
xargs -P 1 -I{} sh -c 'patch -N -p1 < ../patches/{}'

cp $HOME/.cache/wal/colors-wal-st.h config.gen.h

echo $(getConfig font)

echo "
static char *font = \"$(getConfig font)\";
static int borderpx = $(getConfig border_width);
" >> config.gen.h

make clean

make
