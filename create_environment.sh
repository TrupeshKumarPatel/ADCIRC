##
 #	Author:	Trupeshkumar Patel
 #	Email:	trpatel2@crimson.ua.edu
 #	GitHub repository: 
 #		https://github.com/TrupeshKumarPatel/ADCIRC_UAHPC.git
 #	Last update:
 #		October 2, 2023
 ##
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

