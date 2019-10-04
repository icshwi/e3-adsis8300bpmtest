###############################################################################
# Top script that includes other sub unit scripts.

errlogInit(20000)

# EPICS_CA_MAX_ARRAY_BYTES: 10 MB max CA request
epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES",     "10000000")

# digitizer support
< dataAcquisition.cmd

# timing support
< timing.cmd

# ethmod support
# < ethmod.cmd

###############################################################################

iocInit()

###############################################################################

# save things every thirty seconds
# create_monitor_set("auto_settings.req", 30, "P=$(ACQ_PREFIX)")

###############################################################################

< post_init_e3.cmd

#######################################
#     End of IOC startup commands     #
#######################################
