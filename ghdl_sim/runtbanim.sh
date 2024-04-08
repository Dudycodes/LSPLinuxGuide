#!/usr/bin/env bash

echo "***********************************************************************"
echo "Testbench simulates 32 frames. To terminate itscution, press Ctrl C    "
echo "***********************************************************************"
# Compile for VHDL-2008
GHDL_FLAGS='-fsynopsys --std=08'
TBNAME='testbench_LCDlogicAnim'

echo "INFO: running first simulation";
#Analyse and create object files
ghdl -a $GHDL_FLAGS ../LCDpackage.vhd ../LCDlogic0anim.vhd ../$TBNAME.vhd 
if [ $? -gt 0 ] 
then
  echo "ERROR: first simulation failed"
  exit $?
fi

echo "INFO: running second simulation";
ghdl -e $GHDL_FLAGS $TBNAME 
if [ $? -gt 0 ] 
then
  echo "ERROR: second simulation failed"
  exit $?
fi

# 20 ms time is a safety break, the frame needs only 16.6 ms, for more frame we need a higher safety time value
ghdl -r $GHDL_FLAGS $TBNAME --stop-time=1000ms

