########################################
#        IOC startup entry point       #
########################################

# Loading of all required modules and versions
require busy,1.7.0
require autosave,5.9.0
require asyn,4.33.0
require ADCore,3.3.2
require admisc,develop

require mrfioc2,2.2.0-rc5

require adsis8300test,bpm
require adsis8300bpmtest,mebt

# instance.cmd defines all variables that differe between instances of this
# IOC. For example hardware IDs, Naming service names,..
< instance.cmd

##############################################################################
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
