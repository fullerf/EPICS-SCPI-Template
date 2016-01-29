#!../../bin/$[EPICS_HOST_ARCH]/$[APP_NAME]


##########################################
# Setup Environment
< envPaths
epicsEnvSet "STREAM_PROTOCOL_PATH" "$(TOP)/db"

##########################################
# Allow PV prefixes and serial port name to be set from the environment
epicsEnvSet "P" "$(P=$[P])"
epicsEnvSet "R" "$(R=$[R])"

##########################################
# Register all support components
cd ${TOP}
dbLoadDatabase(dbd/$[APP_NAME].dbd)
$[APP_NAME]_registerRecordDeviceDriver(pdbbase)

##########################################
# Set up ASYN ports
usbtmcConfigure("L0")


##########################################
## Load record instances
dbLoadRecords("db/dev$[APP_NAME].db","P=$(P),R=$(R),PORT=L0,ADDR=$[ADDR]")

##########################################
# Start EPICS
cd ${TOP}/iocBoot/${IOC}
iocInit
