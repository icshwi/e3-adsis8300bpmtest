###############################################################################
# SIS8300 digitizer

epicsEnvSet("ACQ_DEV",       "/dev/sis8300-$(ACQ_DEVID)")
epicsEnvSet("ACQ_PREFIX",    "$(RACKROW):$(ACQ_UNIT):")
epicsEnvSet("ACQ_PORT",      "AMC.$(ACQ_DEVID)")
epicsEnvSet("XSIZE",         "$(ACQ_SAMPLES)")
epicsEnvSet("YSIZE",         "1")
epicsEnvSet("QSIZE",         "20")
epicsEnvSet("NCHANS",        "100")
epicsEnvSet("CBUFFS",        "500")
epicsEnvSet("MAX_THREADS",   "4")
epicsEnvSet("BPM_PORTS",     "26")


# Create a SIS8300 BPM driver
# sis8300bpmConfigure(const char *portName, const char *devicePath, int numSamples, int extraPorts,
#                     int maxBuffers, size_t maxMemory, int priority, int stackSize)
sis8300bpmConfigure("$(ACQ_PORT)", "$(ACQ_DEV)", $(ACQ_SAMPLES), $(BPM_PORTS), 0, 0)

# SIS8300 generic parameters
dbLoadRecords("sis8300.template",       "P=$(ACQ_PREFIX),R=,PORT=$(ACQ_PORT),ADDR=0,TIMEOUT=1,MAX_SAMPLES=$(ACQ_SAMPLES)")

# SIS8300 internal (fake) signal generator when no hardware device is present
dbLoadRecords("sis8300SigGen.template", "P=$(ACQ_PREFIX),R=,PORT=$(ACQ_PORT),ADDR=0,TIMEOUT=1")

# SIS8300 10 analog input channels
# C = index for AD addr
# N = substitution for DB
# NAME = name for OPI
iocshLoad("$(PWD)/channel.cmd", "C=0, N=I1-A, NAME=Sensor A")
iocshLoad("$(PWD)/channel.cmd", "C=1, N=I1-B, NAME=Sensor B")
iocshLoad("$(PWD)/channel.cmd", "C=2, N=I1-C, NAME=Sensor C")
iocshLoad("$(PWD)/channel.cmd", "C=3, N=I1-D, NAME=Sensor D")
iocshLoad("$(PWD)/channel.cmd", "C=4, N=RF,   NAME=Reference")
iocshLoad("$(PWD)/channel.cmd", "C=5, N=I2-A, NAME=Sensor A")
iocshLoad("$(PWD)/channel.cmd", "C=6, N=I2-B, NAME=Sensor B")
iocshLoad("$(PWD)/channel.cmd", "C=7, N=I2-C, NAME=Sensor C")
iocshLoad("$(PWD)/channel.cmd", "C=8, N=I2-D, NAME=Sensor D")
# iocshLoad("$(PWD)/channel.cmd", "C=9, N=10,NAME=???")

# BPM system parameters
dbLoadRecords("sis8300bpm.template",    "P=$(ACQ_PREFIX),R=,PORT=$(ACQ_PORT),ADDR=0,TIMEOUT=1,I1=I1,I2=I2")

# BPM instance 1 & 2 parameters
dbLoadRecords("sis8300bpmI.template",   "P=$(ACQ_PREFIX),R=I1-,I=1,PORT=$(ACQ_PORT),ADDR=0,TIMEOUT=1,NAME=BPM1")
dbLoadRecords("sis8300bpmI.template",   "P=$(ACQ_PREFIX),R=I2-,I=2,PORT=$(ACQ_PORT),ADDR=0,TIMEOUT=1,NAME=BPM2")

# BPM instance 1 channels
# C = index for AD addr
# N = substitution for DB
# NAME = name for OPI
iocshLoad("$(PWD)/bpm_channel.cmd", "C=10, N=I1-AM, NAME=A Magnitude")
iocshLoad("$(PWD)/bpm_channel.cmd", "C=11, N=I1-BM, NAME=B Magnitude")
iocshLoad("$(PWD)/bpm_channel.cmd", "C=12, N=I1-CM, NAME=C Magnitude")
iocshLoad("$(PWD)/bpm_channel.cmd", "C=13, N=I1-DM, NAME=D Magnitude")
iocshLoad("$(PWD)/bpm_channel.cmd", "C=14, N=I1-AA, NAME=A Angle")
iocshLoad("$(PWD)/bpm_channel.cmd", "C=15, N=I1-BA, NAME=B Angle")
iocshLoad("$(PWD)/bpm_channel.cmd", "C=16, N=I1-CA, NAME=C Angle")
iocshLoad("$(PWD)/bpm_channel.cmd", "C=17, N=I1-DA, NAME=D Angle")
iocshLoad("$(PWD)/bpm_channel.cmd", "C=18, N=I1-SM, NAME=SUM Magnitude")
iocshLoad("$(PWD)/bpm_channel.cmd", "C=19, N=I1-SA, NAME=SUM Angle")
iocshLoad("$(PWD)/bpm_channel.cmd", "C=20, N=I1-XP, NAME=X Position")
iocshLoad("$(PWD)/bpm_channel.cmd", "C=21, N=I1-YP, NAME=Y Position")

# BPM instance 2 channels
iocshLoad("$(PWD)/bpm_channel.cmd", "C=22, N=I2-AM, NAME=A Magnitude")
iocshLoad("$(PWD)/bpm_channel.cmd", "C=23, N=I2-BM, NAME=B Magnitude")
iocshLoad("$(PWD)/bpm_channel.cmd", "C=24, N=I2-CM, NAME=C Magnitude")
iocshLoad("$(PWD)/bpm_channel.cmd", "C=25, N=I2-DM, NAME=D Magnitude")
iocshLoad("$(PWD)/bpm_channel.cmd", "C=26, N=I2-AA, NAME=A Angle")
iocshLoad("$(PWD)/bpm_channel.cmd", "C=27, N=I2-BA, NAME=B Angle")
iocshLoad("$(PWD)/bpm_channel.cmd", "C=28, N=I2-CA, NAME=C Angle")
iocshLoad("$(PWD)/bpm_channel.cmd", "C=29, N=I2-DA, NAME=D Angle")
iocshLoad("$(PWD)/bpm_channel.cmd", "C=30, N=I2-SM, NAME=SUM Magnitude")
iocshLoad("$(PWD)/bpm_channel.cmd", "C=31, N=I2-SA, NAME=SUM Angle")
iocshLoad("$(PWD)/bpm_channel.cmd", "C=32, N=I2-XP, NAME=X Position")
iocshLoad("$(PWD)/bpm_channel.cmd", "C=33, N=I2-YP, NAME=Y Position")

# BPM instance 1 & 2 reference channel
iocshLoad("$(PWD)/bpm_channel.cmd", "C=34, N=RF-M, NAME=Reference Magnitude")
iocshLoad("$(PWD)/bpm_channel.cmd", "C=35, N=RF-A, NAME=Reference Angle")

# PV aliases with BPM 1 & 2 instance NS prefix
dbLoadRecords("$(PWD)/aliases.db",  "FROM=$(ACQ_PREFIX), TO=$(SYSTEM1):, I=I1")
dbLoadRecords("$(PWD)/aliases.db",  "FROM=$(ACQ_PREFIX), TO=$(SYSTEM2):, I=I2")

# set_requestfile_path("./")
# set_requestfile_path("$(BPMAPP)/req")
# set_requestfile_path("$(ADSIS8300BPM)/req")
# set_requestfile_path("$(ADSIS8300)/req")
# set_requestfile_path("$(ADCORE)/req")
# set_requestfile_path("$(BUSY)/req")
# set_requestfile_path("$(SSCAN)/req")
# set_requestfile_path("$(CALC)/req")
# set_savefile_path("./autosave")
# set_pass0_restoreFile("auto_settings.sav")
# set_pass1_restoreFile("auto_settings.sav")
# save_restoreSet_status_prefix("$(ACQ_PREFIX)")
# dbLoadRecords("save_restoreStatus.db", "P=$(ACQ_PREFIX)")

# asynSetTraceIOMask("$(ACQ_PORT)",0,2)
# asynSetTraceMask("$(ACQ_PORT)",0,255)
