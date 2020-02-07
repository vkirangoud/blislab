#!/bin/bash

#For Mac OS only
export DYLD_LIBRARY_PATH=/opt/intel/lib:/opt/intel/mkl/lib

#Single Thread
export KMP_AFFINITY=compact  #Rule to bind core to thread for OMP thread with Intel compiler for parallel version
export OMP_NUM_THREADS=1     #Set OMP number of threads for parallel version
export BLISLAB_IC_NT=1       #Set BLISLAB number of threads for parallel version
k_start=16
k_end=1024
k_blocksize=16
echo "result=["
echo -e "%m\t%n\t%k\t%MY_GFLOPS\t%REF_GFLOPS"
for (( k=k_start; k<=k_end; k+=k_blocksize ))
do
    ./test_bl_dgemm.x     $k $k $k 
done
echo "];"


#Multi Thread
#export KMP_AFFINITY=compact,verbose  #Rule to bind core to thread for OMP thread with Intel compiler for parallel version
#export KMP_AFFINITY=scatter,verbose  #Rule to bind core to thread for OMP thread with Intel compiler for parallel version
export KMP_AFFINITY=scatter           #Rule to bind core to thread for OMP thread with Intel compiler for parallel version
export OMP_NUM_THREADS=12     #Set OMP number of threads for parallel version
export BLISLAB_IC_NT=12       #Set BLISLAB number of threads for parallel version
export OMP_PROC_BIND=spread
k_start=64
k_end=4096
k_blocksize=64
echo "result=["
echo -e "%m\t%n\t%k\t%MY_GFLOPS\t%REF_GFLOPS"
for (( k=k_start; k<=k_end; k+=k_blocksize ))
do
    ./test_bl_dgemm.x     $k $k $k 
done
echo "];"

