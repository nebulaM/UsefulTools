#!/bin/bash
#which editor to open the file
EDITOR="gedit"
#limit to only open 5 files that contain match
LIMIT=5
echo "command 2 is "$2
usage () {
	echo "ogrep: grep and open the file that contains match"
	echo "-h -help --h --help"
	echo "-r: append regex at the end"
	echo "-e: open with editor "$EDITOR
	exit 0
}

do_grep () {
	search_for=$1
	echo "search_for "$search_for
	#need to quota the cmd otherwise [space] in cmd will split the cmd to multiple parts 
    targets=( $(grep -rl "$search_for") )
	count=0
	for name in ${targets[@]} ; do
		if [ $count -lt "$LIMIT" ] ; then
			if [ $# == 2 ] ; then
				$EDITOR $name &
			else
				cat $name
			fi
			echo "get content of "$name
		else
			echo $name
		fi
		count=$((count+1))
	done
	if [ $count -gt $LIMIT ] || [ $count -eq $LIMIT ] ; then
		echo "Warning: too many files contain match("$count" in total), only opened the first "$LIMIT" files"	
	fi
	echo "Searched for "$search_for"... Done"
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
		#need to quota the cmd otherwise [space] in cmd will split the cmd to multiple parts 
		do_grep "$2" 1
	fi
fi


	
