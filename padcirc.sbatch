#!/bin/bash
#SBATCH -p twater
#SBATCH --qos main 
#SBATCH --mem-per-cpu=8G
##SBATCH -c 24
#SBATCH -e err.txt
#SBATCH -o out.txt
#SBATCH --mail-type=ALL
#SBATCH --mail-user=jroblescamacho@crimson.ua.edu

#SBATCH --job-name="padcirc run"
#SBATCH --time=07:00:00
#SBATCH --ntasks-per-node=48
#SBATCH --ntasks=24
#SBATCH --nodes=1
#SBATCH --output=/twater/Javier/Test004


#~~~~~~ Printing Job Specifications ~~~~~~#
echo "==============================================================="
echo "                        JOB INFORMATION                        "
echo "==============================================================="
echo "Cluster Name                       : " $SLURM_CLUSTER_NAME
echo "# of Nodes requested               : " $SLURM_NNODES
echo "# of tasks per each node           : " $SLURM_TASKS_PER_NODE
echo "# of CPUs  per task                : " $SLURM_CPUS_PER_TASK
echo "# of CPUs on the allocated node    : " $SLURM_CPUS_ON_NODE
echo "# of Processes in the current job  : " $SLURM_NTASKS
echo "List of nodes allocated to the job : " $SLURM_NODELIST
echo ""
echo ""

#~~~~~~ Source and Module for UAHPC Cluster ~~~~~~#
export CC=/share/apps/intel/2018/bin/icc
export CXX=/share/apps/intel/2018/bin/icpc
module load compilers/intel/2018
module load compilers/intel/util
module load cmake/3.20.1
module load mpi/mpich/3.3.2-intel
module load zlib/1.2.11
module load hdf5/intel/1.10.6-mpich
module load netcdf/intel/4.7.3-mpich

cd $SLURM_SUBMIT_DIR

source create_environment.sh

mpiexec -n 24 padcirc
