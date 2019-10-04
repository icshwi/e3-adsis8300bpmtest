###############################################################################
#
# PBI system   : Beam Position Monitor
# Location     : lab
#
# Support      : https://jira.esss.lu.se/projects/WP7BPM
#
###############################################################################

# LOCATION: location of the system (section-subsection)
epicsEnvSet("RACKROW",                      "LAB-666Row")
epicsEnvSet("SECTION",                      "LAB-010")

# INSTANCEx: PBI device name (discipline-device-index)
epicsEnvSet("SLOT1",                        "PBI-BPM-001")
epicsEnvSet("SLOT2",                        "PBI-BPM-002")
# SYSTEMx: system name (LOCATION:SYSTEM)
epicsEnvSet("SYSTEM1",                      "$(SECTION):$(SLOT1)")
epicsEnvSet("SYSTEM2",                      "$(SECTION):$(SLOT2)")
# Note: above values should come from ESS Naming service

# ACQ_DEVID: digitizer device index (from list of /dev/sis8300-n path)
epicsEnvSet("ACQ_DEVID",                    "4")
# ACQ_UNIT: acquisition sub unit logical name
# 8x MEBT BPM SIS8300 AMCs: FEB-050Row:PBI-AMC-011 .. FEB-050Row:PBI-AMC-018
epicsEnvSet("ACQ_UNIT",                     "PBI-AMC-011")
# ACQ_SAMPLES: maximum number of samples to acquire
#              300k per channel per rate (14 Hz), this is conservative
#              when looking at ~88Msps for 3ms of pulse length.
epicsEnvSet("ACQ_SAMPLES",                  "300000")

# EVR_DEVID: EVR device PCI ID (from lspci)
epicsEnvSet("EVR_DEVID",                    "0d:00.0")
# EVR_UNIT: EVR unit logical name
# 1x MEBT BPM: EVR FEB-050Row:PBI-EVR-010
epicsEnvSet("EVR_UNIT",                     "PBI-EVR-010")

# Work around EVR PV names
epicsEnvSet("EVR_S",                   "LAB")
epicsEnvSet("EVR_D",                   "010:PBI-EVR-010")


# EM_DEVID: EthMod device IP:port
epicsEnvSet("EM_DEVID",                     "192.168.1.100:1002")
# 1x MEBT BPM LOD: FEB-050Row:PBI-LOD-001FEB for all 8x AMCs
epicsEnvSet("EM_UNIT",                      "PBI-LOD-001")
