#

# Set compilers
FC=mpif90
F77=mpif77

#Linking flags
LINKFLAGS= -L/usr/local/lib
ARFLAGS=

#Compilation flags
#NB for gcc10 you need to add -fallow-argument-mismatch
COMPFLAGS= -O3 $(XC_COMPFLAGS)
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

# Full library call; remove scalapack if using dummy diag module
# LIBS= $(FFT_LIB) $(XC_LIB) -lscalapack $(BLAS)
LIBS= $(FFT_LIB) $(XC_LIB) $(BLAS)


LINKFLAGS= -lmkl_scalapack_lp64 -lmkl_blacs_sgimpt_lp64 -qmkl=parallel -static-intel 
#LINKFLAGS= -lmkl_scalapack_lp64 -lmkl_blacs_sgimpt_lp64 -qmkl=parallel -static-intel -g -traceback
#LINKFLAGS= -lmkl_scalapack_lp64 -lmkl_blacs_sgimpt_lp64 -qmkl=parallel
#MPT i8
#LINKFLAGS= -lmkl_scalapack_ilp64 -lmkl_blacs_sgimpt_ilp64 -mkl=parallel -static-intel
#INTEL i8
#LINKFLAGS= $(COMPFLAGS) -lmkl_scalapack_ilp64 -lmkl_blacs_intelmpi_ilp64 -mkl=parallel
ARFLAGS=


# LibXC compatibility (LibXC below) or Conquest XC library

# Conquest XC library
#XC_LIBRARY = CQ
#XC_LIB =
#XC_COMPFLAGS =

# LibXC compatibility
#Choose LibXC version: v4 or v5
#XC_LIBRARY = LibXC_v4
XC_LIBRARY = LibXC_v5
XC_LIB = -lxcf90 -lxc
XC_COMPFLAGS = -I/usr/local/include

# Set FFT library
FFT_LIB=-lfftw3
FFT_OBJ=fft_fftw3.o

# Matrix multiplication kernel type
MULT_KERN = default
# Use dummy DiagModule or not
DIAG_DUMMY =
[khoa@asahi02 src]
