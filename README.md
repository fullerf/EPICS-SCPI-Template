# EPICS-SCPI-Template
Perl templates to streamline creation of EPICS IOCs for devices with SCPI-like commands

This, like many perl CGI scripts is a teetering and fragile monstrosity.  Treat it with the utmost care and it will do what you want.  I had a lot of SCPI device IOCs I wanted to write and I found it challenging to manage the fiddly bits of writing even one.  EPICS templates already exist to do what you want, sort of, but you still need to go in and manually change a line here, a line there.  Fiddle with a thing.  It's very hard to remember what to do exactly, so you'll need a formula sheet.  [Such a sheet exists](http://www.aps.anl.gov/epics/modules/soft/asyn/R4-24/HowToDoSerial/HowToDoSerial_StreamDevice.html).  I find it very easy to screw up.  This perl script automates a lot of the fiddly bits, allowing one to focus on making the ioc database, protocol file, and st.cmd.

## Work flow:

0. `git clone https://github.com/fullerf/EPICS-SCPI-Template.git <APP_NAME>`, this makes a copy of this template in your current directory and names it whatever you wanted to call your new application (APP_NAME).  `cd` into that directory.  This is referred to as the "TOP" directory in EPICS lingo.

1. Edit the PARAMS file found in one of the 3 main categories: serial, usbtmc, or tcpip.  This is essentially a parsed file that does the file editing prescribed in [this tutorial](http://www.aps.anl.gov/epics/modules/soft/asyn/R4-24/HowToDoSerial/HowToDoSerial_StreamDevice.html) for you.  The tutorial basically consists of changing variables here and there.  So this script allows you you to define variables either in a global application scope or a local file scope.  These variable definitions are injected into files at specified hook points or they replace existing variable definitions.

2. run `./genSCPItemplate.pl <type>`.  Where `<type>` is either `serial`, `usbtmc`, or `tcpip`.  If you omit this it defaults to `serial`.  If you screw it up defaults to `serial`.  Hit Enter at the prompt and it will compile a thing.  After you do this it will manufacture an `install` directory where your templated files will live in case youd like to change them and have another go.

3. If you want to change something in your `*.db` or `*.proto` file, `cd` to `install` in the TOP directory and edit the files there.  Back out of the directory and then hit `./cleandist.pl`.  This will wipe your installation and then you can hit `./genSCPItemplate.pl` again.  New changes will now be incorporated, as the changes you made in the install folder are used by genSCPItemplate.pl.  There may be faster ways to make changes, but I find this way is the cleanest and easiest to maintain.
