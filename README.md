# ADCIRC Installtion for UAHPC Cluster

This repository helps to install ADCIRC software on UAHPC cluster at user defined location.

## Getting Stared
There are two following phases in order to run ADCIRC on UAHPC cluster.
- [In first phase](#installation), we install the ADCIRC on user defined location in their UAHPC account, using `install.sh` file.
- [In second phase](#setup-environment), we activate the installed environment using `create_environment.sh` file.

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
