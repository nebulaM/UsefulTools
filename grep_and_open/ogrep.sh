#!/bin/bash
EDITOR="gedit"

usage () {
	echo "ogrep: grep and open the file that contains match"
	echo "-h -help --h --help"
	echo "-r: append regex at the end"
	echo "-e: open with editor "$EDITOR
	exit 0
}

do_grep () {
    targets=( $(grep -rl $1) )
	count=0
	for name in ${targets[@]} ; do
		#currently limit the function to only open the first 2 files contain match
		if [ $count -lt 3] ; then
			if [ $# == 2 ] ; then
				$EDITOR $name &
			else
				cat $name
			fi
			echo "content of "$name
		else
			echo "Searched for "$1"... Done"
			exit 0
		fi
		count=$((count+1))
	done
	echo "Searched for "$1"... Done"
	exit 0
}

if [ $# -lt 1 ] || [ $1 == "-h" ] || [ $1 == "-help" ] || [ $1 == "--h" ] || [ $1 == "--help" ] ; then
	usage
fi

if [ $# == 1 ] ; then
	do_grep $1
fi

if [ $# == 2 ] ; then
	if  [ $1 == "-re" ] || [ $1 == "-er" ] ; then
		do_grep $2".*)" 1
	elif [ $1 == "-r" ] ; then
		do_grep $2".*)"
	elif [ $1 == "-e" ] ; then
		do_grep $2 1
	fi
fi
	
