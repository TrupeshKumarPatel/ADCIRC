# ADCIRC Installtion for UAHPC Cluster

This repository helps to install ADCIRC software on [UAHPC cluster](https://hpc.ua.edu/) at user defined location.

## Getting Stared
There are three following phases in order to run ADCIRC on UAHPC cluster.
- [In first phase](#installation), we install the ADCIRC on user defined location in their UAHPC account, using `install.sh` file.
- [In second phase](#setup-environment), we activate the installed environment using `create_environment.sh` file.
- [In third phase](#submit-job-script), we submit a job script or run interactive job.

### Installation
* `Step 1:` Clone this repository at your desired location on UAHPC cluster
  
  ```bash
  git clone https://github.com/TrupeshKumarPatel/ADCIRC_UAHPC.git
  ```
  > [!NOTE]  
  > The all the packages of ADCIRC will be installed in the cloned directory. Therefore, you will need to run the clone command at your desire file location. 
  
* `Step 2:` Change your current direcory
  ```bash
  cd ADCIRC_UAHPC
  ```
  
* `Step 3:` Run the installation file
  ```bash
  ./install.sh
  ```
  > [!WARNING]  
  > The installation process is very long, due to dependency of the package is on previously complied packages. Therefore, take coffee and watch for any error message if there is any.

### Setup Environment
* `Step 1:` Since the ADCIRC is installed on your desired directory, we will need to activate the installed environment everytime you login to UAHPC or submit any job script to the cluster
  ```bash
  source create_environment.sh
  ```
  > [!NOTE]  
  > To run `create_environment.sh` file you have to be in the `ADCIRC_UAHPC` directory. 

### Submit Job Script
* `Step 1:` Create a bash script to submit in Slurm Workload Manager at UAHPC
  
  ```bash
  #!/bin/bash
  #
  #SBATCH --job-name=ADCIRC_JOB
  #SBATCH --ntasks=<number>
  #SBATCH --output=ADCIRC-run-%J.log
  #SBATCH --qos main
  #SBATCH --mail-type=ALL
  #SBATCH --mail-user=<CRIMSON_ID>@crimson.ua.edu

  export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

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

  cd <PATH_TO_ADCIRC_UAHPC_DIRECTORY>

  source create_environment.sh

  echo "==============================================================="
  echo "                        MODULE LIST                            "
  echo "==============================================================="
  module list

  
  ``` 
