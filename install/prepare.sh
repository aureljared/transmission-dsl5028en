#!/bin/bash
symlinks=yes

while getopts "n" opt; do
	case $opt in
		n)
			symlinks=no
			;;
		*)
			echo "Unknown option \"$opt\"."
			;;
	esac
done

if [[ $symlinks == "yes" ]]; then
	echo -e "Running in symlink mode.\n"

	cd ../lib
	echo "Symlinking libraries"
	for f in $(cat ../install/libs.txt); do
		src="$(echo $f | cut -f1 -d',')"
		dst="$(echo $f | cut -f2 -d',')"
		echo "  * \"$dst\" -> \"$src\""
		ln -s ./$src ./$dst
	done

	cd ../bin
	echo "Symlinking BusyBox applets"
	chmod a+x *
	for f in $(cat ../install/applets.txt); do
		echo "  * $f"
		ln -s ./busybox "./$f"
	done
else
	echo -e "Running in copy mode.\n"

	cd ../lib
	echo "Copying libraries"
	for f in $(cat ../install/libs.txt); do
		src="$(echo $f | cut -f1 -d',')"
		dst="$(echo $f | cut -f2 -d',')"
		echo "  * \"$dst\" -> \"$src\""
		cp -fp ./$src ./$dst
	done

	cd ../bin
	echo "Copying BusyBox applets"
	chmod a+x *
	for f in $(cat ../install/applets.txt); do
		echo "  * $f"
		cp -fp busybox $f
	done
fi

cd ../
echo "Creating Transmission config directories"
mkdir -p .config/transmission-daemon/blocklists
mkdir -p .config/transmission-daemon/resume
mkdir -p .config/transmission-daemon/torrents
cp -fp install/settings.json .config/transmission-daemon/

echo "Done, you may now delete the install folder."
exit 0
