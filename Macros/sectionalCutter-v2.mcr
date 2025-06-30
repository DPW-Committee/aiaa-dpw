#!MC 1410
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#   DPW-8/AePW-4 SECTIONAL CUTTER (Version 2 - October 16, 2024)
#      TO BE USED WITH:
#          DPW8-AePW4_SectionalCuts_v5.dat
#
#       INSTRUCTIONS:
#                  1.   Load Fuselage and Wing Surface Zones into Tecplot
#                  2.   Assign ParticipantID variable as the identifier of the dataset
#                  3.   Assign OutputFileName variable to the path where you would like the data
#                  4.   Assign (Xvar,Yvar,Zvar) variables to the variable number in dataset (typically 1,2,3)
#                  5.   Assign CPvar variable to the variable number in dataset (typically 4)
#                  6.   Assign CFvar variable to the variable number in dataset (if it exists)
#                  7.   Assign CFXvar,CFYvar,CFZvar variables to the variable number in dataset (if exists)
#                  8.   Assign BodyMaps variable to define which zones define the fuselage surface(s)
#                  9.   Assign WingMaps variable to define which zones define the wing surface(s)
#                 10.   Assign PlotTime variable (if multiple time steps are included in dataset) to define which solution time should be used
#                 11.   Select sectional cut stations under section titled "Create Sectional Cuts" on Line 395 --> do not change anything else
#                 12.   Assemble sectional cutter data into data form
#                       DPW8-AePW4_SectionalCuts_v5.dat
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
#            FILE OUTPUT LOCATION
#
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

$!VarSet |ParticipantID|       = '001.1'    # Participant ID for this data set
$!VarSet |OutputFileName|      = 'cuts.dat' # File name

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#
#            PLOT TITLE SOLUTION INFORMATION
#
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
$!VarSet |IsCRM|    = 0        # 0 if it is not the CRM... 1 if it is the CRM


#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#
$!VarSet |Xvar|   =  1      # Variable number to use for X coordinate (running from fuselage nose to tail)
$!VarSet |Yvar|   =  2      # Variable number to use for Y coordinate (running from symmetry plane to wing tip)
$!VarSet |Zvar|   =  3      # Variable number to use for Z coordinate (running from fuselage keel to crown)
$!VarSet |CPvar|  =  15     # Variable number to use for Cp
$!VarSet |CFvar|  =  12     # Variable number to use for Cf contours
$!VarSet |CFXvar| =  9      # Variable number to use for Cfx contours
$!VarSet |CFYvar| =  10     # Variable number to use for Cfx contours
$!VarSet |CFZvar| =  11     # Variable number to use for Cfx contours
$!VarSet |Uvar|   =  5      # Variable number to use for x-component of velocity vector in streamtraces
$!VarSet |Vvar|   =  6      # Variable number to use for y-component of velocity vector in streamtraces
$!VarSet |Wvar|   =  7      # Variable number to use for z-component of velocity vector in streamtraces
$!VarSet |BodyMaps| = '2'   # Fieldmaps of your dataset to plot for the body/fuselage    ('1-2','1,3,5-6',etc.)... will need to be the same as a wing map if a specific body map does not exist
$!VarSet |WingMaps| = '2'   # Fieldmaps of your dataset to plot for the wing or airfoil  ('1-2','1,3,5-6',etc.)
$!VarSet |PlotTime| = ''    # Tecplot SolutionTime variable to export for time-accurate data sets
#                           # NOTE: Use |PlotTime| == '' if no solution time needs to be set.
#
#
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#
# ! ! ! E N D   O F   U S E R   I N P U T ! ! !
#
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

$!VarSet |Xrev|    =  0      # Set to 1 ONLY if X-axis is running from fuselage tail to nose (negative drag direction)
$!VarSet |Yrev|    =  0      # Set to 1 ONLY if Y-axis is running from wing tip to the symmetry plane
$!VarSet |Zrev|    =  0      # Set to 1 ONLY if Z-axis is running from fuselage crown to keel (negative lift direction)
#-------------------------------------

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
$!ACTIVEFIELDMAPS = [|BodyMaps|,|WingMaps|]
$!VarSet |NumCuts| =  0
#$!PAUSE 'Xrange = (|MINX%.12f|,|MAXX%.12f|)\nYrange = (|MINY%.12f|,|MAXY%.12f|)\nZrange = (|MINZ%.12f|,|MAXZ%.12f|)'

# Necessary to transform CRM coordinates to full-scale aircraft? (Not needed for airfoil cases)
$!IF |IsCRM| == 1
  # CRM
  $!VarSet |Scale|  = ((2562.883  - 92.500) / (|MAXX%.12f| - |MINX%.12f|))
  $!VarSet |Xshift| = ( 92.50000    - |MINX%.12f|*|Scale| )
  $!VarSet |Yshift| = (  0.00000    - |MINY%.12f|*|Scale| )
  $!VarSet |Zshift| = (343.14873687 - |MAXZ%.12f|*|Scale| )
  #$!PAUSE 'NOTE: Transforming grid to airplane coordinates with fuselage beginning at (92.5,0.0,198.0) inches\n|tab|Scale = |Scale|\n|tab|Xshift = |Xshift|\n|tab|Yshift = |Yshift|\n|tab|Zshift = |Zshift|'

  $!AlterData
    Equation = 'V|Xvar| = V|Xvar| * |Scale| + |Xshift|'
  $!AlterData
    Equation = 'V|Yvar| = V|Yvar| * |Scale| + |Yshift|'
  $!AlterData
    Equation = 'V|Zvar| = V|Zvar| * |Scale| + |Zshift|'
  #$!PAUSE 'Xrange = (|MINX%.12f|,|MAXX%.12f|)\nYrange = (|MINY%.12f|,|MAXY%.12f|)\nZrange = (|MINZ%.12f|,|MAXZ%.12f|)'
$!ENDIF
$!VarSet |tab| = '             '

#===================================================================

#===================================================================
# Populate variables, if not defined
#-------------------------------------
$!AlterData
    Equation = 'V|Uvar| = V|CFXvar|'
$!AlterData
    Equation = 'V|Vvar| = V|CFYvar|'
$!AlterData
    Equation = 'V|Wvar| = V|CFZvar|'

$!IF "|CFXvar|" == ""
  $!ALTERDATA EQUATION = "{CFXo} = -999"
  $!VARSET |CFXvar|       = "|NUMVARS|"
$!ENDIF
$!IF "|CFYvar|" == ""
  $!ALTERDATA EQUATION = "{CFYo} = -999"
  $!VARSET |CFYvar|       = "|NUMVARS|"
$!ENDIF
$!IF "|CFZvar|" == ""
  $!ALTERDATA EQUATION = "{CFZo} = -999"
  $!VARSET |CFZvar|       = "|NUMVARS|"
$!ENDIF
$!IF "|CF|" == ""
  $!ALTERDATA EQUATION = "{CF}  = SQRT({V|CFXvar|}**2 + {V|CFYvar|}**2 + {V|CFZvar|}**2)"
  $!VARSET |CFvar|     = "|NUMVARS|"
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
# Set rotation center (no effect on view, but nice to have rotation center near middle of view)... scoped for CRM
#-------------------------------------
$!VarSet |RotX|     = 1325.89      # Moment Reference Center
$!VarSet |RotY|     = (2313.50/4)  # 0.25*Span
$!VarSet |RotZ|     = 177.96       # Moment Reference Center
#-------------------------------------


#===================================================================
# Get span
#-------------------------------------
$!VarSet |YRoot|     = ( |MINY%.12f| )
$!VarSet |YTip|      = ( |MAXY%.12f| )
$!VarSet |SemiSpan|  = ( abs(|YTip|-|YRoot|) )
#-------------------------------------


#===================================================================
# Create Macro Function: SectionalCutter
#-------------------------------------
$!MACROFUNCTION
  NAME = "SectionalCutter"

  $!VarSet |NumCuts| = ( |NumCuts| + 1 )
  
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

  $!EXTENDEDCOMMAND COMMANDPROCESSORID='extendmcr' COMMAND='QUERY.ACTIVEZONES SURFZONES'
  $!ActiveFieldMaps = [|NUMZONES|]
  $!AlterData  [|NUMZONES|] Equation = 'V|XoCvar| = (V|Xvar| - |MINX%.12f|)/(|MAXX%.12f| - |MINX%.12f|)'
  $!AlterData  [|NUMZONES|] Equation = 'V|YoCvar| = 0.0'
  $!AlterData  [|NUMZONES|] Equation = 'V|ZoCvar| = (V|Zvar| - |MINZ%.12f|)/(|MAXX%.12f| - |MINX%.12f|)'
  $!ActiveFieldMaps = [|SURFZONES|]
  
  $!VarSet |EtaStationFull| = ( abs(|2|/|SemiSpan|) )
  $!VarSet |EtaStation| = |EtaStationFull%.4f|
  
  $!RENAMEDATASETZONE
    ZONE = |NUMZONES|
    NAME = '|ParticipantID| - SECTIONAL CUT |NumCuts| - eta=|EtaStation|'
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

# RotateOrigin { X = |RotX| Y = |RotY| Z = |RotZ| }
# Right before "LightSource"
$!GlobalThreeD
  AxisScaleFact { X = 1 Y = 1 Z = 1 }
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
#$!FIELDLAYERS USELIGHTINGEFFECT = NO
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
# Establish Zone Number For Cut Data
#-------------------------------------
$!VARSET |NUMZONES1|   = |NUMZONES|
$!VARSET |NUMZONES1|  += 1
#===================================================================

#===================================================================
# Create Sectional Cuts
#-------------------------------------
# If you are running a grid with multiple spanwise cells, take slices at span stations of eta = 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, and 0.9.
#                                      X    Y      Z    Xnorm  Ynorm  Znorm
$!RUNMACROFUNCTION "SectionalCutter" ( 0.0, 11.50, 0.0, 0.000, 1.000, 0.000)





#===================================================================
# Visualize Sectional Cuts
#-------------------------------------
$!FIELDMAP [|NUMZONES1| - |NUMZONES| ] MESH{Show = Yes Color = Green LineThickness = 0.80 }
$!FIELDLAYERS SHOWMESH = YES
$!REDRAWALL
#===================================================================


#===================================================================
# Delete temporary variables used for output only
#-------------------------------------
$!RENAMEDATASETVAR VAR = |Xvar|   NAME = "X"
$!RENAMEDATASETVAR VAR = |Yvar|   NAME = "Y"
$!RENAMEDATASETVAR VAR = |Zvar|   NAME = "Z"
$!RENAMEDATASETVAR VAR = |XoCvar| NAME = "XoC"
$!RENAMEDATASETVAR VAR = |CPvar|  NAME = "CP"
$!RENAMEDATASETVAR VAR = |CFvar|  NAME = "CF"
$!RENAMEDATASETVAR VAR = |CFXvar| NAME = "CFX"
$!RENAMEDATASETVAR VAR = |CFYvar| NAME = "CFY"
$!RENAMEDATASETVAR VAR = |CFZvar| NAME = "CFZ"


$!WriteDataSet  "|ParticipantID|-|OutputFileName|"
  IncludeText = No
  IncludeGeom = No
  IncludeCustomLabels = No
  IncludeDataShareLinkage = Yes
  ZoneList =  [|NUMZONES1| - |NUMZONES|]
  VarList =  ['XoC','CP','CF','CFX','CFY','CFZ','X','Y','Z']
  Binary = No
  UsePointFormat = No
  Precision = 12
  TecplotVersionToWrite = TecplotCurrent