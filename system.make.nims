# Makefile for nims simulator (2023/12/26)
# 

# Set compilers
FC=mpif90
F77=mpif77

# OpenMP flags
# Set this to "OMPFLAGS= " if compiling without openmp
# Set this to "OMPFLAGS= -fopenmp" if compiling with openmp
OMPFLAGS=

#Compilation flags
#NB for gcc10 you need to add -fallow-argument-mismatch
# COMPFLAGS= -O3 $(XC_COMPFLAGS)
COMPFLAGS = -O3 -xCORE-AVX512 -fp-model strict -qopt-report $(XC_COMPFLAGS) 
#COMPFLAGS = -O3 -xCORE-AVX512 -fp-model strict -qopt-report $(XC_COMPFLAGS) -g -traceback
#COMPFLAGS = -O3 -xCORE-AVX512 -fp-model strict $(XC_COMPFLAGS)
#COMPFLAGS = -O3 -xCORE-AVX512 -fp-model strict 
COMPFLAGS_F77= $(COMPFLAGS)

# Set BLAS and LAPACK libraries
# MacOS X
# BLAS= -lvecLibFort
# Intel MKL use the Intel tool
# Generic
# BLAS= -llapack -lblas

LINKFLAGS= -lmkl_scalapack_lp64 -lmkl_blacs_sgimpt_lp64 -qmkl=parallel -static-intel 
#LINKFLAGS= -lmkl_scalapack_lp64 -lmkl_blacs_sgimpt_lp64 -qmkl=parallel -static-intel -g -traceback
#LINKFLAGS= -lmkl_scalapack_lp64 -lmkl_blacs_sgimpt_lp64 -qmkl=parallel
#MPT i8
#LINKFLAGS= -lmkl_scalapack_ilp64 -lmkl_blacs_sgimpt_ilp64 -mkl=parallel -static-intel
#INTEL i8
#LINKFLAGS= $(COMPFLAGS) -lmkl_scalapack_ilp64 -lmkl_blacs_intelmpi_ilp64 -mkl=parallel
ARFLAGS=

# LibXC: choose between LibXC compatibility below or Conquest XC library
# Conquest XC library
#XC_LIBRARY = CQ
#XC_LIB =
#XC_COMPFLAGS =

# LibXC compatibility
# Choose LibXC version: v4 (deprecated) or v5/6 (v5 and v6 have the same interface)
#XC_LIBRARY = LibXC_v4
XC_LIBRARY = LibXC_v5
XC_LIB = -lxcf90 -lxc
XC_COMPFLAGS = -I/usr/local/include

# Set FFT library
FFT_LIB=-lfftw3
FFT_OBJ=fft_fftw3.o

LIBS= $(FFT_LIB) $(XC_LIB) $(BLAS)

# Matrix multiplication kernel type
MULT_KERN = default
# Use dummy DiagModule or not
DIAG_DUMMY =
# Use dummy omp_module or not.
# Set this to "OMP_DUMMY = DUMMY" if compiling without openmp
# Set this to "OMP_DUMMY = " if compiling with openmp
OMP_DUMMY = DUMMY
