#!MC 1410
$!VarSet |MFBD| = '/'
##++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#   DPW-VI NACELLE SECTIONAL CUTTER (Version 1 - 11 MARCH 2016)
#      TO BE USED WITH: DPW-V SECTIONAL CUT DATA SUBMITTAL FORM (Version 4 - 22 April 2016)
#
#       INSTRUCTIONS:
#                  1.   Load Nacelle Surface Zones into Tecplot (i.e. Remove Fuselage, wing, pylon Zones)
#                  2.   Assign LABEL variable as the "XXX" identifier of the dataset
#                  3.   Assign FILE variable to the path & filename to write out sectional cut data
#                  4.   Assign (X,Y,Z) variables to the variable number in dataset (typically 1,2,3)
#                  5.   Assign CP variable to the variable number in dataset (typically 4)
#                  6.   Assign CF variable to the variable number in dataset (if exists)
#                  7.   Assign CFX,CFY,CFZ variables to the variable number in dataset (if exists)
#                  8.   Run macro and verify output to |FILE|
#                  9.   Copy zone data into data form (DPW-V.DataForm_SectionalCuts_v0.plt)
#
#                XXX:	First-author participant's last name + specific identifier if submitting
#                       multiple grid types, soln methods, turb models, etc.
#                       EXAMPLES:  JonesG-CommonMB-SST-1
#                                  JonesG-CommonOverset-SA-1
#                                  JonesG-CommonOverset-SA-2
#                                  JonesG-CommonHex-kw-1
#                                  JonesG-CommonHybrid-ke-1
#                                  JonesG-CommonPrism-SST-1
#                                  JonesG-Custom-SA-1
#                                  etc.
#
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
$!VARSET |LABEL| = "XXX"
$!VARSET |FILE|  = "/PATHtoFILE/NacelleCuts.plt"
$!VARSET |X|     = "1" 	# Variable Number for X   (Required)
$!VARSET |Y|     = "2" 	# Variable Number for Y   (Required)
$!VARSET |Z|     = "3" 	# Variable Number for Z   (Required)
$!VARSET |CP|    = "4" 	# Variable Number for CP  (Required)
$!VARSET |CF|    = "5" 	# Variable Number for CF  (Leave Blank If Not In Data)
$!VARSET |CFX|   = "" 	# Variable Number for CFX (Leave Blank If Not In Data)
$!VARSET |CFY|   = "" 	# Variable Number for CFY (Leave Blank If Not In Data)
$!VARSET |CFZ|   = "" 	# Variable Number for CFZ (Leave Blank If Not In Data)
#++++++++++++++++++++++++++++++++++++++ END USER INPUTS +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#===================================================================
# SET UP SLICE EXTRACTION
#--------------------------------------
#
$!SLICELAYERS SHOW = YES
$!SLICEATTRIBUTES 1  SLICESURFACE = ARBITRARY
$!SLICEATTRIBUTES 1  SLICESOURCE = SURFACESOFVOLUMEZONES
$!SLICEATTRIBUTES 1  PRIMARYPOSITION{X = 1150.0}
$!SLICEATTRIBUTES 1  PRIMARYPOSITION{Y = 391.40}
$!SLICEATTRIBUTES 1  PRIMARYPOSITION{Z = 74.33}
#===================================================================
# Create Nacelle Cuts
#--------------------------------------
#
$!BLANKING VALUE{INCLUDE = YES}
$!BLANKING VALUE{CONSTRAINT 1 {INCLUDE = YES}}
#
# NACELLE PS2X AND PS5X CUTS
$!SLICEATTRIBUTES 1  NORMAL{X = 0.01}
$!SLICEATTRIBUTES 1  NORMAL{Y = -0.1}
$!SLICEATTRIBUTES 1  NORMAL{Z = 1.0}
#
$!BLANKING VALUE{CONSTRAINT 1 {VARA = 2}}
$!BLANKING VALUE{CONSTRAINT 1 {VALUECUTOFF = 391.40}}
$!BLANKING VALUE{CONSTRAINT 1 {RELOP = GREATERTHANOREQUAL}}
$!CREATESLICEZONES 
$!BLANKING VALUE{CONSTRAINT 1 {RELOP = LESSTHANOREQUAL}}
$!CREATESLICEZONES 
#
# NACELLE PS3X AND PS6X CUTS
$!SLICEATTRIBUTES 1  NORMAL{X = 0.04}
$!SLICEATTRIBUTES 1  NORMAL{Y = -0.9}
$!SLICEATTRIBUTES 1  NORMAL{Z = 0.4}
#
$!BLANKING VALUE{CONSTRAINT 1 {VARA = 3}}
$!BLANKING VALUE{CONSTRAINT 1 {VALUECUTOFF = 74.33}}
$!BLANKING VALUE{CONSTRAINT 1 {RELOP = GREATERTHANOREQUAL}}
$!CREATESLICEZONES 
$!BLANKING VALUE{CONSTRAINT 1 {RELOP = LESSTHANOREQUAL}}
$!CREATESLICEZONES 
#
# NACELLE PS1X AND PS4X CUTS
$!SLICEATTRIBUTES 1  NORMAL{X = 0.02}
$!SLICEATTRIBUTES 1  NORMAL{Y = -0.80}
$!SLICEATTRIBUTES 1  NORMAL{Z = -0.60}
$!BLANKING VALUE{CONSTRAINT 1 {RELOP = GREATERTHANOREQUAL}}
$!CREATESLICEZONES 
$!BLANKING VALUE{CONSTRAINT 1 {RELOP = LESSTHANOREQUAL}}
$!CREATESLICEZONES 
#
##++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#  AT THIS POINT 6 ZONE SLICES HAVE BEEN CREATED.  EACH SLICE CONTAINS 1 NACELLE CUT
#
#       "WRITE DATA FILE" CAN BE USED TO WRITE OUT EACH SET OF SLICES, BE SURE TO USE "POINT" FORMAT
#
#		SLICE #1 - PS2X
#		SLICE #2 - PS5X                  
#		SLICE #3 - PS3X
#		SLICE #4 - PS6X
#		SLICE #5 - PS4X                  
#		SLICE #6 - PS1X
#                  
#
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
$!RemoveVar |MFBD|
