#!/bin/bash
# wvera@suse.com

usage(){
	echo "$0 <export|import> <GnuPG Key>"
}
exportkey() {
	mkdir -p $GKEY-Backup
	gpg2 -a --export $GKEY > $GKEY-Backup/$GKEY-public-gpg.key
	gpg2 -a --export-secret-keys $GKEY > $GKEY-Backup/$GKEY-secret-gpg.key
	gpg2 --export-ownertrust > $GKEY-Backup/$GKEY-ownertrust-gpg.txt
}
importkey() {
	gpg2 --import $GKEY-Backup/$GKEY-secret-gpg.key
	gpg2 --import-ownertrust $GKEY-Backup/$GKEY-ownertrust-gpg.txt
}
ask() {
	case "$DOIT" in
  	"export")
    echo "Exporting $GKEY..."
    exportkey
  	;;
  	"import")
    echo "Importing $GKEY..."
    importkey
  	;;
  	*)
    usage
  	;;
	esac
	
}
if [ "$#" -ne "2" ]; then usage; else DOIT=$1; GKEY=$2; ask;fi
