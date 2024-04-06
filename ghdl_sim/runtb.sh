#!/usr/bin/env bash

# This code is a rewrite of mr. Susta's runtb.bat to bash (e.g. for linux)
# functionality not guaranteed, please feel free to submit any improvements

GHDL_FLAGS='-fsynopsys --std=08'

echo "INFO: running first simulation"
ghdl -a $GHDL_FLAGS ../LCDpackage.vhd ../LCDlogic0.vhd ../testbench_LCDlogic.vhd

if [ $? -gt 0 ] # ERRORLEVEL should be equal to exitcode in this case, we want it to be 0 
then
  echo "ERROR: first simulation failed - see exit code"
  exit $?
else
  echo "INFO: first simulation was successful"
fi

echo "INFO: running second simulation"
ghdl -e $GHDL_FLAGS testbench_LCDlogic
if [ $? -gt 0 ] 
then
  echo "ERROR: second simulation failed - see exit code"
  exit $?
else 
  echo "INFO: second simulation was successful"
fi

echo "INFO: running third simulation"

# NOTE: 20 ms time is a safety break, the frame needs only 16.6 ms
ghdl -r $GHDL_FLAGS testbench_LCDlogic --stop-time=20ms

echo "INFO: script finished"

