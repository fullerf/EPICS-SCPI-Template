#!../../bin/darwin-x86/MDrive


##########################################
# Setup Environment
< envPaths
epicsEnvSet "STREAM_PROTOCOL_PATH" "$(TOP)/db"
epicsEnvSet "EPICS_CA_AUTO_ADDR_LIST" "NO"
epicsEnvSet "EPICS_CA_ADDR_LIST" "127.0.0.1"

##########################################
# Allow PV prefixes and serial port name to be set from the environment
epicsEnvSet "P" "$(P=y)"
epicsEnvSet "R" "$(R=y)"

##########################################
# Register all support components
cd ${TOP}
dbLoadDatabase(dbd/MDrive.dbd)
MDrive_registerRecordDeviceDriver(pdbbase)

##########################################
# Set up ASYN ports
drvAsynIPPortConfigure("L0","192.168.33.1:503",0,0,0)
#1st argument is the port's name
#2nd argument is the "IP address: port num"
#3rd argument is priority; 0 means medium
#4th argument is noAutoConnect; 0 means yes, autoconnect
#5th argument is noProcessEOS; 0 means do not close connection on timeout, 1 means close it
##########################################
# Set up Motor Controller
ImsMDrivePlusCreateController("IMS1", "L0", "", 5000, 5000) #ethernet motors do not support party mode, so set arg3 to "".



#these enable trace back information to be printed to IOC terminal
asynSetTraceIOMask("L0",0,2)
asynSetTraceMask("L0",0,255)

##########################################
## Load record instances
dbLoadRecords("db/asynRecord.db","P=$(P),R=$(R):AsynRecord,PORT=L0,ADDR=-1,IMAX=100,OMAX=100")
dbLoadRecords("db/devMDrive.db","P=$(P),R=$(R),PORT=L0,ADDR=0")
dbLoadTemplate "db/motor.mdriveplus.substitutions"

##########################################
# Start EPICS
cd ${TOP}/iocBoot/${IOC}
iocInit
