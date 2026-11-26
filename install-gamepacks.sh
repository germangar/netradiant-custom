#!/bin/sh

: ${ECHO:=echo}
: ${SH:=sh}
: ${CP:=cp}
: ${CP_R:=cp -r}
: ${RM_R:=rm -f -r}

dest=$1

case "$DOWNLOAD_GAMEPACKS" in
	yes)
		LICENSEFILTER=GPL BATCH=1 $SH download-gamepacks.sh
		;;
	allinone)
		LICENSEFILTER=allinone BATCH=1 $SH download-gamepacks.sh
		;;
	all)
		BATCH=1 $SH download-gamepacks.sh
		;;
	*)
		;;
esac

set -e
for GAME in games/*Pack; do
	if [ "$GAME" = "games/*Pack" ]; then
		$ECHO "Game packs not found, please run"
		$ECHO "  ./download-gamepacks.sh"
		$ECHO "and then try again!"
	else
		$SH install-gamepack.sh "$GAME" "$dest"
	fi
done

# Apply tracked customizations after all stock packs. A *.game directory here
# replaces the installed pack completely, so removed legacy files stay removed.
overlay=setup/data/gamepack-overlays
if [ -d "$overlay" ]; then
	for GAME in "$overlay"/*.game; do
		if [ -d "$GAME" ]; then
			$ECHO "Applying gamepack overlay: $GAME"
			$RM_R "$dest/${GAME##*/}"
			$CP_R "$GAME" "$dest/"
		fi
	done
	for GAMEFILE in "$overlay"/games/*.game; do
		if [ -f "$GAMEFILE" ]; then
			$CP "$GAMEFILE" "$dest/games/"
		fi
	done
fi
