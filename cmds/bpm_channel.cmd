###############################################################################
# BPM channel

# ACQ_PREFIX =
# ACQ_PORT =
# ACQ_PREFIX =
# C = analog input channel index for AD
# N = analog input channel name for DB
# NAME = Name that can be used in OPI
# ACQ_SAMPLES = maximum number of samples

# Controls for analog input channel
dbLoadRecords("sis8300bpmN.template", "P=$(ACQ_PREFIX),R=$(N)-,PORT=$(ACQ_PORT),ADDR=$(C),TIMEOUT=1,NAME=$(NAME)")

# Trace for BPM data
NDTraceConfigure("$(N).TRC", 3, 0, "$(ACQ_PORT)", $(C))
# no data conversion
dbLoadRecords("NDTrace.template", "P=$(ACQ_PREFIX),R=$(N)-TR1-,PORT=$(N).TRC,ADDR=0,TIMEOUT=1,NDARRAY_PORT=$(ACQ_PORT),NDARRAY_ADDR=$(C),TYPE=Int16,FTVL=SHORT,NELEMENTS=$(ACQ_SAMPLES),TIME_LINK=$(ACQ_PREFIX)TickValueIQR CP,NAME=$(NAME),ENABLED=1")
# with data conversion
dbLoadRecords("NDTrace.template", "P=$(ACQ_PREFIX),R=$(N)-TR2-,PORT=$(N).TRC,ADDR=0,TIMEOUT=1,NDARRAY_PORT=$(ACQ_PORT),NDARRAY_ADDR=$(C),TYPE=Float32,FTVL=FLOAT,NELEMENTS=$(ACQ_SAMPLES),TIME_LINK=$(ACQ_PREFIX)TickValueR CP,NAME=$(NAME),ENABLED=1")
