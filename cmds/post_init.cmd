###############################################################################
# Initialization after iocBoot()

### timing configuration
# See timing.cmd for macro substitutions used here.

## standalone mode only

# example for standalone mode found at
# https://github.com/icshwi/e3-mrfioc2/blob/master/cmds/MTCA-EVR-300_standalone_template.cmd
# uncomment the lines below to enable EVR built-in sequencer acting as EVG
# comment out when receiving events from EVG

### Get current time from system clock ###
dbpf $(EVR_PREFIX)TimeSrc-Sel "Sys. Clock"

### Set up the prescaler that will trigger the sequencer at 14 Hz ###
# Event rate = clock rate / prescaler
# EVG clock rate
#   14 Hz ~= 88052500 / 6289464
#   1 Hz  ~= 88052500 / 88052500
# standalone mode (88.05194802 MHz internal clock)
#   14 Hz ~= 88051948 / 6289424
#   1 Hz  ~= 88051948 / 88051948
dbpf $(EVR_PREFIX)PS0-Div-SP 6289424
# dbpf $(EVR_PREFIX)PS0-Div-SP 88051948

### Set up the sequencer ###
dbpf $(EVR_PREFIX)SoftSeq0-RunMode-Sel "Normal"
dbpf $(EVR_PREFIX)SoftSeq0-TrigSrc-2-Sel "Prescaler 0"
dbpf $(EVR_PREFIX)SoftSeq0-TsResolution-Sel "uSec"
dbpf $(EVR_PREFIX)SoftSeq0-Load-Cmd 1
dbpf $(EVR_PREFIX)SoftSeq0-Enable-Cmd 1

### Run the script that configures the events and timestamp of the sequence ###
# # system("/bin/sh ./configure_sequencer_14Hz.sh $(LOC):PBI $(EVR_UNIT)")
# XXX: can not use dbpf since it can not handle arrays of numbers..
system "caput -a $(EVR_PREFIX)SoftSeq0-EvtCode-SP 2 14 127 >/dev/null"
system "caput -a $(EVR_PREFIX)SoftSeq0-Timestamp-SP 2 0 1 >/dev/null"
system "caput    $(EVR_PREFIX)SoftSeq0-Commit-Cmd 1 >/dev/null"

## end of standalone mode only

## normal and standalone configuration

### bugfix for EVR loosing the timestamp for 5 seconds every 7-8 hours
dbpf $(EVR_PREFIX)DC-Tgt-SP 70

### trigger setup
# backplane trigger line X
#  backplane line X; X=0..7
#  Y; DlyGenY
#  dbpf $(EVR_PREFIX)OutBackX-Src-SP Y
# front panel trigger line X
#  backplane line X; X=0..3
#  dbpf $(EVR_PREFIX)OutFPX-Src-SP Y

## BPM PULSE START
dbpf $(EVR_PREFIX)DlyGen0-Evt-Trig0-SP $(EVENT_TRIGGER)
# trigger pulse width in us resolution (see SoftSeq0-TsResolution-Sel)
dbpf $(EVR_PREFIX)DlyGen0-Width-SP $(PULSE_WIDTH)
# trigger from delay generator 0
dbpf $(EVR_PREFIX)DlyGen0-Delay-SP $(PULSE_START)
# backplane 1 line
dbpf $(EVR_PREFIX)OutBack1-Src-SP 0

## BPM PULSE END
dbpf $(EVR_PREFIX)DlyGen1-Evt-Trig0-SP $(EVENT_TRIGGER)
# trigger pulse width in us resolution (see SoftSeq0-TsResolution-Sel)
dbpf $(EVR_PREFIX)DlyGen1-Width-SP $(PULSE_WIDTH)
# trigger from delay generator 0
dbpf $(EVR_PREFIX)DlyGen1-Delay-SP $(PULSE_END)
# backplane 2 line
dbpf $(EVR_PREFIX)OutBack2-Src-SP 1

# front panel 0
dbpf $(EVR_PREFIX)OutFP0-Src-SP 0
# front panel 1
dbpf $(EVR_PREFIX)OutFP1-Src-SP 1
# front panel 2
# dbpf $(EVR_PREFIX)OutFP2-Src-SP 0
# front panel 3
# dbpf $(EVR_PREFIX)OutFP3-Src-SP 0

### send event clock over backplane clock line TCLKB
# MCH should be configured to send the clock back to the AMCs over TCLKA
# dbpf $(EVR_PREFIX)OutTCLKB-Src-SP 63
# dbpf $(EVR_PREFIX)OutTCLKB-Ena-Sel 1
# dbpf $(EVR_PREFIX)OutTCLKB-Pwr-Sel 1
# dbpf $(EVR_PREFIX)OutTCLKB-Pat-Low00_15-SP.BF 1
# dbpf $(EVR_PREFIX)OutTCLKB-Pat-Low00_15-SP.BE 1
# dbpf $(EVR_PREFIX)OutTCLKB-Pat-Low00_15-SP.BD 1
# dbpf $(EVR_PREFIX)OutTCLKB-Pat-Low00_15-SP.BC 1
# dbpf $(EVR_PREFIX)OutTCLKB-Pat-Low00_15-SP.BB 1
# dbpf $(EVR_PREFIX)OutTCLKB-Pat-Low00_15-SP.BA 1
# dbpf $(EVR_PREFIX)OutTCLKB-Pat-Low00_15-SP.B9 1
# dbpf $(EVR_PREFIX)OutTCLKB-Pat-Low00_15-SP.B8 1
# dbpf $(EVR_PREFIX)OutTCLKB-Pat-Low00_15-SP.B7 1
# dbpf $(EVR_PREFIX)OutTCLKB-Pat-Low00_15-SP.B6 1
# dbpf $(EVR_PREFIX)OutTCLKB-Pat-Low00_15-SP.B5 1
# dbpf $(EVR_PREFIX)OutTCLKB-Pat-Low00_15-SP.B4 1
# dbpf $(EVR_PREFIX)OutTCLKB-Pat-Low00_15-SP.B3 1
# dbpf $(EVR_PREFIX)OutTCLKB-Pat-Low00_15-SP.B2 1
# dbpf $(EVR_PREFIX)OutTCLKB-Pat-Low00_15-SP.B1 1
# dbpf $(EVR_PREFIX)OutTCLKB-Pat-Low00_15-SP.B0 1
# dbpf $(EVR_PREFIX)OutTCLKB-Pat-Low16_31-SP.BF 1
# dbpf $(EVR_PREFIX)OutTCLKB-Pat-Low16_31-SP.BE 1
# dbpf $(EVR_PREFIX)OutTCLKB-Pat-Low16_31-SP.BD 1
# dbpf $(EVR_PREFIX)OutTCLKB-Pat-Low16_31-SP.BC 1

## normal and standalone configuration

## setup timestamping

# acquisition results
# dbpf $(SYSTEM):AMC31-AOI11-ArrayCounter_RBV.TSEL $(EVR_PREFIX)Time-I.TIME
# dbpf $(SYSTEM):AMC31-AOI11-ArrayData.TSEL $(EVR_PREFIX)Time-I.TIME
# dbpf $(SYSTEM):AMC31-AOI11-MaxValueR.TSEL $(EVR_PREFIX)Time-I.TIME
# dbpf $(SYSTEM):AMC31-AOI11-MeanValueR.TSEL $(EVR_PREFIX)Time-I.TIME
# dbpf $(SYSTEM):AMC31-AOI11-MinValueR.TSEL $(EVR_PREFIX)Time-I.TIME
# dbpf $(SYSTEM):AMC31-AOI11-SizeR.TSEL $(EVR_PREFIX)Time-I.TIME
# dbpf $(SYSTEM):AMC31-AOI11-StartR.TSEL $(EVR_PREFIX)Time-I.TIME
# dbpf $(SYSTEM):AMC31-AOI11-TSMaxValue.TSEL $(EVR_PREFIX)Time-I.TIME
# dbpf $(SYSTEM):AMC31-AOI11-TSMeanValue.TSEL $(EVR_PREFIX)Time-I.TIME
# dbpf $(SYSTEM):AMC31-AOI11-TSMinValue.TSEL $(EVR_PREFIX)Time-I.TIME
# bias status
# dbpf $(SYSTEM):HV06-BiasR.TSEL $(EVR_PREFIX)Time-I.TIME
# dbpf $(SYSTEM):HV06-CurrR.TSEL $(EVR_PREFIX)Time-I.TIME
# dbpf $(SYSTEM):HV06-VoltR.TSEL $(EVR_PREFIX)Time-I.TIME
# motion, limit switches
# dbpf $(SYSTEM):MCU08-InsertedR.TSEL $(EVR_PREFIX)Time-I.TIME
# dbpf $(SYSTEM):MCU08-LimitInR.TSEL $(EVR_PREFIX)Time-I.TIME
# dbpf $(SYSTEM):MCU08-LimitOutR.TSEL $(EVR_PREFIX)Time-I.TIME
# dbpf $(SYSTEM):MCU08-MovePermitR.TSEL $(EVR_PREFIX)Time-I.TIME
# dbpf $(SYSTEM):MCU08-WaterFlowR.TSEL $(EVR_PREFIX)Time-I.TIME

## enable the EVR
dbpf $(EVR_PREFIX)Ena-Sel "Enabled"

# ## setup TIFF saving for channel 1 background
# dbpf $(ACQ_PREFIX)1-TF1-FilePath "$(PWD)"
# dbpf $(ACQ_PREFIX)1-TF1-FileName "channel1_bg"
# dbpf $(ACQ_PREFIX)1-TF1-FileTemplate "%s%s.tiff"
# ## setup TIFF loading for channel 1 background
# dbpf $(ACQ_PREFIX)1-PR1-TF-FilePath "$(PWD)"
# dbpf $(ACQ_PREFIX)1-PR1-TF-FileName "channel1_bg"
# dbpf $(ACQ_PREFIX)1-PR1-TF-FileTemplate "%s%s.tiff"

# setup acquisition parameters
dbpf $(ACQ_PREFIX)NumSamples 131072
dbpf $(ACQ_PREFIX)ClockSource 6
dbpf $(ACQ_PREFIX)ClockDiv 1
dbpf $(ACQ_PREFIX)SamplingFreq 88052500
dbpf $(ACQ_PREFIX)RTMType 4
# enable all AI &  BPM channels
dbpf $(ACQ_PREFIX)CHControlAll 1
