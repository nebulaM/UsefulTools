#!/bin/bash

# Use grep to search for a given expression and open source files 
# that contain the expression 

# Copyright (C) 2017 nebulam [nebulam12@gmail.com]
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#---------------------------------------------------------------------------
# CONFIG
#---------------------------------------------------------------------------
#which editor to open the file
EDITOR="gedit"
#limit to only open 5 files that contain match
LIMIT=5
#regex append at the end of input if -r is enabled
REGEX="(.*)"
#valid extensions, only search the expression in files with following extention
extensions=("c" "h" "H" "sh" "py" "mk" "MK" "s" "S" "asm" "LOG" "log" "java" 
"cc" "cpp" "CPP" "hpp" "js")
#----------------------------------------------------------------------------

usage () {
	echo "ogrep: grep and open the file that contains match"
	echo "-h -help --h --help"
	echo "-r: append regex at the end"
	echo "-e: open with editor "$EDITOR
	exit 0
}

do_grep () {
	search_for=$1
	echo "searching for "$search_for
	#need to quota the cmd otherwise [space] in cmd will split the cmd to multiple parts 
	targets=( $(grep -rl "$search_for") )
	count=0
	for name in ${targets[@]} ; do
		for extention in ${extensions[@]} ; do
			if [[ $name == *".$extention" ]] ; then
				if [ $count -lt "$LIMIT" ] && [ $# == 2 ] ; then
					$EDITOR $name &
					echo "opened "$name		
				elif [ $# == 1 ] ; then
					cat $name
				else
					echo "also in "$name
				fi		
				count=$((count+1))
				break
			fi
		done
		#also search in Makefile
		if [[ $name == "Makefile" ]] ; then
			if [ $count -lt "$LIMIT" ] && [ $# == 2 ] ; then
					$EDITOR $name &
					echo "opened "$name		
			elif [ $# == 1 ] ; then
				cat $name
			else
				echo "also in "$name
			fi		
			count=$((count+1))
		fi
	done
	if [ $count -gt $LIMIT ] || [ $count -eq $LIMIT ] ; then
		count=$((count+1))
		echo "Warning: too many files contain match( $count in total), only opened the first "$LIMIT" non-binary files"	
	fi
	echo "finished ogrep for \"$search_for\""
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
		do_grep "$2""$REGEX" 1
	elif [ $1 == "-r" ] ; then
		do_grep "$2""$REGEX"
	elif [ $1 == "-e" ] ; then
		#need to quota the cmd otherwise [space] in cmd will split the cmd to multiple parts 
		do_grep "$2" 1
	fi
fi


	
