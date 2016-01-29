#!../../bin/$[EPICS_HOST_ARCH]/$[APP_NAME]


##########################################
# Setup Environment
< envPaths
epicsEnvSet "STREAM_PROTOCOL_PATH" "$(TOP)/db"

##########################################
# Allow PV prefixes and serial port name to be set from the environment
epicsEnvSet "P" "$(P=$[P])"
epicsEnvSet "R" "$(R=$[R])"
epicsEnvSet "TTY" "$(TTY=$[TTY])"

##########################################
# Register all support components
cd ${TOP}
dbLoadDatabase(dbd/$[APP_NAME].dbd)
$[APP_NAME]_registerRecordDeviceDriver(pdbbase)

##########################################
# Set up ASYN ports
drvAsynIPPortConfigure("L0","192.168.33.1:503",0,0,0)
#1st argument is the port's name
#2nd argument is the "IP address: port num"
#3rd argument is priority; 0 means medium
#4th argument is noAutoConnect; 0 means yes, autoconnect
#5th argument is noProcessEOS; 0 means do not close connection on timeout, 1 means close it


#these enable trace back information to be printed to IOC terminal
asynSetTraceIOMask("L0",0,2)
asynSetTraceMask("L0",0,255)

##########################################
## Load record instances
dbLoadRecords("db/dev$[APP_NAME].db","P=$(P),R=$(R),PORT=L0,ADDR=$[ADDR]")

##########################################
# Start EPICS
cd ${TOP}/iocBoot/${IOC}
iocInit
