# my-bcvegpy


**Setup as example for 8_0_35:**

```
source  /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc7_amd64_gcc530
scram p CMSSW CMSSW_8_0_35

cd CMSSW_8_0_35/src
cmsenv

git clone git@github.com:alberto-sanchez/my-bcvegpy.git
cd my-bcvegpy

make

sh run.sh

```
