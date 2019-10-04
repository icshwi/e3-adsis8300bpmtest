#
# XXX Needs refactoring and testing with new HW when available!
#


# epicsEnvSet("EPICS_CA_ADDR_LIST", "127.0.0.1")
# epicsEnvSet("EPICS_CA_ADDR_LIST", "192.168.1.100")
# epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST", "NO")

# Prefix for all records
epicsEnvSet("EM_PREFIX",            "$(RACKROW):$(EM_UNIT):")
epicsEnvSet("EM_PORT",              "EM.$(ACQ_DEVID)")

epicsEnvSet("I2C_TMP100_PORT",      "AK_I2C_TMP100")
epicsEnvSet("I2C_DS28CM00_PORT",    "AK_I2C_DS28CM00")
epicsEnvSet("I2C_PCF85063TP_PORT",  "AK_I2C_PCF85063TP")
epicsEnvSet("I2C_TCA9555_PORT",     "AK_I2C_TCA9555")
epicsEnvSet("I2C_LTC2991_PORT",     "AK_I2C_LTC2991")
epicsEnvSet("I2C_M24M02_PORT",      "AK_I2C_M24M02")
epicsEnvSet("I2C_IP_PORT",          "AK_I2C_COMM")

###
# I2C
###
# Create the asyn port to talk to the AK-NORD server on command port 1002.
drvAsynIPPortConfigure($(I2C_IP_PORT),"192.168.1.100:1002")
#asynSetTraceIOMask($(I2C_IP_PORT),0,255)
#asynSetTraceMask($(I2C_IP_PORT),0,255)

# AKI2CTMP100Configure(const char *portName, const char *ipPort,
#        int devCount, const char *devInfos, int priority, int stackSize);
AKI2CTMP100Configure($(I2C_TMP100_PORT), $(I2C_IP_PORT), 7, "0x49; 0x4A; 0x4B; 0x4C; 0x4D; 0x4E; 0x4F", 1, 0, 0)
dbLoadRecords("AKI2C_TMP100.db",       "P=$(PREFIX),R=I2C1:Temp1:,PORT=$(I2C_TMP100_PORT),IP_PORT=$(I2C_IP_PORT),ADDR=0,TIMEOUT=1")
dbLoadRecords("AKI2C_TMP100.db",       "P=$(PREFIX),R=I2C1:Temp2:,PORT=$(I2C_TMP100_PORT),IP_PORT=$(I2C_IP_PORT),ADDR=1,TIMEOUT=1")
dbLoadRecords("AKI2C_TMP100.db",       "P=$(PREFIX),R=I2C1:Temp3:,PORT=$(I2C_TMP100_PORT),IP_PORT=$(I2C_IP_PORT),ADDR=2,TIMEOUT=1")
dbLoadRecords("AKI2C_TMP100.db",       "P=$(PREFIX),R=I2C1:Temp4:,PORT=$(I2C_TMP100_PORT),IP_PORT=$(I2C_IP_PORT),ADDR=3,TIMEOUT=1")
dbLoadRecords("AKI2C_TMP100.db",       "P=$(PREFIX),R=I2C1:Temp5:,PORT=$(I2C_TMP100_PORT),IP_PORT=$(I2C_IP_PORT),ADDR=4,TIMEOUT=1")
dbLoadRecords("AKI2C_TMP100.db",       "P=$(PREFIX),R=I2C1:Temp6:,PORT=$(I2C_TMP100_PORT),IP_PORT=$(I2C_IP_PORT),ADDR=5,TIMEOUT=1")
dbLoadRecords("AKI2C_TMP100.db",       "P=$(PREFIX),R=I2C1:Temp7:,PORT=$(I2C_TMP100_PORT),IP_PORT=$(I2C_IP_PORT),ADDR=6,TIMEOUT=1")
#asynSetTraceIOMask($(I2C_TMP100_PORT),0,255)
#asynSetTraceMask($(I2C_TMP100_PORT),0,255)

# AKI2CM24M02Configure(const char *portName, const char *ipPort,
#        int devCount, const char *devInfos, int priority, int stackSize);
AKI2CM24M02Configure($(I2C_M24M02_PORT), $(I2C_IP_PORT), 1, "0x50", 1, 0, 0)
dbLoadRecords("AKI2C_M24M02.db",       "P=$(PREFIX),R=I2C1:Eeprom1:,PORT=$(I2C_M24M02_PORT),IP_PORT=$(I2C_IP_PORT),ADDR=0,TIMEOUT=1,NELM=262144")
#asynSetTraceIOMask($(I2C_M24M02_PORT),0,255)
#asynSetTraceMask($(I2C_M24M02_PORT),0,255)

# AKI2CTCA9555Configure(const char *portName, const char *ipPort,
#        int devCount, const char *devInfos, int priority, int stackSize);
AKI2CTCA9555Configure($(I2C_TCA9555_PORT), $(I2C_IP_PORT), 1, "0x21", 1, 0, 0)
dbLoadRecords("AKI2C_TCA9555.db",        "P=$(PREFIX),R=I2C1:IOExp1:,PORT=$(I2C_TCA9555_PORT),IP_PORT=$(I2C_IP_PORT),ADDR=0,TIMEOUT=1")
#asynSetTraceIOMask($(I2C_TCA9555_PORT),0,255)
#asynSetTraceMask($(I2C_TCA9555_PORT),0,255)

# AKI2CLTC2991Configure(const char *portName, const char *ipPort,
#        int devCount, const char *devInfos, int priority, int stackSize);
AKI2CLTC2991Configure($(I2C_LTC2991_PORT), $(I2C_IP_PORT), 1, "0x48", 0, 0, 1, 0, 0)
dbLoadRecords("AKI2C_LTC2991.db",        "P=$(PREFIX),R=I2C1:VMon1:,PORT=$(I2C_LTC2991_PORT),IP_PORT=$(I2C_IP_PORT),ADDR=0,TIMEOUT=1")
#asynSetTraceIOMask($(I2C_LTC2991_PORT),0,255)
#asynSetTraceMask($(I2C_LTC2991_PORT),0,255)
