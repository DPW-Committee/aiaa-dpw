#!MC 1410
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#   DPW-VII SECTIONAL CUTTER AND SECTIONAL INTEGRATOR (Version 7c - Jun. 10, 2022)
#      v7:  Initial release of macro for DPW-VII
#      v7a: Fix bug in sectional force/moment integration
#      v7b: Add auto-detection of Body/Wing zones
#      v7c: Improved integration process for general surface zone input
#
#      TO BE USED WITH:
#          DPW-VII.DataForm_SectionalCuts_v7.dat
#          DPW-VII.DataForm_Sectional_Lift_and_Moment_Span_v7.dat
#          DPW-VII.DataForm_Sectional_Lift_and_Moment_Alpha_v7.dat (re-arrange Span output as function of angle-of-attack)
#
#       INSTRUCTIONS:
#                  1.   Load Fuselage and Wing Surface Zones into Tecplot
#                  2.   Assign SolutionLabel variable as the identifier of the dataset
#                  3.   Assign FilePrependLabel variable to the filename to write out sectional cut data (recommend using |SolutionLabel|)
#                  4.   Assign OutputDirectoryPath variable to the path to write out sectional cut data
#                  5.   Assign (Xvar,Yvar,Zvar) variables to the variable number in dataset (typically 1,2,3)
#                  6.   Assign CPvar variable to the variable number in dataset (typically 4)
#                  7.   Assign CFvar variable to the variable number in dataset (if exists)
#                  8.   Assign CFXvar,CFYvar,CFZvar variables to the variable number in dataset (if exists)
#                  9.   Assign BodyMaps variable to define which zones define the fuselage surface(s)
#                 10.   Assign WingMaps variable to define which zones define the wing surface(s)
#                 11.   Assign PlotTime variable (if multiple time steps are included in dataset) to define which solution time should be used
#                 12.   Run macro and verify output to:
#                          - |OutputDirectoryPath||FilePrependLabel|.plt
#                          - |OutputDirectoryPath||FilePrependLabel|_SectionalIntegration.plt
#                 13.   Copy sectional cutter data into data form
#                          - DPW-VII.DataForm_SectionalCuts_v7.dat
#                 14.   Copy sectional lift/pitching moment data into data form
#                          - DPW-VII.DataForm_Sectional_Lift_and_Moment_Span_v7.dat
#                 15.   Rearrange output from multiple angles-of-attack cases
#                          - DPW-VII.DataForm_Sectional_Lift_and_Moment_Alpha_v7.dat
#
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
$!DRAWGRAPHICS FALSE


#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#
#            USER CUSTOM READ DATA COMMAND
#            - Go to Scripting --> Record Macro
#            - Manually read your dataset and stop recording
#            - Copy the resulting macro command here
#            - Note the required variables for entry below (variable numbers, maps, etc.)
#
#$!ReadDataSet ...
#  ...
#
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#
#            PLOT OUTPUT LOCATION
#
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

# CaseX - Case [Case1/Case2/Case3/Case4/Case5/Case6]
# XXX   - First-author participant's last name (or organization)
# XxQ   - Condition Q [LoQ/HiQ/NoQ]
# RxxM  - Reynolds Number [05/20/30]
# Lx    - Grid Level [L1/L2/L3/L4/L5/L6]
# Axxx  - Angle of Attack [275/300/325/350/375/400/425]
#         (use C058 for Fixed CL=0.58 case)
#
# Grid/SolverVer/Method/TurbModel should be descriptive labels specific to your case
#
$!VarSet |SolutionLabel|        = 'CaseX_XXX_XxQ_RxxM_Lx_Axxx_Grid_SolverVer_Method_TurbModel'  # Label for this solution

$!VarSet |FilePrependLabel|     = '|SolutionLabel|'  # Prepend output files with this label (recommend |SolutionLabel| variable)
$!VarSet |OutputDirectoryPath|  = ''   # Images will be saved to this path
                                       # NOTE: Use '' if launching Tecplot from the command line within the desired directory

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#
#            PLOT TITLE SOLUTION INFORMATION
#
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

$!VarSet |Q|     = '??Qa###'  # Aeroelastic shape [ie LoQa275/HiQa275/NoQ]
$!VarSet |REYN|  = '??'       # Reynolds number [05 or 20 or 30] (based on reference chord)
$!VarSet |MACH|  = '0.85'     # Mach number
$!VarSet |ALPHA| = '?.????'   # Angle-of-Attack (used in Sectional Lift/Pitching Moment output)
$!VarSet |CL|    = '?.????'   # Lift Coefficient (used in Sectional Lift/Pitching Moment output)
$!VarSet |CD|    = '?.??????' # Drag Coefficient
$!VarSet |CMy|   = '??.?????' # Pitching Moment Coefficient


#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#
$!VarSet |Xvar|   =  1      # Variable number to use for X coordinate (running from fuselage nose to tail)
$!VarSet |Yvar|   =  2      # Variable number to use for Y coordinate (running from symmetry plane to wing tip)
$!VarSet |Zvar|   =  3      # Variable number to use for Z coordinate (running from fuselage keel to crown)
$!VarSet |CPvar|  =  4      # Variable number to use for Cp
$!VarSet |CFvar|  =  8      # Variable number to use for Cf  (use '' if variable does not exists)
$!VarSet |CFXvar| =  5      # Variable number to use for Cfx (use '' if variable does not exists)
$!VarSet |CFYvar| =  6      # Variable number to use for Cfy (use '' if variable does not exists)
$!VarSet |CFZvar| =  7      # Variable number to use for Cfz (use '' if variable does not exists)
$!VarSet |BodyMaps| = '1-1' # Fieldmaps of your dataset to plot for the body/fuselage ('1-2','1,3,5-6',etc.)
$!VarSet |WingMaps| = '2'   # Fieldmaps of your dataset to plot for the wing          ('1-2','1,3,5-6',etc.)
$!VarSet |PlotTime| = ''    # Tecplot SolutionTime variable to export for time-accurate data sets
#                           # NOTE: Use |PlotTime| == '' if no solution time needs to be set.
#
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#
# ! ! ! E N D   O F   U S E R   I N P U T ! ! !
#
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

$!VarSet |Xrev|   =  0      # Set to 1 ONLY if X-axis is running from fuselage tail to nose (negative drag direction)
$!VarSet |Yrev|   =  0      # Set to 1 ONLY if Y-axis is running from wing tip to the symmetry plane
$!VarSet |Zrev|   =  0      # Set to 1 ONLY if Z-axis is running from fuselage crown to keel (negative lift direction)

#-------------------------------------

#===================================================================
# Create |OutputDirectoryPath|, if it does not exist (disabled due to security concerns)
#-------------------------------------
$!IF 0 == 1
 $!IF "|OutputDirectoryPath|" != ""
 #$!INTERFACE OKTOEXECUTESYSTEMCOMMAND = YES
  $!IF |OPSYS| == 1
    $!SYSTEM "mkdir -p |OutputDirectoryPath|"
  $!ELSEIF |OPSYS| == 2
    # NOTE: Untested syntax
    #$!SYSTEM "if not exist \"|OutputDirectoryPath|\" mkdir |OutputDirectoryPath|"
    $!SYSTEM "mkdir |OutputDirectoryPath|"
  $!ENDIF
 $!ENDIF
$!ENDIF
#===================================================================

$!SetStyleBase Factory
$!GlobalPaper
  PaperSizeInfo { Letter { Width = 8.5 Height = 11 LeftHardClipOffset = 0.125 RightHardClipOffset = 0.125 TopHardClipOffset = 0.125 BottomHardClipOffset = 0.125 } }
$!Page
  Name = 'Untitled'
  PaperAttributes
    {
    BackgroundColor = White
    IsTransparent = Yes
    OrientPortrait = No
    ShowGrid = Yes
    ShowRuler = No
    ShowPaper = No
    PaperSize = Letter
    RulerSpacing = OneInch
    PaperGridSpacing = HalfInch
    RegionInWorkArea { X1 = 1  Y1 = 0.25 X2 = 10 Y2 = 8.25 }
    }

$!FrameLayout
  ShowHeader = No
  HeaderColor = Red
  XYPos { X = 1 Y = 0.25 }
  Width = 9
  Height = 8
$!FrameName  = 'Frame 001'

$!PlotType = Cartesian3D

$!ThreeDAxis
  AspectRatioLimit = 25
  BoxAspectRatioLimit = 25
  XDetail { VarNum = |Xvar| ShowAxis = No RangeMin = 0.0 RangeMax = 1.0 GRSpacing = 10 AxisLine { Edge = 2 } }
  YDetail { VarNum = |Yvar| ShowAxis = No RangeMin = 0.0 RangeMax = 1.0 GRSpacing = 10 AxisLine { Edge = 3 } }
  ZDetail { VarNum = |Zvar| ShowAxis = No RangeMin = 0.0 RangeMax = 1.0 GRSpacing =  5 AxisLine { Edge = 2 } }
  AxisMode = XYZDependent
  XYDepXToYRatio = 1
  DepXToYRatio = 1
  DepXToZRatio = 1
  EdgeAutoReset = Yes
  FrameAxis { Size = 4 XYPos { X = 10 Y = 10 } }

$!GlobalRGB
  RedChannelVar = 3
  GreenChannelVar = 3
  BlueChannelVar = 3
  RangeMin = 0
  RangeMax = 1

$!Interface ZoneBoundingBoxMode = Off

#===================================================================
# Scaling/Translating Dataset (wind tunnel/metric->inches/etc.)
#===================================================================
# Reverse coordinate axes, if required by user input
#-------------------------------------
$!IF |Xrev| == 1
  $!AlterData
    Equation = 'V|Xvar| = -1 * V|Xvar|'
  $!AlterData
    Equation = 'V|CFXvar| = -1 * V|CFXvar|'
$!ENDIF
$!IF |Yrev| == 1
  $!AlterData
    Equation = 'V|Yvar| = -1 * V|Yvar|'
  $!AlterData
    Equation = 'V|CFYvar| = -1 * V|CFYvar|'
$!ENDIF
$!IF |Zrev| == 1
  $!AlterData
    Equation = 'V|Zvar| = -1 * V|Zvar|'
  $!AlterData
    Equation = 'V|CFZvar| = -1 * V|CFZvar|'
$!ENDIF

# Calculate scaling based on grid coordinate ranges
#-------------------------------------
$!IF '|BodyMaps||WingMaps|' == ''
   $!ACTIVEFIELDMAPS = [1-|NumZones|]
$!ELSE
   $!ACTIVEFIELDMAPS = [|BodyMaps|,|WingMaps|]
$!ENDIF
#$!PAUSE 'Xrange = (|MINX%.12f|,|MAXX%.12f|)\nYrange = (|MINY%.12f|,|MAXY%.12f|)\nZrange = (|MINZ%.12f|,|MAXZ%.12f|)'

$!VarSet |Scale|  = ((2562.883    - 92.500) / (|MAXX%.12f| - |MINX%.12f|))
$!VarSet |Xshift| = ( 92.50000    - |MINX%.12f|*|Scale| )
$!VarSet |Yshift| = (  0.00000    - |MINY%.12f|*|Scale| )
$!VarSet |Zshift| = (343.14873687 - |MAXZ%.12f|*|Scale| )
$!VarSet |tab| = '             '
#$!PAUSE 'NOTE: Transforming grid to airplane coordinates with fuselage beginning at (92.5,0.0,198.0) inches\n|tab|Scale = |Scale|\n|tab|Xshift = |Xshift|\n|tab|Yshift = |Yshift|\n|tab|Zshift = |Zshift|'

$!AlterData
  Equation = 'V|Xvar| = V|Xvar| * |Scale| + |Xshift|'
$!AlterData
  Equation = 'V|Yvar| = V|Yvar| * |Scale| + |Yshift|'
$!AlterData
  Equation = 'V|Zvar| = V|Zvar| * |Scale| + |Zshift|'
#$!PAUSE 'Xrange = (|MINX%.12f|,|MAXX%.12f|)\nYrange = (|MINY%.12f|,|MAXY%.12f|)\nZrange = (|MINZ%.12f|,|MAXZ%.12f|)'
#===================================================================

#===================================================================
# Auto detect zones that are Body vs. Wing (based on Body zones having max y-coordinate < 122.25)
#-------------------------------------
$!IF '|BodyMaps||WingMaps|' == ''
  $!LOOP |NumZones|
    $!ACTIVEFIELDMAPS = [|LOOP|]
    $!IF |MAXY%.12f| < 122.25
      $!IF '|BodyMaps|' == ''
        $!VarSet |BodyMaps| = '|LOOP|'
      $!ELSE
        $!VarSet |BodyMaps| = '|BodyMaps|,|LOOP|'
      $!ENDIF
    $!ELSE
      $!IF '|WingMaps|' == ''
        $!VarSet |WingMaps| = '|LOOP|'
      $!ELSE
        $!VarSet |WingMaps| = '|WingMaps|,|LOOP|'
      $!ENDIF
    $!ENDIF
  $!ENDLOOP
  $!PAUSE 'NOTE: Auto-detected\n      BodyMaps = |BodyMaps|\n      WingMaps = |WingMaps|\n'
$!ENDIF

#===================================================================
# Populate variables, if not defined
#-------------------------------------
#$!IF "|CPvar|" == ""
#  $!ALTERDATA EQUATION = "{CP}  = -999"
#  $!VARSET |CPvar|        = "|NUMVARS|"
#$!ENDIF
$!IF "|CFXvar|" == ""
  $!ALTERDATA EQUATION = "{CFX} = -999"
  $!VARSET |CFXvar|       = "|NUMVARS|"
$!ENDIF
$!IF "|CFYvar|" == ""
  $!ALTERDATA EQUATION = "{CFY} = -999"
  $!VARSET |CFYvar|       = "|NUMVARS|"
$!ENDIF
$!IF "|CFZvar|" == ""
  $!ALTERDATA EQUATION = "{CFZ} = -999"
  $!VARSET |CFZvar|       = "|NUMVARS|"
$!ENDIF
$!IF "|CFvar|" == ""
  $!ALTERDATA EQUATION = "{CF}  = -999"
  $!VARSET |CFvar|     = "|NUMVARS|"
  $!ALTERDATA EQUATION = "V|CFvar| = SQRT(V|CFXvar|**2 + V|CFYvar|**2 + V|CFZvar|**2)"
$!ENDIF
$!ALTERDATA EQUATION   = '{XoC} = -999'
$!VARSET |XOCvar|      = |NUMVARS|
$!ALTERDATA EQUATION   = '{YoC} = -999'
$!VARSET |YOCvar|      = |NUMVARS|
$!ALTERDATA EQUATION   = '{ZoC} = -999'
$!VARSET |ZOCvar|      = |NUMVARS|

#===================================================================
# Name variables consistently
#-------------------------------------
$!RenameDataSetVar
  Var = |Xvar|
  Name = 'X'
$!RenameDataSetVar
  Var = |Yvar|
  Name = 'Y'
$!RenameDataSetVar
  Var = |Zvar|
  Name = 'Z'
$!RenameDataSetVar
  Var = |CPvar|
  Name = 'CP'
$!RenameDataSetVar
  Var = |CFvar|
  Name = 'CF'
$!RenameDataSetVar
  Var = |CFXvar|
  Name = 'CFx'
$!RenameDataSetVar
  Var = |CFYvar|
  Name = 'CFy'
$!RenameDataSetVar
  Var = |CFZvar|
  Name = 'CFz'
#-------------------------------------

#===================================================================
# Set rotation center (no effect on view, but nice to have rotation center near middle of view)
#-------------------------------------
$!VarSet |RotX|     = 1325.89      # Moment Reference Center
$!VarSet |RotY|     = (2313.50/4)  # 0.25*Span
$!VarSet |RotZ|     = 177.96       # Moment Reference Center
#-------------------------------------

#===================================================================
# Create Macro Function: SectionalCutter
#-------------------------------------
$!MACROFUNCTION
  NAME = "SectionalCutter"

  $!VarSet |FirstSliceZone| = (|NumZones|+1)

  $!IF "|7|" == "CreateSliceZoneFromPlane"
    $!GLOBALTHREED SLICE{ORIGIN{X = |1| Y = |2| Z = |3|}}
    $!GLOBALTHREED SLICE{NORMAL{X = |4| Y = |5| Z = |6|}}
    $!CREATESLICEZONEFROMPLANE
      SLICESOURCE = SURFACEZONES
      FORCEEXTRACTIONTOSINGLEZONE = NO
      COPYCELLCENTEREDVALUES = NO
  $!ELSEIF "|7|" == "ExtractSlices"
    $!SliceLayers Show = Yes
    $!SliceAttributes 1 SliceSource = SurfaceZones
    $!SliceAttributes 1 SliceSurface = YPlanes
    $!SliceAttributes 1 PrimaryPosition{Y = |2|}
    $!ExtractSlices
      Group = 1
      ExtractMode = OneZonePerConnectedRegion
      Resulting1DZonetype = IOrderedIfPossible
      ExtractionStrandIDAssignment = DoNotAssignStrandIDs # We want each zone to be put into its own FieldMap
  $!ENDIF

  $!VarSet |NumNewZones| = (|NumZones| - |FirstSliceZone| + 1)
  $!IF |NumNewZones| >= 1
    $!EXTENDEDCOMMAND COMMANDPROCESSORID='extendmcr' COMMAND='QUERY.ACTIVEZONES SURFZONES'

    # Normalize the slice values.  Note that MINX, MAXX, MINZ, MAXZ return the min/max values
    # for the set of active zones
    $!VarSet |NewZoneSet| = "|FirstSliceZone| - |NumZones|"

    $!ActiveFieldMaps = [|NewZoneSet|]
    $!AlterData  [|NewZoneSet|] Equation = 'V|XoCvar| = (V|Xvar| - |MINX%.12f|)/(|MAXX%.12f| - |MINX%.12f|)'
    $!AlterData  [|NewZoneSet|] Equation = 'V|YoCvar| = 0.0'
    $!AlterData  [|NewZoneSet|] Equation = 'V|ZoCvar| = (V|Zvar| - |MINZ%.12f|)/(|MAXX%.12f| - |MINX%.12f|)'
    #===================================================================
    # Rename Zones With Sectional Cuts
    #-------------------------------------
    $!Loop |NumNewZones|
      $!VarSet |Zone| = (|FirstSliceZone| + |Loop| - 1)
      $!RENAMEDATASETZONE
        ZONE = |Zone|
        NAME = '|SolutionLabel| - WING SECTION |SectionNumber|'
    $!EndLoop

    $!ActiveFieldMaps = [|SURFZONES|]

  $!ELSE
    $!Pause "No section cut extracted!!!"
  $!ENDIF
$!ENDMACROFUNCTION
#===================================================================
# Create Macro Function: SectionalCutter
#-------------------------------------
$!MACROFUNCTION
  NAME = "SectionalCutterSingleZone"

 $!IF 1 == 1
  # Preferred method - Requires Tecplot version 2019 V1 or newer
  $!EXTRACTSLICETOZONES
    ORIGIN {X = |1| Y = |2| Z = |3|}
    NORMAL {X = |4| Y = |5| Z = |6|}
    AUTOSTRANDTRANSIENTDATA = YES
    COPYCELLCENTEREDVALUES = NO
    EXTRACTMODE = SINGLEZONE
    RESULTING1DZONETYPE = IORDEREDIFPOSSIBLE
    SLICESOURCE = SURFACEZONES
    SLICESURFACE = YPLANES
    TRANSIENTOPERATIONMODE = SINGLESOLUTIONTIME
 $!ELSE
  # Tecplot version older than 2019 R1
  $!GLOBALTHREED SLICE{ORIGIN{X = |1| Y = |2| Z = |3|}}
  $!GLOBALTHREED SLICE{NORMAL{X = |4| Y = |5| Z = |6|}}
  $!CREATESLICEZONEFROMPLANE
    SLICESOURCE = SURFACEZONES
    FORCEEXTRACTIONTOSINGLEZONE = YES
    COPYCELLCENTEREDVALUES = NO
 $!ENDIF

  $!RENAMEDATASETZONE
    ZONE = |NUMZONES|
    NAME = '|SolutionLabel| - WING SECTION |SectionNumber|'

  $!EXTENDEDCOMMAND COMMANDPROCESSORID='extendmcr' COMMAND='QUERY.ACTIVEZONES SURFZONES'
  $!ActiveFieldMaps = [|NUMZONES|]
  $!AlterData  [|NUMZONES|] Equation = 'V|XoCvar| = (V|Xvar| - |MINX%.12f|)/(|MAXX%.12f| - |MINX%.12f|)'
  $!AlterData  [|NUMZONES|] Equation = 'V|YoCvar| = 0.0'
  $!AlterData  [|NUMZONES|] Equation = 'V|ZoCvar| = (V|Zvar| - |MINZ%.12f|)/(|MAXX%.12f| - |MINX%.12f|)'
  $!ActiveFieldMaps = [|SURFZONES|]

$!ENDMACROFUNCTION
#===================================================================

$!IF "|PlotTime|" != ""
  $!GlobalTime
    SolutionTime = |PlotTime|
$!ENDIF

$!FieldMap  [|BodyMaps|,|WingMaps|]
  Mesh { Show = No Color = Black LineThickness = 0.1 }
  Contour
    {
    ContourType = BothLinesAndFlood
    LineContourGroup = 1
    FloodColoring = Group1
    Color = Custom2
    UseLightingEffect = Yes
    }
  Vector { Color = Black }
  Scatter { Color = Black }
  Shade { Color = Custom2 }
  EdgeLayer { Show = No Color = Black LineThickness = 0.1 }
  Points { PointsToPlot = SurfaceNodes }
  Surfaces { SurfacesToPlot = KPlanes IRange { Max = 1 } }
  VolumeMode { VolumeObjectsToPlot { ShowIsosurfaces = No ShowSlices = No ShowStreamtraces = No } }
  Effects { LightingEffect = Gouraud }

$!FieldLayers
  ShowMesh = Yes
  ShowContour = No
  ShowShade = Yes
  ShowEdge = No
$!StreamtraceLayers
  Show = No

$!View Fit

$!FrameControl ActivateByNumber
  Frame = 1

$!GlobalThreeD
  AxisScaleFact { X = 1 Y = 1 Z = 1 }
  RotateOrigin { X = |RotX| Y = |RotY| Z = |RotZ| }
  LightSource
    {
    XYZDirection{ X = 0.1 Y = -0.1 Z = 0.95 }
    Intensity = 75
    BackgroundLight = 25
    IncludeSpecular = Yes
    SpecularIntensity = 40
    SpecularShininess = 60
    }
  LineLiftFraction = 0.2
  SymbolLiftFraction = 0.6
  VectorLiftFraction = 0.7
  NearPlaneFraction = 0.1

$!DRAWGRAPHICS TRUE

$!FIELDLAYERS SHOWMESH = NO
$!FIELDLAYERS SHOWCONTOUR = NO
$!FIELDLAYERS SHOWSHADE = YES
$!FIELDLAYERS SHOWVECTOR = NO
$!FIELDLAYERS SHOWEDGE = NO
$!FIELDLAYERS SHOWSCATTER = NO
$!FIELDLAYERS USELIGHTINGEFFECT = NO
$!FIELDLAYERS USETRANSLUCENCY = NO
$!SLICELAYERS SHOW = NO
$!STREAMTRACELAYERS SHOW = NO
$!STREAMATTRIBUTES ADDARROWS = NO

#===================================================================
# Activate ONLY wing surfaces
#-------------------------------------
$!ActiveFieldMaps = [|WingMaps|]

$!View Fit

$!RedrawAll


#===================================================================
# Determine the correct slice extraction method based on the zone type.  Tecplot 360
# produces difference extracted slice normals with different extraction methods. The direction
# of the cell normals on the extracted section cut are critical to getting a correct integrated
# result.  Tecplot developers are looking into this issue.
#-------------------------------------
$!VarSet |ExtractMethod| = "ExtractSlices"
$!ActiveFieldMaps = [|WingMaps|]
$!Loop |NumZones|
  $!ExtendedCommand
    CommandProcessorID = "extendmcr"
    Command = "Query.IsZoneActive |LOOP| IsActive"
  $!If "|IsActive|" == "Yes"
    $!GetZoneType |ZoneType|
      Zone = |LOOP|
    $!If "|ZoneType|" == "Ordered"
      $!VarSet |ExtractMethod| = "CreateSliceZoneFromPlane"
    $!EndIf
  $!EndIf
$!EndLoop


#===================================================================
# Create Sectional Cuts for Pressure Cuts (Single Zone Output)
#-------------------------------------
# Establish Zone Number For Cut Data
$!VARSET |NumZonesCuts| = (|NUMZONES| + 1)

# WING SECTION  1: ETA = 0.1050, CHORD=466.466
$!VarSet |SectionNumber| = 1
$!RUNMACROFUNCTION "SectionalCutterSingleZone" ( 993.728, 121.459, 176.053,0.000,1.000,0.000, |ExtractMethod|)

# WING SECTION  2: ETA = 0.1150, CHORD=459.571
$!VarSet |SectionNumber| += 1
$!RUNMACROFUNCTION "SectionalCutterSingleZone" (1002.168, 133.026, 176.306,0.000,1.000,0.000, |ExtractMethod|)

# WING SECTION  3: ETA = 0.1250, CHORD=452.687
$!VarSet |SectionNumber| += 1
$!RUNMACROFUNCTION "SectionalCutterSingleZone" (1010.656, 144.594, 176.539,0.000,1.000,0.000, |ExtractMethod|)

# WING SECTION  4: ETA = 0.1306, CHORD=448.836
$!VarSet |SectionNumber| += 1
$!RUNMACROFUNCTION "SectionalCutterSingleZone" (1015.435, 151.074, 176.659,0.000,1.000,0.000, |ExtractMethod|)

# WING SECTION  5: ETA = 0.2009, CHORD=400.743
$!VarSet |SectionNumber| += 1
$!RUNMACROFUNCTION "SectionalCutterSingleZone" (1076.873, 232.444, 177.509,0.000,1.000,0.000, |ExtractMethod|)

# WING SECTION  6: ETA = 0.2828, CHORD=344.991
$!VarSet |SectionNumber| += 1
$!RUNMACROFUNCTION "SectionalCutterSingleZone" (1148.974, 327.074, 178.606,0.000,1.000,0.000, |ExtractMethod|)

# WING SECTION  7: ETA = 0.3430, CHORD=304.101
$!VarSet |SectionNumber| += 1
$!RUNMACROFUNCTION "SectionalCutterSingleZone" (1202.038, 396.765, 180.222,0.000,1.000,0.000, |ExtractMethod|)

# WING SECTION  8: ETA = 0.3700, CHORD=285.806
$!VarSet |SectionNumber| += 1
$!RUNMACROFUNCTION "SectionalCutterSingleZone" (1225.822, 427.998, 181.162,0.000,1.000,0.000, |ExtractMethod|)

# WING SECTION  9: ETA = 0.3971, CHORD=278.111
$!VarSet |SectionNumber| += 1
$!RUNMACROFUNCTION "SectionalCutterSingleZone" (1249.711, 459.370, 182.250,0.000,1.000,0.000, |ExtractMethod|)

# WING SECTION 10: ETA = 0.5024, CHORD=248.312
$!VarSet |SectionNumber| += 1
$!RUNMACROFUNCTION "SectionalCutterSingleZone" (1342.440, 581.148, 188.658,0.000,1.000,0.000, |ExtractMethod|)

# WING SECTION 11: ETA = 0.6028, CHORD=219.904
$!VarSet |SectionNumber| += 1
$!RUNMACROFUNCTION "SectionalCutterSingleZone" (1430.914, 697.333, 198.060,0.000,1.000,0.000, |ExtractMethod|)

# WING SECTION 12: ETA = 0.7268, CHORD=184.844
$!VarSet |SectionNumber| += 1
$!RUNMACROFUNCTION "SectionalCutterSingleZone" (1540.091, 840.704, 213.659,0.000,1.000,0.000, |ExtractMethod|)

# WING SECTION 13: ETA = 0.8456, CHORD=151.235
$!VarSet |SectionNumber| += 1
$!RUNMACROFUNCTION "SectionalCutterSingleZone" (1644.738, 978.148, 233.317,0.000,1.000,0.000, |ExtractMethod|)

# WING SECTION 14: ETA = 0.9500, CHORD=121.735
$!VarSet |SectionNumber| += 1
$!RUNMACROFUNCTION "SectionalCutterSingleZone" (1736.708,1098.926, 253.727,0.000,1.000,0.000, |ExtractMethod|)

# WING SECTION 15: ETA = 0.9700, CHORD=116.095
$!VarSet |SectionNumber| += 1
$!RUNMACROFUNCTION "SectionalCutterSingleZone" (1754.313,1122.048, 257.777,0.000,1.000,0.000, |ExtractMethod|)

# WING SECTION 16: ETA = 0.9900, CHORD=110.452
$!VarSet |SectionNumber| += 1
$!RUNMACROFUNCTION "SectionalCutterSingleZone" (1771.927,1145.183, 261.823,0.000,1.000,0.000, |ExtractMethod|)


#===================================================================
# Visualize Sectional Cuts
#-------------------------------------
$!VarSet |PressureZones| = "|NumZonesCuts| - |NUMZONES|"
$!FIELDMAP [|PressureZones|] MESH{Show = Yes Color = Green LineThickness = 0.80 }
$!FIELDLAYERS SHOWMESH = YES
$!REDRAWALL
#===================================================================


#===================================================================
# Rename/Reorder Variables to output is in desired order
#-------------------------------------
$!RENAMEDATASETVAR VAR = |Xvar|   NAME = "Xo"
$!RENAMEDATASETVAR VAR = |Yvar|   NAME = "Yo"
$!RENAMEDATASETVAR VAR = |Zvar|   NAME = "Zo"
$!RENAMEDATASETVAR VAR = |XoCvar| NAME = "XoCo"
#$!RENAMEDATASETVAR VAR = |YoCvar| NAME = "YoCo"
#$!RENAMEDATASETVAR VAR = |ZoCvar| NAME = "ZoCo"
$!RENAMEDATASETVAR VAR = |CPvar|  NAME = "CPo"
$!RENAMEDATASETVAR VAR = |CFvar|  NAME = "CFo"
$!RENAMEDATASETVAR VAR = |CFXvar| NAME = "CFXo"
$!RENAMEDATASETVAR VAR = |CFYvar| NAME = "CFYo"
$!RENAMEDATASETVAR VAR = |CFZvar| NAME = "CFZo"
$!ALTERDATA EQUATION   = "{X} = {Xo}"
$!VARSET |NUMVARS0|    = |NUMVARS|
$!ALTERDATA EQUATION   = "{Y}   = {Yo}"
$!ALTERDATA EQUATION   = "{Z}   = {Zo}"
$!ALTERDATA EQUATION   = '{XoC} = {XoCo}'
$!ALTERDATA EQUATION   = "{CP}  = {CPo}"
$!ALTERDATA EQUATION   = "{CF}  = {CFo}"
$!ALTERDATA EQUATION   = "{CFX} = {CFXo}"
$!ALTERDATA EQUATION   = "{CFY} = {CFYo}"
$!ALTERDATA EQUATION   = "{CFZ} = {CFZo}"
$!VARSET |NUMVARS1|    = |NUMVARS|

#===================================================================
# Write Sectional Cuts To |OutputDirectoryPath||FilePrependLabel|.plt
#-------------------------------------

$!SETDATASETTITLE "SectionalCuts"
$!WRITEDATASET  "|OutputDirectoryPath||FilePrependLabel|.plt"
  ASSOCIATELAYOUTWITHDATAFILE = NO
  BINARY                      = NO
  INCLUDEAUTOGENFACENEIGHBORS = NO
  INCLUDECUSTOMLABELS         = NO
  INCLUDEDATA                 = YES
  INCLUDEDATASHARELINKAGE     = NO
  INCLUDEGEOM                 = NO
  INCLUDETEXT                 = NO
  PRECISION                   = 8
  TECPLOTVERSIONTOWRITE       = TECPLOTCURRENT
  USEPOINTFORMAT              = YES
  VARPOSITIONLIST             = [|NUMVARS0| - |NUMVARS|]
  ZONELIST                    = [|PressureZones|]
##VARPOSITIONLIST             = [|Xvar|,|Yvar|,|Zvar|,|XoCvar|,|Cpvar|,|CFvar|,|CFXvar|,|CFYvar|,|CFZvar|]
#===================================================================

#===================================================================
# Delete/Rename Temporary Variables used for output only
#-------------------------------------
$!DeleteVars [|NUMVARS0| - |NUMVARS|]
$!RENAMEDATASETVAR VAR = |Xvar|   NAME = "X"
$!RENAMEDATASETVAR VAR = |Yvar|   NAME = "Y"
$!RENAMEDATASETVAR VAR = |Zvar|   NAME = "Z"
$!RENAMEDATASETVAR VAR = |XoCvar| NAME = "XoC"
$!RENAMEDATASETVAR VAR = |CPvar|  NAME = "CP"
$!RENAMEDATASETVAR VAR = |CFvar|  NAME = "CF"
$!RENAMEDATASETVAR VAR = |CFXvar| NAME = "CFX"
$!RENAMEDATASETVAR VAR = |CFYvar| NAME = "CFY"
$!RENAMEDATASETVAR VAR = |CFZvar| NAME = "CFZ"


#===================================================================
# Create Zone to store Sectional Lift/Pitching Moment for each sectional cut
#-------------------------------------
$!CreateRectangularZone
  IMax = 16 JMax = 1  KMax = 1
  X1   = 0  Y1   = 0  Z1   = 0
  X2   = 0  Y2   = 0  Z2   = 0
  XVar = 1  YVar = 2  ZVar = 3
$!VARSET |INTZONE| = |NUMZONES|
$!RenameDataSetZone Zone = |INTZONE| Name = 'Sectional Integration'

#===================================================================
# Variables for Sectional Force/Moments
#-------------------------------------
$!ALTERDATA EQUATION   = '{CpM} = -999'
$!VARSET |CPMvar|      = |NUMVARS|
$!ALTERDATA EQUATION   = '{CUT} = -999'
$!VARSET |CUTvar|      = |NUMVARS|
$!ALTERDATA EQUATION   = '{ETA} = -999'
$!VARSET |ETAvar|      = |NUMVARS|
$!ALTERDATA EQUATION   = '{ALPHA} = |ALPHA%.4f|'
$!VARSET |ALPHAvar|    = |NUMVARS|
$!ALTERDATA EQUATION   = '{CL} = |CL%.4f|'
$!VARSET |CLvar|       = |NUMVARS|
$!ALTERDATA EQUATION   = '{CLS} = -999'
$!VARSET |CLSvar|      = |NUMVARS|
$!ALTERDATA EQUATION   = '{CMS} = -999'
$!VARSET |CMSvar|      = |NUMVARS|


#===================================================================
# The SectionCutter is allowed to create multiple zones per section cut. We need
# to record which zones are associated with each section cut.  To do this we create a zone
# to store zone number range for each extracted section cut.
# XVar is the first zone in the set
# YVar is the last  zone in the set
#-------------------------------------
$!CreateRectangularZone
  IMax = 16  JMax = 1 KMax = 1
  X1   = 0  Y1   = 0  Z1   = 0
  X2   = 0  Y2   = 0  Z2   = 0
  XVar = 1  YVar = 2  ZVar = 3
$!VarSet |TempZone| = |NumZones|
$!RenameDataSetZone
  Zone = |TempZone|
  Name = "Section Zone Numbers"
$!ActiveFieldMaps -= [|TempZone|]


#===================================================================
# Create Sectional Cuts for Integration
#-------------------------------------
# Establish Zone Number For Integration Data
$!VARSET |NumZonesInt| = (|NUMZONES| + 1)

# WING SECTION  1: ETA = 0.1050, CHORD=466.466
$!VarSet |SectionNumber| = 1
$!SetFieldValue ZONE = |TempZone| VAR = 1 INDEX = |SectionNumber| FIELDVALUE = (|NumZones|+1)
$!RUNMACROFUNCTION "SectionalCutter" ( 993.728, 121.459, 176.053,0.000,1.000,0.000, |ExtractMethod|)
$!SetFieldValue ZONE = |TempZone| VAR = 2 INDEX = |SectionNumber| FIELDVALUE = |NumZones|

# WING SECTION  2: ETA = 0.1150, CHORD=459.571
$!VarSet |SectionNumber| += 1
$!SetFieldValue ZONE = |TempZone| VAR = 1 INDEX = |SectionNumber| FIELDVALUE = (|NumZones|+1)
$!RUNMACROFUNCTION "SectionalCutter" (1002.168, 133.026, 176.306,0.000,1.000,0.000, |ExtractMethod|)
$!SetFieldValue ZONE = |TempZone| VAR = 2 INDEX = |SectionNumber| FIELDVALUE = |NumZones|

# WING SECTION  3: ETA = 0.1250, CHORD=452.687
$!VarSet |SectionNumber| += 1
$!SetFieldValue ZONE = |TempZone| VAR = 1 INDEX = |SectionNumber| FIELDVALUE = (|NumZones|+1)
$!RUNMACROFUNCTION "SectionalCutter" (1010.656, 144.594, 176.539,0.000,1.000,0.000, |ExtractMethod|)
$!SetFieldValue ZONE = |TempZone| VAR = 2 INDEX = |SectionNumber| FIELDVALUE = |NumZones|

# WING SECTION  4: ETA = 0.1306, CHORD=448.836
$!VarSet |SectionNumber| += 1
$!SetFieldValue ZONE = |TempZone| VAR = 1 INDEX = |SectionNumber| FIELDVALUE = (|NumZones|+1)
$!RUNMACROFUNCTION "SectionalCutter" (1015.435, 151.074, 176.659,0.000,1.000,0.000, |ExtractMethod|)
$!SetFieldValue ZONE = |TempZone| VAR = 2 INDEX = |SectionNumber| FIELDVALUE = |NumZones|

# WING SECTION  5: ETA = 0.2009, CHORD=400.743
$!VarSet |SectionNumber| += 1
$!SetFieldValue ZONE = |TempZone| VAR = 1 INDEX = |SectionNumber| FIELDVALUE = (|NumZones|+1)
$!RUNMACROFUNCTION "SectionalCutter" (1076.873, 232.444, 177.509,0.000,1.000,0.000, |ExtractMethod|)
$!SetFieldValue ZONE = |TempZone| VAR = 2 INDEX = |SectionNumber| FIELDVALUE = |NumZones|

# WING SECTION  6: ETA = 0.2828, CHORD=344.991
$!VarSet |SectionNumber| += 1
$!SetFieldValue ZONE = |TempZone| VAR = 1 INDEX = |SectionNumber| FIELDVALUE = (|NumZones|+1)
$!RUNMACROFUNCTION "SectionalCutter" (1148.974, 327.074, 178.606,0.000,1.000,0.000, |ExtractMethod|)
$!SetFieldValue ZONE = |TempZone| VAR = 2 INDEX = |SectionNumber| FIELDVALUE = |NumZones|

# WING SECTION  7: ETA = 0.3430, CHORD=304.101
$!VarSet |SectionNumber| += 1
$!SetFieldValue ZONE = |TempZone| VAR = 1 INDEX = |SectionNumber| FIELDVALUE = (|NumZones|+1)
$!RUNMACROFUNCTION "SectionalCutter" (1202.038, 396.765, 180.222,0.000,1.000,0.000, |ExtractMethod|)
$!SetFieldValue ZONE = |TempZone| VAR = 2 INDEX = |SectionNumber| FIELDVALUE = |NumZones|

# WING SECTION  8: ETA = 0.3700, CHORD=285.806
$!VarSet |SectionNumber| += 1
$!SetFieldValue ZONE = |TempZone| VAR = 1 INDEX = |SectionNumber| FIELDVALUE = (|NumZones|+1)
$!RUNMACROFUNCTION "SectionalCutter" (1225.822, 427.998, 181.162,0.000,1.000,0.000, |ExtractMethod|)
$!SetFieldValue ZONE = |TempZone| VAR = 2 INDEX = |SectionNumber| FIELDVALUE = |NumZones|

# WING SECTION  9: ETA = 0.3971, CHORD=278.111
$!VarSet |SectionNumber| += 1
$!SetFieldValue ZONE = |TempZone| VAR = 1 INDEX = |SectionNumber| FIELDVALUE = (|NumZones|+1)
$!RUNMACROFUNCTION "SectionalCutter" (1249.711, 459.370, 182.250,0.000,1.000,0.000, |ExtractMethod|)
$!SetFieldValue ZONE = |TempZone| VAR = 2 INDEX = |SectionNumber| FIELDVALUE = |NumZones|

# WING SECTION 10: ETA = 0.5024, CHORD=248.312
$!VarSet |SectionNumber| += 1
$!SetFieldValue ZONE = |TempZone| VAR = 1 INDEX = |SectionNumber| FIELDVALUE = (|NumZones|+1)
$!RUNMACROFUNCTION "SectionalCutter" (1342.440, 581.148, 188.658,0.000,1.000,0.000, |ExtractMethod|)
$!SetFieldValue ZONE = |TempZone| VAR = 2 INDEX = |SectionNumber| FIELDVALUE = |NumZones|

# WING SECTION 11: ETA = 0.6028, CHORD=219.904
$!VarSet |SectionNumber| += 1
$!SetFieldValue ZONE = |TempZone| VAR = 1 INDEX = |SectionNumber| FIELDVALUE = (|NumZones|+1)
$!RUNMACROFUNCTION "SectionalCutter" (1430.914, 697.333, 198.060,0.000,1.000,0.000, |ExtractMethod|)
$!SetFieldValue ZONE = |TempZone| VAR = 2 INDEX = |SectionNumber| FIELDVALUE = |NumZones|

# WING SECTION 12: ETA = 0.7268, CHORD=184.844
$!VarSet |SectionNumber| += 1
$!SetFieldValue ZONE = |TempZone| VAR = 1 INDEX = |SectionNumber| FIELDVALUE = (|NumZones|+1)
$!RUNMACROFUNCTION "SectionalCutter" (1540.091, 840.704, 213.659,0.000,1.000,0.000, |ExtractMethod|)
$!SetFieldValue ZONE = |TempZone| VAR = 2 INDEX = |SectionNumber| FIELDVALUE = |NumZones|

# WING SECTION 13: ETA = 0.8456, CHORD=151.235
$!VarSet |SectionNumber| += 1
$!SetFieldValue ZONE = |TempZone| VAR = 1 INDEX = |SectionNumber| FIELDVALUE = (|NumZones|+1)
$!RUNMACROFUNCTION "SectionalCutter" (1644.738, 978.148, 233.317,0.000,1.000,0.000, |ExtractMethod|)
$!SetFieldValue ZONE = |TempZone| VAR = 2 INDEX = |SectionNumber| FIELDVALUE = |NumZones|

# WING SECTION 14: ETA = 0.9500, CHORD=121.735
$!VarSet |SectionNumber| += 1
$!SetFieldValue ZONE = |TempZone| VAR = 1 INDEX = |SectionNumber| FIELDVALUE = (|NumZones|+1)
$!RUNMACROFUNCTION "SectionalCutter" (1736.708,1098.926, 253.727,0.000,1.000,0.000, |ExtractMethod|)
$!SetFieldValue ZONE = |TempZone| VAR = 2 INDEX = |SectionNumber| FIELDVALUE = |NumZones|

# WING SECTION 15: ETA = 0.9700, CHORD=116.095
$!VarSet |SectionNumber| += 1
$!SetFieldValue ZONE = |TempZone| VAR = 1 INDEX = |SectionNumber| FIELDVALUE = (|NumZones|+1)
$!RUNMACROFUNCTION "SectionalCutter" (1754.313,1122.048, 257.777,0.000,1.000,0.000, |ExtractMethod|)
$!SetFieldValue ZONE = |TempZone| VAR = 2 INDEX = |SectionNumber| FIELDVALUE = |NumZones|

# WING SECTION 16: ETA = 0.9900, CHORD=110.452
$!VarSet |SectionNumber| += 1
$!SetFieldValue ZONE = |TempZone| VAR = 1 INDEX = |SectionNumber| FIELDVALUE = (|NumZones|+1)
$!RUNMACROFUNCTION "SectionalCutter" (1771.927,1145.183, 261.823,0.000,1.000,0.000, |ExtractMethod|)
$!SetFieldValue ZONE = |TempZone| VAR = 2 INDEX = |SectionNumber| FIELDVALUE = |NumZones|
#===================================================================


#===================================================================
# Calculate Sectional Lift/Pitching Moment for Sectional Cuts
#-------------------------------------
$!ThreeDAxis XDetail{VarNum = |XoCvar|}
$!ThreeDAxis YDetail{VarNum = |YoCvar|}
$!ThreeDAxis ZDetail{VarNum = |ZoCvar|}

$!AlterData [|NumZonesInt| - |NUMZONES|] Equation = '{CpM} = {Cp} * (0.25 - {XoC})'
#$!AlterData [|NumZonesInt| - |NUMZONES|] Equation = 'V|CPMvar| = V|CPvar| * (0.25 - V|XoCvar|)'

$!VARSET |Time| = ''
$!IF "|PlotTime|" != ""
  $!VARSET |Time| = 'TimeMin=|PlotTime| TimeMax=|PlotTime|'
$!ENDIF
#===================================================================

#-------------------------------------------------------------------
# Use XYLINE & reset V1 to |XoCvar|, so integration runs over X/C
$!PlotType = XYLine
$!ALTERDATA EQUATION   = '{V1tmp} = V1'
$!VARSET |V1tmp|       = |NUMVARS|
$!ALTERDATA EQUATION   = 'V1 = V|XoCvar|'
#-------------------------------------------------------------------

$!LOOP 16
  # Extract the set of zones for the section from the TempZone we created earler.
  $!GetFieldValue |FirstZone|
    Zone = |TempZone|
    Var = |V1tmp| # TODO - The equations above screw up the X-variable for this zone and results end up in V1tmp.
    Index = |LOOP|
  $!GetFieldValue |LastZone|
    Zone = |TempZone|
    Var = 2
    Index = |LOOP|
  $!VarSet |SectionZones| = "|FirstZone| - |LastZone|"

  # All section zones will have the same Y-value, so we're grabbing from just the first zone in the set
  $!GetFieldValue |CurrY| Zone = |FirstZone| Var = 2 Index = 1
  $!VARSET |ETA| = (|CurrY| / 1156.75)

  $!ExtendedCommand
    CommandProcessorID = 'CFDAnalyzer4'
    Command = 'Integrate [|SectionZones|] VariableOption=\'Scalar\' XOrigin=0 YOrigin=0 ZOrigin=0 ScalarVar=|CPvar| Absolute=\'F\' ExcludeBlanked=\'F\' XVariable=|XoCvar| YVariable=|YoCvar| ZVariable=|ZoCvar| IntegrateOver=\'Cells\' IntegrateBy=\'Zones\' IRange={MIN =1 MAX = 0 SKIP = 1} JRange={MIN =1 MAX = 0 SKIP = 1} KRange={MIN =1 MAX = 0 SKIP = 1} |Time|' #PlotResults=\'T\' PlotAs=\'SectionalLift\''

  $!VARSET |revS| = 1
  $!IF |AUXFRAME:CFDA.INTEGRATION_TOTAL| < 0
    $!VARSET |revS| = -1
  $!ENDIF
  $!VARSET |CLS| = (|revS| * |AUXFRAME:CFDA.INTEGRATION_TOTAL|)

  $!ExtendedCommand
    CommandProcessorID = 'CFDAnalyzer4'
    Command = 'Integrate [|SectionZones|] VariableOption=\'Scalar\' XOrigin=0 YOrigin=0 ZOrigin=0 ScalarVar=|CPMvar| Absolute=\'F\' ExcludeBlanked=\'F\' XVariable=|XoCvar| YVariable=|YoCvar| ZVariable=|ZoCvar| IntegrateOver=\'Cells\' IntegrateBy=\'Zones\' IRange={MIN =1 MAX = 0 SKIP = 1} JRange={MIN =1 MAX = 0 SKIP = 1} KRange={MIN =1 MAX = 0 SKIP = 1} |Time|' #PlotResults=\'T\' PlotAs=\'SectionalPitchingMoment\''
  $!VARSET |CMS| = (|revS| * |AUXFRAME:CFDA.INTEGRATION_TOTAL|)

 #$!SetFieldValue AUTOBRANCH = YES ZONE = |INTZONE| VAR = 2        INDEX = |LOOP| FIELDVALUE = |LOOP|
  $!SetFieldValue AUTOBRANCH = YES ZONE = |INTZONE| VAR = |Yvar|   INDEX = |LOOP| FIELDVALUE = |CurrY%.3f|
  $!SetFieldValue AUTOBRANCH = YES ZONE = |INTZONE| VAR = |CUTvar| INDEX = |LOOP| FIELDVALUE = |LOOP|
  $!SetFieldValue AUTOBRANCH = YES ZONE = |INTZONE| VAR = |ETAvar| INDEX = |LOOP| FIELDVALUE = |ETA%.4f|
  $!SetFieldValue AUTOBRANCH = YES ZONE = |INTZONE| VAR = |CLSvar| INDEX = |LOOP| FIELDVALUE = |CLS|
  $!SetFieldValue AUTOBRANCH = YES ZONE = |INTZONE| VAR = |CMSvar| INDEX = |LOOP| FIELDVALUE = |CMS|
$!ENDLOOP

$!ActiveFieldMaps -= [|INTZONE|]

#-------------------------------------------------------------------
# Reset V1 back to original values
$!ALTERDATA EQUATION   = 'V1 = V|V1tmp|'
$!DeleteVars [|V1tmp|]
$!PlotType = Cartesian3D
#-------------------------------------------------------------------

#===================================================================
# Delete Zones With Integration Cuts
#-------------------------------------
$!DELETEZONES [|TempZone|, |NumZonesInt| - |NUMZONES|]
#===================================================================

#===================================================================
# Write Sectional Integration To |OutputDirectoryPath||FilePrependLabel|_SectionalIntegration.plt
#-------------------------------------
$!SETDATASETTITLE "SectionalIntegration"
$!WRITEDATASET  "|OutputDirectoryPath||FilePrependLabel|_SectionalIntegration.plt"
  ASSOCIATELAYOUTWITHDATAFILE = NO
  BINARY                      = NO
  INCLUDEAUTOGENFACENEIGHBORS = NO
  INCLUDECUSTOMLABELS         = NO
  INCLUDEDATA                 = YES
  INCLUDEDATASHARELINKAGE     = NO
  INCLUDEGEOM                 = NO
  INCLUDETEXT                 = NO
  PRECISION                   = 8
  TECPLOTVERSIONTOWRITE       = TECPLOTCURRENT
  USEPOINTFORMAT              = YES
  VARPOSITIONLIST             = [|Yvar|, |ETAvar|, |ALPHAvar|, |CLvar|, |CLSvar|, |CMSvar|]
  ZONELIST                    = [|INTZONE|]
#===================================================================

#===================================================================
# Draw Sectional Lift/Pitching Moment
#-------------------------------------
$!ThreeDAxis XDetail{VarNum = |Xvar|}
$!ThreeDAxis YDetail{VarNum = |Yvar|}
$!ThreeDAxis ZDetail{VarNum = |Zvar|}

$!CreateNewFrame XYPos { X = 1.25 Y = 5.00 } Width = 3.0 Height = 3.0
$!FrameControl ActivateByNumber
  Frame = 2
$!FrameLayout ShowHeader = No
$!PlotType = XYLine
$!DeleteLineMaps
$!CreateLineMap
$!LineMap [1]  Name = 'Sectional Lift'
$!LineMap [1]  Assign{Zone = |INTZONE| XAxisVar = |ETAvar| YAxisVar = |CLSvar|}
$!LineMap [2]  Name = 'Sectional Moment'
$!LineMap [2]  Assign{Zone = |INTZONE| XAxisVar = |ETAvar| YAxisVar = |CMSvar|}
$!ActiveLineMaps = [1,2]
$!LinePlotLayers ShowLines = Yes
$!LinePlotLayers ShowSymbols = Yes
$!View Fit

$!XYLineAxis XDetail 1 {RangeMin =  0.05 RangeMax = 1.05 Gridlines{Show = Yes} AutoGrid = No GRSpacing = 0.10}
$!XYLineAxis YDetail 1 {RangeMin = -0.25 RangeMax = 1.05 Gridlines{Show = Yes} AutoGrid = No GRSpacing = 0.10}
$!XYLineAxis GridArea{DrawBorder = Yes}

$!AttachText
  AnchorPos { X = 50 Y = 97 }
  TextShape { FontFamily = 'FreeSans' IsBold = No SizeUnits = Frame Height = 3.5 }
  Box { BoxType = Filled Margin = 10 Color = Black FillColor = White }
  Anchor = HeadCenter
  Text = 'DPW-7: |Q| | Rey#=|REYN|M, M=|MACH|, <greek>a</greek>=|ALPHA|<sup>o</sup>\nC<sub>L</sub>=|CL|, C<sub>D</sub>=|CD|, C<sub>My</sub>=|CMy|'

$!PrintSetup Palette = Color
$!ExportSetup ExportRegion = CurrentFrame
$!ExportSetup ImageWidth = 900
$!ExportSetup UseSuperSampleAntiAliasing = Yes
$!ExportSetup ExportFName = "|OutputDirectoryPath||FilePrependLabel|_SectionalIntegration.png"
$!Export
  ExportRegion = CurrentFrame

$!FrameControl ActivateByNumber
  Frame = 1

#===================================================================
# Delete Zones With Sectional Cuts
#-------------------------------------
#$!DELETEZONES  [|NumZonesCuts|-|NUMZONES|]
#===================================================================
