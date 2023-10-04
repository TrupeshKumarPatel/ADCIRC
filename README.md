# ADCIRC Installation for UAHPC Cluster

This repository helps to install ADCIRC software on [UAHPC cluster](https://hpc.ua.edu/) at a user-defined location.

## Getting Started
There are three following phases in order to run ADCIRC on the UAHPC cluster.
- [In the first phase](#installation), we install the ADCIRC on a user-defined location in their UAHPC account using the `install.sh` file.
- [In the second phase](#setup-environment), we activate the installed environment using `create_environment.sh` file.
- [In the third phase](#submit-job-script), we submit a job script or run an interactive job.

### Installation
* `Step 1:` Clone this repository at your desired location on the UAHPC cluster
  
  ```bash
  git clone https://github.com/TrupeshKumarPatel/ADCIRC_UAHPC.git
  ```
  > [!NOTE]  
  > All the packages of ADCIRC will be installed in the cloned directory. So, you'll need to run the clone command at your desired file location. 
  
* `Step 2:` Change your current directory
  ```bash
  cd ADCIRC_UAHPC
  ```
  
* `Step 3:` Run the installation file
  ```bash
  ./install.sh
  ```
  > [!WARNING]  
  > The installation process is very long, due to the package's dependency on previously compiled packages. Therefore, take a cup of coffee and watch for any error message, if there is any.

### Setup Environment
* `Step 1:` Since the ADCIRC is installed on your desired directory, we will need to activate the installed environment every time you log in to UAHPC or submit any job script to the cluster
  ```bash
  source create_environment.sh
  ```
  > [!NOTE]  
  > To run the `create_environment.sh` file, you must be in the `ADCIRC_UAHPC` directory. 

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
