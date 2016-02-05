# EPICS-MDrive

This IOC application is aimed at running ethernet enabled Lexium MDrive motors from Schneider Electric.  It depends on the EPICS motor record and installation/management is handled by my EPICS-SCPI-Template perl script monstrosity.  Development is targeted at OS X, but I'm pretty sure it will also work in Linux as most EPICS packages treat Linux as first-class, while OS X is a red-headed step child.

## Installation

0. `git clone https://github.com/fullerf/EPICS-MDrive.git <APP_NAME>`, this makes a copy of this template in your current directory and names it whatever you wanted to call your new application (APP_NAME).  `cd` into that directory.  This is referred to as the "TOP" directory in EPICS lingo.

1. Edit the PARAMS file found in the `tcpip` directory.  This is essentially a parsed file that does the file editing prescribed in [this tutorial](http://www.aps.anl.gov/epics/modules/soft/asyn/R4-24/HowToDoSerial/HowToDoSerial_StreamDevice.html) for you.  The tutorial basically consists of changing variables here and there.  So this script allows you you to define variables either in a global application scope or a local file scope.  These variable definitions are injected into files at specified hook points or they replace existing variable definitions.

2. run `./genSCPItemplate.pl tcpip`.

3. If you want to change something in your `*.db` or `*.proto` file, `cd` to `install` in the TOP directory and edit the files there.  Back out of the directory and then hit `./cleandist.pl`.  This will wipe your installation and then you can hit `./genSCPItemplate.pl reinstall` to recompile everything.  New changes will now be incorporated, as the changes you made in the install folder are used by genSCPItemplate.pl.  There may be faster ways to make changes, but I find this way is the cleanest and easiest to maintain.
