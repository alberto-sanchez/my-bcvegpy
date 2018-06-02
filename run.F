
*************************************
**** this file is only a header    **
**** for BCVEGPY2.0-linux version  **
****         BCVEGPY2.1            **
*************************************

* define some overall parameters
* here you may define your own 
* overall parameters for convenience.
* for example: some values you do not
* want to change in the program.

* --------------------------------
* number of events to be generated.
* defined/used in parameter.F

*#define NUMOFEVENTS 100000

* ------------------------------
* define tevatron and lhc energy

*#define ENERGYOFTEVA 1.96d+3
*#define ENERGYOFLHC  0.7d+4

********************************
**** begin of main program  ****
****     now go for it      ****
********************************

#include "bcvegpy.F"
#include "parameter.F"

*******************************
**** principly, only the above two files
**** and (invegas.h) need to be changed for 
**** ones own purpose.
*******************************
