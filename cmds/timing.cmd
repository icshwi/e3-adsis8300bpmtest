###############################################################################
# Timing MTCA EVR 300u

# As per EVR MTCA 300 engineering manual ch 5.3.5
# Example found in https://github.com/icshwi/e3-mrfioc2/blob/master/cmds/MTCA-EVR-300_standalone_template.cmd
# mTCA-EVR-300, with the micro-SCSI connector (16 FPUV outputs)
# mTCA-EVR-300U, without micro-SCSI connector, with two slots for universal modules (4 FPUV outputs)

epicsEnvSet("EVR_SYS",       "$(SECTION):")
epicsEnvSet("EVR_DEVICE",    "$(EVR_UNIT):")
epicsEnvSet("EVR_PREFIX",    "$(EVR_SYS)$(EVR_DEVICE)")
# machine event clock, EVR expects MHz
epicsEnvSet("EVENT_CLOCK"    "88.0525")
# event at 14 Hz (machine rate), EVR expects integer
epicsEnvSet("EVENT_TRIGGER"  "14")
# pulse width of 100 us is enough
epicsEnvSet("PULSE_WIDTH"    "100")
# BPM PULSE_START trigger delay
epicsEnvSet("PULSE_START"    "0")
# BPM PULSE_END trigger delay
epicsEnvSet("PULSE_END"      "2860")

# Not use in this script, but it is needed for the expansion. 
epicsEnvSet("MainEvtCODE" "14")
iocshLoad("$(mrfioc2_DIR)/evr-mtca-300.iocsh", "S=$(EVR_S), DEV=$(EVR_D), PCIID=$(EVR_DEVID)")

# Needed with software timestamp source w/o RT thread scheduling ###
var evrMrmTimeNSOverflowThreshold 100000

