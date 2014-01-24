#!/bin/csh
#
# David Cinabro, cinabro@physics.wayne.edu
#
# Automate the production of a SNANA arbitrary cadence simlib
# using Lyne Jones' OpsimObs.
#
# Directories
#
# Where the lsstdfacg fortran executables live
#
set lsstdfacgdir=${PWD}
#
# where ObsimObs lives
#
set opsimobsdir="/Users/rbiswas/src/OpsimObs"
echo ${lsstdfacgdir}
##
@ NARG = $#argv
if ( ${NARG} < 1 ) then
  echo "Must give the name of the lsstdfacg data file as an argument."
  echo "I assume it has extension .dat and will produce .SIMLIB"
  exit
endif
#
# define the data files
#
set working="`pwd`"
set datastem=$argv[1]
<<<<<<< HEAD
set datafile = "${datastem}.dat"
set opsimobsin = "${datastem}_OpsimObs.input"
set opsimobsout = "${datastem}_OpsimObs.output"
set simlibin = "${datastem}_OpsimObs_pro.output"
set simlibfile = "${datastem}.SIMLIB"
##
## First pass on the datafile
##
=======
set datafile="${datastem}.dat"
set opsimobsin="${datastem}_OpsimObs.input"
set opsimobsout="${datastem}_OpsimObs.output"
set simlibin="${datastem}_OpsimObs_pro.output"
set simlibfile="${datastem}.SIMLIB"
#
# First pass on the datafile
#
>>>>>>> 3c917f78c2d9f6b66062e8b81f6673d4acbfd7a1
echo "First pass with lsstdfacg.out on " $datafile
##
cd $lsstdfacgdir
cp $working/$datafile .
if (-e $opsimobsin) rm $opsimobsin 
./lsstdfacg.out << EOD
I
$datafile
$opsimobsin
EOD
#
# Running OpsimObs
#
echo "Running OpsimObs on " $opsimobsin
#
cp $opsimobsin $opsimobsdir/$opsimobsin
cd $opsimobsdir
if (-e $opsimobsout) rm $opsimobsout 
python opsimObs.py $opsimobsin > $opsimobsout
cd $lsstdfacgdir
cp $opsimobsdir/$opsimobsout .
#
echo "Second pass with lsstdfacg.out on " $opsimobsout
#
if (-e $simlibin) rm $simlibin 
./lsstdfacg.out << EOD
C
$datafile
$opsimobsout
$simlibin
EOD
#
echo "Generatiing SIMLIB with lsstdfacg.out on " $simlibin
#
if (-e $simlibfile) rm $simlibfile 
./lsstsimlib.out << EOD
$simlibin
$simlibfile
EOD
#
cd $working
cp $lsstdfacgdir/$simlibfile .
#
exit
