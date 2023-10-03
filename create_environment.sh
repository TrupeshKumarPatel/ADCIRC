#! /bin/bash

# test if sourced or executed
if [ $_ == $0 ]; then
	echo "Use: source $0"
	exit 
fi

basepath=`pwd`
echo $basepath

binpath="$basepath"/adcirc_install/bin
export PATH=$binpath:$PATH

