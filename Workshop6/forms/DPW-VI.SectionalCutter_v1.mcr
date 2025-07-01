#!MC 1200
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#   DPW-VI SECTIONAL CUTTER (Version 1 - 11 MARCH 2016)
#      TO BE USED WITH: DPW-V SECTIONAL CUT DATA SUBMITTAL FORM (Version 1 - 11 MARCH 2016)
#
#       INSTRUCTIONS:
#                  1.   Load Wing Surface Zones into Tecplot (i.e. Remove Fuselage Zones)
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
$!VARSET |FILE|  = "/PATHtoFILE/SectionalCuts.plt"
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
# Create Sectional Cutting Macro Function
#--------------------------------------
$!MACROFUNCTION
NAME = "SECTIONALCUTTER"
$!GLOBALTHREED SLICE{ORIGIN{X = |1| Y = |2| Z = |3|}}
$!GLOBALTHREED SLICE{NORMAL{X = |4| Y = |5| Z = |6|}}
$!CREATESLICEZONEFROMPLANE SLICESOURCE = SURFACEZONES
  FORCEEXTRACTIONTOSINGLEZONE = YES
  COPYCELLCENTEREDVALUES = NO
$!ENDMACROFUNCTION
#===================================================================

#===================================================================
# Prepare Variable Names & Positions
#--------------------------------------
#$!IF "|CP|" == ""
#  $!ALTERDATA EQUATION = "{CPo}  = -999"
#  $!VARSET |CP|        = "|NUMVARS|"
#$!ENDIF
$!IF "|CFX|" == ""
  $!ALTERDATA EQUATION = "{CFXo} = -999"
  $!VARSET |CFX|       = "|NUMVARS|"
$!ENDIF
$!IF "|CFY|" == ""
  $!ALTERDATA EQUATION = "{CFYo} = -999"
  $!VARSET |CFY|       = "|NUMVARS|"
$!ENDIF
$!IF "|CFZ|" == ""
  $!ALTERDATA EQUATION = "{CFZo} = -999"
  $!VARSET |CFZ|       = "|NUMVARS|"
$!ENDIF
$!RENAMEDATASETVAR VAR = |X|   NAME = "Xo"
$!RENAMEDATASETVAR VAR = |Y|   NAME = "Yo"
$!RENAMEDATASETVAR VAR = |Z|   NAME = "Zo"
$!RENAMEDATASETVAR VAR = |CP|  NAME = "CPo"
$!RENAMEDATASETVAR VAR = |CFX| NAME = "CFXo"
$!RENAMEDATASETVAR VAR = |CFY| NAME = "CFYo"
$!RENAMEDATASETVAR VAR = |CFZ| NAME = "CFZo"
$!IF "|CF|" == ""
  $!ALTERDATA EQUATION = "{CFo}  = SQRT({CFXo}**2 + {CFYo}**2 + {CFZo}**2)"
  $!VARSET |CF|        = "|NUMVARS|"
$!ENDIF
$!RENAMEDATASETVAR VAR = |CF|  NAME = "CFo"
$!ALTERDATA EQUATION   = "{X}   = {Xo}"
$!VARSET |NUMVARS0|    = |NUMVARS|
$!ALTERDATA EQUATION   = "{Y}   = {Yo}"
$!ALTERDATA EQUATION   = "{Z}   = {Zo}"
$!ALTERDATA EQUATION   = "{CP}  = {CPo}"
$!ALTERDATA EQUATION   = "{CF}  = {CFo}"
$!ALTERDATA EQUATION   = "{CFX} = {CFXo}"
$!ALTERDATA EQUATION   = "{CFY} = {CFYo}"
$!ALTERDATA EQUATION   = "{CFZ} = {CFZo}"
$!VARSET |NUMVARS1|    = |NUMVARS|
#===================================================================

#===================================================================
# Establish Zone Number For Cut Data
#--------------------------------------
$!VARSET |NUMZONES0|   = |NUMZONES|
$!VARSET |NUMZONES1|   = |NUMZONES|
$!VARSET |NUMZONES1|  += 1
#===================================================================

#===================================================================
# Create Sectional Cuts
#--------------------------------------
# WING SECTION  1: ETA = 0.1050, CHORD=466.466
 $!RUNMACROFUNCTION "SECTIONALCUTTER" ( 993.728, 121.459, 176.053,0.000,1.000,0.000)

# WING SECTION  2: ETA = 0.1150, CHORD=459.571
$!RUNMACROFUNCTION "SECTIONALCUTTER" (1002.168, 133.026, 176.306,0.000,1.000,0.000)

# WING SECTION  3: ETA = 0.1250, CHORD=452.687
$!RUNMACROFUNCTION "SECTIONALCUTTER" (1010.656, 144.594, 176.539,0.000,1.000,0.000)

# WING SECTION  4: ETA = 0.1306, CHORD=448.836
$!RUNMACROFUNCTION "SECTIONALCUTTER" (1015.435, 151.074, 176.659,0.000,1.000,0.000)

# WING SECTION  5: ETA = 0.2009, CHORD=400.743
$!RUNMACROFUNCTION "SECTIONALCUTTER" (1076.873, 232.444, 177.509,0.000,1.000,0.000)

# WING SECTION  6: ETA = 0.2828, CHORD=344.991
$!RUNMACROFUNCTION "SECTIONALCUTTER" (1148.974, 327.074, 178.606,0.000,1.000,0.000)

# WING SECTION  7: ETA = 0.3430, CHORD=304.101
$!RUNMACROFUNCTION "SECTIONALCUTTER" (1202.038, 396.765, 180.222,0.000,1.000,0.000)

# WING SECTION  8: ETA = 0.3700, CHORD=285.806
$!RUNMACROFUNCTION "SECTIONALCUTTER" (1225.822, 427.998, 181.162,0.000,1.000,0.000)

# WING SECTION  9: ETA = 0.3971, CHORD=278.111
$!RUNMACROFUNCTION "SECTIONALCUTTER" (1249.711, 459.370, 182.250,0.000,1.000,0.000)

# WING SECTION 10: ETA = 0.5024, CHORD=248.312
$!RUNMACROFUNCTION "SECTIONALCUTTER" (1342.440, 581.148, 188.658,0.000,1.000,0.000)

# WING SECTION 11: ETA = 0.6028, CHORD=219.904
$!RUNMACROFUNCTION "SECTIONALCUTTER" (1430.914, 697.333, 198.060,0.000,1.000,0.000)

# WING SECTION 12: ETA = 0.7268, CHORD=184.844
$!RUNMACROFUNCTION "SECTIONALCUTTER" (1540.091, 840.704, 213.659,0.000,1.000,0.000)

# WING SECTION 13: ETA = 0.8456, CHORD=151.235
$!RUNMACROFUNCTION "SECTIONALCUTTER" (1644.738, 978.148, 233.317,0.000,1.000,0.000)

# WING SECTION 14: ETA = 0.9500, CHORD=121.735
$!RUNMACROFUNCTION "SECTIONALCUTTER" (1736.708,1098.926, 253.727,0.000,1.000,0.000)

# WING SECTION 15: ETA = 0.9700, CHORD=116.095
$!RUNMACROFUNCTION "SECTIONALCUTTER" (1754.313,1122.048, 257.777,0.000,1.000,0.000)

# WING SECTION 16: ETA = 0.9900, CHORD=110.452
$!RUNMACROFUNCTION "SECTIONALCUTTER" (1771.927,1145.183, 261.823,0.000,1.000,0.000)
#===================================================================

#===================================================================
# Rename Zones With Sectional Cuts
#--------------------------------------
$!VARSET |ZONE| = |NUMZONES0|
$!LOOP 16
  $!VARSET |ZONE| += 1
  $!RENAMEDATASETZONE
    ZONE = |ZONE|
    NAME = '|LABEL| - WING SECTION |LOOP|'
$!ENDLOOP
#===================================================================

#===================================================================
# Visualize Sectional Cuts
#--------------------------------------
$!FIELDLAYERS SHOWMESH          = NO
$!FIELDLAYERS SHOWCONTOUR       = NO
$!FIELDLAYERS SHOWVECTOR        = NO
$!FIELDLAYERS SHOWSCATTER       = NO
$!FIELDLAYERS SHOWSHADE         = NO
$!FIELDLAYERS SHOWEDGE          = NO
$!FIELDLAYERS USELIGHTINGEFFECT = NO
$!FIELDLAYERS USETRANSLUCENCY   = NO
$!FIELDMAP [    1       - |NUMZONES0|] MESH{COLOR = BLACK}
$!FIELDMAP [    1       - |NUMZONES0|] MESH{LINETHICKNESS = 0.10}
$!FIELDMAP [|NUMZONES1| - |NUMZONES| ] MESH{COLOR = GREEN}
$!FIELDMAP [|NUMZONES1| - |NUMZONES| ] MESH{LINETHICKNESS = 0.80}
$!FIELDMAP [    1       - |NUMZONES| ] MESH{SHOW = NO}
$!FIELDMAP [    1       - |NUMZONES0|] MESH{SHOW = YES}
$!FIELDMAP [|NUMZONES1| - |NUMZONES| ] MESH{SHOW = YES}
$!FIELDLAYERS SHOWMESH    = YES
$!REDRAWALL
#===================================================================

#===================================================================
# Write Sectional Cuts To |FILE|
#--------------------------------------
$!SETDATASETTITLE "SectionalCuts"
$!WRITEDATASET  "|FILE|"
  ASSOCIATELAYOUTWITHDATAFILE = NO
  INCLUDEAUTOGENFACENEIGHBORS = NO
  INCLUDECUSTOMLABELS         = NO
  INCLUDEDATA                 = YES
  INCLUDEDATASHARELINKAGE     = NO
  INCLUDEGEOM                 = NO
  INCLUDETEXT                 = NO
  BINARY                      = NO
  USEPOINTFORMAT              = YES
  PRECISION                   = 12
  TECPLOTVERSIONTOWRITE       = TECPLOTCURRENT
  VARPOSITIONLIST             = [|NUMVARS0|  - |NUMVARS1|]
  ZONELIST                    = [|NUMZONES1| - |NUMZONES|]
#===================================================================

#===================================================================
# Delete Zones With Sectional Cuts 
#--------------------------------------
#$!DELETEZONES  [|NUMZONES1|-|NUMZONES|]
#===================================================================
