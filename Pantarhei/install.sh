##
 #	Author:	Trupeshkumar Patel
 #	Email:	trpatel2@crimson.ua.edu
 #	GitHub repository: 
 #		https://github.com/TrupeshKumarPatel/ADCIRC_UAHPC.git
 #	Last update:
 #		October 2, 2023
 #		April 17, 2024
 ##
#!/bin/bash
echo "==========================================================="
echo "-- Welcome to ADCIRC installtion on Pantarhei"
echo "==========================================================="

if [ -z "$1" ]
then
	echo "Please provide compressed version of ADCIRC package"
	echo "Usage..."
	echo -e "\t./install.sh adcirc_v55.01.tar"
	exit 1
fi

program=$( echo "$1" | cut -f1-2 -d"." )
current_dir=`pwd`
adcirc_install="$2"/ADCIRC

echo "==========================================================="
echo "-- Extracting ADCIRC at $current_dir/$program"
echo "==========================================================="
tar -xvf $1

echo "==========================================================="
echo "-- Loading Environment to Install ADCIRC"
echo "==========================================================="
#export CC=/share/apps/intel/2018/bin/icc
#export CXX=/share/apps/intel/2018/bin/icpc
#module load compilers/intel/2018
#module load compilers/intel/util
#module load cmake/3.20.1
#module load mpi/mpich/3.3.2-intel
#module load zlib/1.2.11
#module load hdf5/intel/1.10.6-mpich
#module load netcdf/intel/4.7.3-mpich

export CC=/apps/OpenMPI/4.1.5-GCC-12.3.0/bin/mpicc
export CXX=/apps/OpenMPI/4.1.5-GCC-12.3.0/bin/mpicxx
#export FC=/apps/OpenMPI/4.1.5-GCC-12.3.0/bin/mpifort

module load CMake/3.26.3-GCCcore-12.3.0
module load OpenMPI/4.1.5-GCC-12.3.0
module load netCDF/4.9.2-gompi-2023a
module load Doxygen/1.9.7-GCCcore-12.3.0

module list

echo "==========================================================="
echo "-- Building Environment for ADCIRC at $adcirc_install"
echo "==========================================================="
cd $current_dir/$program
fix_problem=`find $current_dir/$program/ -name adcircVersion.sh  -printf '%h\n'`
cd $fix_problem
sed -i -e 's/\r$//' adcircVersion.sh

mkdir $current_dir/$program/build
cd $current_dir/$program/build

cmake .. -DCMAKE_INSTALL_PREFIX=$adcirc_install -DBUILD_ADCIRC=ON   -DBUILD_PADCIRC=ON   -DBUILD_ADCSWAN=ON   -DBUILD_PADCSWAN=ON   -DBUILD_ADCPREP=ON   -DBUILD_UTILITIES=ON   -DBUILD_ASWIP=ON   -DBUILD_SWAN=ON   -DBUILD_PUNSWAN=ON -DNETCDFHOME=$(nc-config --prefix) -DENABLE_OUTPUT_NETCDF=ON -DENABLE_GRIB2=ON -DENABLE_DATETIME=ON

#cmake ..   -DBUILD_ADCIRC=ON   -DBUILD_PADCIRC=ON   -DBUILD_ADCSWAN=ON   -DBUILD_PADCSWAN=ON   -DBUILD_ADCPREP=ON   -DBUILD_UTILITIES=ON   -DBUILD_ASWIP=ON   -DBUILD_SWAN=ON   -DBUILD_PUNSWAN=ON   -DENABLE_OUTPUT_NETCDF=ON   -DNETCDFHOME=$(nf-config --prefix)


echo "==========================================================="
echo "-- Installing ADCIRC at $adcirc_install"
echo "==========================================================="
make

make install 

binpath="$adcirc_install"/bin
export PATH=$binpath:$PATH
