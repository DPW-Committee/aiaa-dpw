#!MC 1410
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#   DPW-VII CONTOUR AND STREAMLINE IMAGE CREATOR (Version 7 - Apr. 29, 2022)
#
#       INSTRUCTIONS:
#                  1.   Load Fuselage and Wing Surface Zones into Tecplot
#                          - NOTE: Using Volume instead of Surface zones may result in run time of hours, not minutes
#                  2.   Assign SolutionLabel variable as the identifier of the dataset
#                  3.   Assign FilePrependLabel variable to the filename to write out sectional cut data (recommend using |SolutionLabel|)
#                  4.   Assign OutputDirectoryPath variable to the path to write out sectional cut data
#                  5.   Assign (Xvar,Yvar,Zvar) variables to the variable number in dataset (typically 1,2,3)
#                  6.   Assign CPvar variable to the variable number in dataset (for CP contours)
#                  7.   Assign CFvar variable to the variable number in dataset (for CF contours)
#                  8.   Assign CFXvar variables to the variable number in dataset (for CFx contours)
#                  9.   Assign Uvar,Vvar,Wvar variables to the variable number in dataset (used for streamtrace vector)
#                 10.   Assign BodyMaps variable to define which zones define the fuselage surface(s)
#                 11.   Assign WingMaps variable to define which zones define the wing surface(s)
#                 12.   Assign PlotTime variable (if multiple time steps are included in dataset) to define which solution time should be used
#                 13.   Run macro and verify output to:
#                          - |OutputDirectoryPath||FilePrependLabel|_View*.png
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
$!VarSet |ALPHA| = '?.????'   # Angle-of-Attack
$!VarSet |CL|    = '?.????'   # Lift Coefficient
$!VarSet |CD|    = '?.??????' # Drag Coefficient
$!VarSet |CMy|   = '??.?????' # Pitching Moment Coefficient

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#
$!VarSet |Xvar|   =  1      # Variable number to use for X coordinate (running from fuselage nose to tail)
$!VarSet |Yvar|   =  2      # Variable number to use for Y coordinate (running from symmetry plane to wing tip)
$!VarSet |Zvar|   =  3      # Variable number to use for Z coordinate (running from fuselage keel to crown)
$!VarSet |CPvar|  =  4      # Variable number to use for Cp
$!VarSet |CFvar|  =  8      # Variable number to use for Cf
$!VarSet |CFXvar| =  5      # Variable number to use for Cfx
$!VarSet |Uvar|   =  5      # Variable number to use for x-component of velocity vector in streamtraces
$!VarSet |Vvar|   =  6      # Variable number to use for y-component of velocity vector in streamtraces
$!VarSet |Wvar|   =  7      # Variable number to use for z-component of velocity vector in streamtraces
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

$!VarSet |EnableStreamlines| =    1 # Enable auto-streamline generation
$!VarSet |WingStreamSpacing| =   18 # Streamline spacing in full scale inches
$!VarSet |BodyStreamSpacing| =    6 # Streamline spacing in full scale inches

$!VarSet |ImageWidth|        = 1350 # Output picture pixel width

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
    Equation = 'V|Uvar| = -1 * V|Uvar|'
 $!IF |CFXvar| != |Uvar|
  $!AlterData
    Equation = 'V|CFXvar| = -1 * V|CFXvar|'
 $!ENDIF
$!ENDIF
$!IF |Yrev| == 1
  $!AlterData
    Equation = 'V|Yvar| = -1 * V|Yvar|'
  $!AlterData
    Equation = 'V|Vvar| = -1 * V|Vvar|'
$!ENDIF
$!IF |Zrev| == 1
  $!AlterData
    Equation = 'V|Zvar| = -1 * V|Zvar|'
  $!AlterData
    Equation = 'V|Wvar| = -1 * V|Wvar|'
$!ENDIF

# Calculate scaling based on grid coordinate ranges
#-------------------------------------
$!ACTIVEFIELDMAPS = [|BodyMaps|,|WingMaps|]
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
  Name = 'C<sub>P</sub>'
$!RenameDataSetVar
  Var = |CFvar|
  Name = 'C<sub>F</sub>'
$!RenameDataSetVar
  Var = |CFXvar|
  Name = 'C<sub>Fx</sub>'
$!RenameDataSetVar
  Var = |Uvar|
  Name = 'U'
$!RenameDataSetVar
  Var = |Vvar|
  Name = 'V'
$!RenameDataSetVar
  Var = |Wvar|
  Name = 'W'
#-------------------------------------

#===================================================================
# Set rotation center (no effect on view, but nice to have rotation center near middle of view)
#-------------------------------------
$!VarSet |RotX|     = 1325.89      # Moment Reference Center
$!VarSet |RotY|     = (2313.50/4)  # 0.25*Span
$!VarSet |RotZ|     = 177.96       # Moment Reference Center
#-------------------------------------

#===================================================================
# Create Macro Function: ExportContours
#-------------------------------------
#$!RUNMACROFUNCTION "ExportContours" ('Cp', '|EnableStreamlines|','|BodyMaps|,|WingMaps|','|OutputDirectoryPath||FilePrependLabel|_View|ViewNum|','Custom2','Black')
#$!RUNMACROFUNCTION "ExportContours" ('Cf', '|EnableStreamlines|','|BodyMaps|,|WingMaps|','|OutputDirectoryPath||FilePrependLabel|_View|ViewNum|','Custom2','Black')
#$!RUNMACROFUNCTION "ExportContours" ('Cfx','|EnableStreamlines|','|BodyMaps|,|WingMaps|','|OutputDirectoryPath||FilePrependLabel|_View|ViewNum|','Custom2','Black')
$!MACROFUNCTION
  NAME = "ExportContours"

  $!Varset |ContourLabel|      = '|1|'
  $!Varset |EnableStreamlines| = '|2|'
  $!Varset |Maps|              = '|3|'
  $!Varset |OutputPrepend|     = '|4|'
  $!Varset |LineColorStream|   = '|5|'
  $!Varset |LineColorNoStream| = '|6|'

  $!IF     '|ContourLabel|' == 'Cp'
    $!Varset |ContourGroup| = 1
  $!ELSEIF '|ContourLabel|' == 'Cf'
    $!Varset |ContourGroup| = 2
  $!ELSEIF '|ContourLabel|' == 'Cfx'
    $!Varset |ContourGroup| = 3
  $!ENDIF
  $!Varset |FloodColor| = 'Group|ContourGroup|'

  $!FieldMap  [|Maps|] Contour { LineContourGroup = |ContourGroup| FloodColoring = |FloodColor| }

  $!IF |EnableStreamlines| == 1
    $!STREAMTRACELAYERS SHOW = Yes
    $!FieldMap [|BodyMaps|,|WingMaps|] Contour{ContourType = BothLinesAndFlood Color = |LineColorStream|}
    $!ExportSetup ExportFName = '|OutputPrepend|_|ContourLabel|_Stream.png'
    $!Export
      ExportRegion = AllFrames
  $!ENDIF

  $!STREAMTRACELAYERS SHOW = No
  $!FieldMap [|BodyMaps|,|WingMaps|] Contour{ContourType = BothLinesAndFlood Color = |LineColorNoStream|}
  $!ExportSetup ExportFName = '|OutputPrepend|_|ContourLabel|.png'
  $!Export
    ExportRegion = AllFrames

  $!FieldMap  [|Maps|] Contour { LineContourGroup = 1 FloodColoring = Group1 }
$!ENDMACROFUNCTION
#===================================================================

#===================================================================
# Define color maps
#-------------------------------------
$!CreateColorMap
  Name = 'Small_Rainbow_DPW'
  NumControlPoints = 5
  ControlPoint 1 { ColorMapFraction = 0.00 LeadRGB { R=0   G=0   B=255 } TrailRGB { R=0   G=0   B=255 } }
  ControlPoint 2 { ColorMapFraction = 0.25 LeadRGB { R=0   G=255 B=255 } TrailRGB { R=0   G=255 B=255 } }
  ControlPoint 3 { ColorMapFraction = 0.50 LeadRGB { R=0   G=255 B=0   } TrailRGB { R=0   G=255 B=0   } }
  ControlPoint 4 { ColorMapFraction = 0.75 LeadRGB { R=255 G=255 B=0   } TrailRGB { R=255 G=255 B=0   } }
  ControlPoint 5 { ColorMapFraction = 1.00 LeadRGB { R=255 G=0   B=0   } TrailRGB { R=255 G=0   B=0   } }

$!CreateColorMap
  Name = 'CfMap_DPW'
  NumControlPoints = 5
  ControlPoint 1 { ColorMapFraction = 0.00 LeadRGB { R=0   G=0   B=0   } TrailRGB { R=0   G=0   B=0   } }
  ControlPoint 2 { ColorMapFraction = 0.25 LeadRGB { R=0   G=191 B=255 } TrailRGB { R=0   G=191 B=255 } }
  ControlPoint 3 { ColorMapFraction = 0.50 LeadRGB { R=127 G=255 B=0   } TrailRGB { R=127 G=255 B=0   } }
  ControlPoint 4 { ColorMapFraction = 0.75 LeadRGB { R=255 G=0   B=64  } TrailRGB { R=255 G=0   B=64  } }
  ControlPoint 5 { ColorMapFraction = 1.00 LeadRGB { R=255 G=255 B=255 } TrailRGB { R=255 G=255 B=255 } }
#===================================================================

#===================================================================
# Define contour maps
#-------------------------------------
$!GlobalContour  1
  Var = |CPvar|
 #ColorMapName = 'Sequential - Viridis'
  ColorMapName = 'Small_Rainbow_DPW'
  DefNumLevels = 18
  Legend { Show = Yes IsVertical = Yes RowSpacing = 1.0 XYPos { X = 97 Y = 75 } Box { BoxType = None } }
  Legend{ NumberTextShape{FontFamily = 'FreeSans'} HeaderTextShape{FontFamily = 'FreeSans'} }
  ColorCutoff { RangeMin = -1.0 RangeMax = 0.6 }
  ColorMapFilter { ColorMapDistribution = Continuous ContinuousColor { CMin = -1.2 CMax = 0.5 } UseFastApproxContinuousFlood = Yes ReverseColorMap = Yes }

$!ContourLevels New
  ContourGroup = 1
  RawData
18
-1.2
-1.1
-1
-0.9
-0.8
-0.7
-0.6
-0.5
-0.4
-0.3
-0.2
-0.1
0
0.1
0.2
0.3
0.4
0.5

$!GlobalContour  2
  Var = |CFvar|
 #ColorMapName = 'Small Rainbow'
  ColorMapName = 'CfMap_DPW'
  DefNumLevels = 6
  Legend { Show = Yes IsVertical = Yes RowSpacing = 1.0 XYPos { X = 97 Y = 75 } Box { BoxType = None } }
  Legend{ NumberTextShape{FontFamily = 'FreeSans'} HeaderTextShape{FontFamily = 'FreeSans'} }
  ColorCutoff { RangeMin = 0.0 RangeMax = 1.0 }
  ColorMapFilter { ColorMapDistribution = Continuous ContinuousColor { CMin = 0 CMax = 0.005 } UseFastApproxContinuousFlood = Yes ReverseColorMap = No }

$!ContourLevels New
  ContourGroup = 2
  RawData
6
0
0.001
0.002
0.003
0.004
0.005

$!GlobalContour  3
  Var = |CFxvar|
 #ColorMapName = 'Small Rainbow'
  ColorMapName = 'CfMap_DPW'
  DefNumLevels = 8
  Legend { Show = Yes IsVertical = Yes RowSpacing = 1.0 XYPos { X = 97 Y = 75 } Box { BoxType = None } }
  Legend{ NumberTextShape{FontFamily = 'FreeSans'} HeaderTextShape{FontFamily = 'FreeSans'} }
  ColorCutoff { RangeMin = -1.0 RangeMax = 1.0 }
  ColorMapFilter { ColorMapDistribution = Continuous ContinuousColor { CMin = -0.002 CMax = 0.005 } UseFastApproxContinuousFlood = Yes ReverseColorMap = No }

$!ContourLevels New
  ContourGroup = 3
  RawData
8
-0.002
-0.001
0
0.001
0.002
0.003
0.004
0.005
#===================================================================

$!GlobalThreeDVector
  UVar = |Uvar|
  VVar = |Vvar|
  WVar = |Wvar|
  RelativeLength = 150

$!IF "|PlotTime|" != ""
  $!GlobalTime
    SolutionTime = |PlotTime|
$!ENDIF

$!FieldMap  [|BodyMaps|,|WingMaps|]
  Mesh { Color = Black }
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
  EdgeLayer { Show = Yes Color = Black LineThickness = 0.1 }
  Points { PointsToPlot = SurfaceNodes }
  Surfaces { SurfacesToPlot = KPlanes IRange { Max = 1 } }
  VolumeMode { VolumeObjectsToPlot { ShowIsosurfaces = No ShowSlices = No ShowStreamtraces = No } }
  Effects { LightingEffect = Gouraud }

$!FieldLayers
  ShowMesh = No
  ShowContour = Yes
  ShowShade = Yes
  ShowEdge = No
$!StreamtraceLayers
  Show = Yes

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

$!PrintSetup Palette = Color
$!ExportSetup ExportFormat = PNG
$!ExportSetup ExportRegion = AllFrames
$!ExportSetup ImageWidth = |ImageWidth|
$!ExportSetup UseSuperSampleAntiAliasing = Yes
$!ExportSetup SuperSampleFactor = 3
$!ExportSetup ConvertTo256Colors = No

#===================================================================
# Generate Streamlines
#-------------------------------------
$!IF |EnableStreamlines| == 1
   $!Streamtrace DeleteAll

   $!RESETVECTORLENGTH
   $!STREAMTRACELAYERS SHOW = YES
   $!STREAMTRACE RESETDELTATIME
   $!STREAMATTRIBUTES RODRIBBON{WIDTH = 200.0}

   $!ACTIVEFIELDMAPS = [|BodyMaps|]
   $!VarSet |MINXBODY| = |MINX%.2f|
   $!VarSet |MAXXBODY| = |MAXX%.2f|
   $!VarSet |MINYBODY| = |MINY%.2f|
   $!VarSet |MAXYBODY| = |MAXY%.2f|
   $!VarSet |MINZBODY| = |MINZ%.2f|
   $!VarSet |MAXZBODY| = |MAXZ%.2f|

   $!ACTIVEFIELDMAPS = [|WingMaps|]
   $!VarSet |MINXWING| = |MINX%.2f|
   $!VarSet |MAXXWING| = |MAXX%.2f|
   $!VarSet |MINYWING| = |MINY%.2f|
   $!VarSet |MAXYWING| = |MAXY%.2f|
   $!VarSet |MINZWING| = |MINZ%.2f|
   $!VarSet |MAXZWING| = |MAXZ%.2f|

   $!ACTIVEFIELDMAPS = [|BodyMaps|,|WingMaps|]
   $!VarSet |MaxYcfg| = |MAXY%.2f|
   $!VarSet |MinXcfg| = |MINX%.2f|
   $!VarSet |MaxXcfg| = |MAXX%.2f|

   #----------------------------------------------------------------------------------
   # Create dummy zone at Z=10000.0 to ensure every slice will find something
   #----------------------------------------------------------------------------------
   $!VarSet |MAXDIM| = 10000.0
   $!CREATERECTANGULARZONE
     X1 = ( 1*|MAXDIM|)
     Y1 = (-1*|MAXDIM|)
     Z1 = (-1*|MAXDIM|)
     X2 = ( 1*|MAXDIM|)
     Y2 = ( 1*|MAXDIM|)
     Z2 = ( 1*|MAXDIM|)
     IMAX = 1
     JMAX = 3
     KMAX = 3
   $!VarSet |MAPS_DUMMY| = |NUMZONES|
   $!RENAMEDATASETZONE
     ZONE = |MAPS_DUMMY|
     NAME = 'DUMMYZONE'

   $!LOOP 3
      $!VarSet |ViewIndex| = |Loop|
      $!IF |ViewIndex| == 1
          $!VarSet |TEC_View| = "WingUpper"
      $!ELSEIF |ViewIndex| == 2
          $!VarSet |TEC_View| = "WingLower"
      $!ELSEIF |ViewIndex| == 3
          $!VarSet |TEC_View| = "Body"
      $!ENDIF
      $!IF |ViewIndex| <= 2
         #-------------------
         # Y slices of wing
         $!VarSet |MIN| = |MINYWING|
         $!VarSet |MAX| = |MAXYWING|
         $!VarSet |SPAN| = ( |MAX| - |MIN| )
         $!VarSet |NUMSTREAMS| = ((|SPAN|/|WingStreamSpacing|+1))
      $!ELSE
         # Z slices of body
         $!VarSet |MIN| = |MINZBODY|
         $!VarSet |MAX| = |MAXZBODY|
         $!VarSet |MIN| = 100
         $!VarSet |MAX| = 250
         $!VarSet |DIAM| = ( |MAX| - |MIN| )
         $!VarSet |NUMSTREAMS| = ((|DIAM|/|BodyStreamSpacing|+1))
      $!ENDIF
      $!VarSet |NUMSTREAMS| = |NUMSTREAMS%d|

      $!LOOP |NUMSTREAMS|
         $!IF |ViewIndex| <= 2
            #Make Y Slice
            $!VarSet |SlicY| = (|MIN| + |SPAN|*(|Loop|)/(|NUMSTREAMS|+1))
            $!ACTIVEFIELDMAPS = [|WingMaps|,|MAPS_DUMMY|]
            $!GLOBALTHREED SLICE { ORIGIN {Y=(|SlicY|)} NORMAL { X=0 Y=1 Z=0 }}
         $!ELSE
            #Make Z Slice
            $!VarSet |SlicZ| = (|MIN| + |DIAM|*(|Loop|)/(|NUMSTREAMS|+1))
            $!ACTIVEFIELDMAPS = [|BodyMaps|,|MAPS_DUMMY|]
            $!GLOBALTHREED SLICE { ORIGIN {Z=(|SlicZ|)} NORMAL { X=0 Y=0 Z=1 }}
         $!ENDIF

         $!CREATESLICEZONEFROMPLANE SLICESOURCE=SURFACEZONES
         $!ACTIVEFIELDMAPS = [|NUMZONES|]

         #Check if slice found any data in the airplane (i.e. not in the dummy plane at MAXDIM)
         $!VarSet |XLE| = ( 1*|MAXDIM|)
         $!VarSet |XTE| = (-1*|MAXDIM|)
         $!LOOP |MaxI|
            $!GetFieldValue |CurrX|
              Zone = |NUMZONES|
              Var = 1
              Index = |Loop|
            $!IF |CurrX| < (|MAXDIM|-1.0)
               $!IF |CurrX| < |XLE|
                     $!VarSet |XLE| = |CurrX|
               $!ENDIF
               $!IF |CurrX| > |XTE|
                     $!VarSet |XTE| = |CurrX|
               $!ENDIF
            $!ENDIF
         $!ENDLOOP

         $!IF |XLE| < ( 1*|MAXDIM|)
            $!IF |XTE| > (-1*|MAXDIM|)
              # Turn on Fwd/Aft Seeds for this slice
               $!VarSet |Seed1| = "On"
               $!VarSet |Seed2| = "On"
               $!VarSet |Seed3| = "On"

               $!VarSet |ValX1| = ( 1*|MAXDIM|)
               $!Varset |ValY1| = ( 1*|MAXDIM|)
               $!VarSet |ValZ1| = (-1*|MAXDIM|)
               $!Varset |ValX2| = ( 1*|MAXDIM|)
               $!Varset |ValY2| = ( 1*|MAXDIM|)
               $!VarSet |ValZ2| = (-1*|MAXDIM|)
               $!VarSet |ValX3| = (-1*|MAXDIM|)
               $!VarSet |ValY3| = (-1*|MAXDIM|)
               $!VarSet |ValZ3| = (-1*|MAXDIM|)
               $!VarSet |Xdst1| = 1000000
               $!VarSet |Xdst2| = 1000000
               $!VarSet |Xdst3| = 1000000
               $!IF |ViewIndex| <= 2
                  $!VarSet |Xpnt1| = ( |XLE| + (|XTE| - |XLE|)*0.20 )
                  $!VarSet |Xpnt2| = ( |XLE| + (|XTE| - |XLE|)*0.95 )
                  $!VarSet |Xpnt3| = ( |XLE| + (|XTE| - |XLE|)*0.75 )
                  $!IF "|TEC_View|" == "WingLower"
                     $!VarSet |ValZ1| = ( 1*|MAXDIM|)
                     $!VarSet |ValZ2| = ( 1*|MAXDIM|)
                     $!VarSet |ValZ3| = ( 1*|MAXDIM|)
                  $!ENDIF
               $!ELSE
                 #Loop over Nodes on Slice to find closest point to X = |Xfwd| and X = |Xaft|
                  $!VarSet |Xfwd|  =  985   # 990
                  $!VarSet |Xmid|  = 1050   #1450
                  $!VarSet |Xaft|  = 1550   #1450
                  $!VarSet |Seed3| = "On"
               $!ENDIF

              #----------------------------
              #Loop over Nodes on Slice to find Max Z
               $!LOOP |MaxI|
                  $!GetFieldValue |CurrX|
                    Zone = |NUMZONES|
                    Var = 1
                    Index = |Loop|
                  $!GetFieldValue |CurrY|
                    Zone = |NUMZONES|
                    Var = 2
                    Index = |Loop|
                  $!GetFieldValue |CurrZ|
                    Zone = |NUMZONES|
                    Var = 3
                    Index = |Loop|
                  $!IF |CurrX| < (|MAXDIM|-1.0)
                     $!IF |ViewIndex| <= 2
                       #----------------------------
                       # Fwd Seed Point
                        $!IF |CurrX| < |Xpnt1|
                           $!IF "|TEC_View|" == "WingLower"
                             # Fwd Seed from MINIMUM Z (between X/C = [0.0-0.2])
                              $!IF |CurrZ| < |ValZ1|
                                 $!VarSet |ValX1| = |CurrX|
                                 $!VarSet |ValY1| = |CurrY|
                                 $!VarSet |ValZ1| = |CurrZ|
                              $!ENDIF
                           $!ELSE
                             # Fwd Seed from MAXIMUM Z (between X/C = [0.0-0.2])
                              $!IF |CurrZ| > |ValZ1|
                                 $!VarSet |ValX1| = |CurrX|
                                 $!VarSet |ValY1| = |CurrY|
                                 $!VarSet |ValZ1| = |CurrZ|
                              $!ENDIF
                           $!ENDIF
                        $!ENDIF
                       # Aft Seed Point
                        $!IF |CurrX| > |Xpnt2|
                           $!IF "|TEC_View|" == "WingLower"
                             #Aft Seed from MINIMUM Z (between X/C = [0.9-1.0])
                              $!IF |CurrZ| < |ValZ2|
                                 $!VarSet |ValX2| = |CurrX|
                                 $!VarSet |ValY2| = |CurrY|
                                 $!VarSet |ValZ2| = |CurrZ|
                              $!ENDIF
                           $!ELSE
                             #Aft Seed from MAXIMUM Z (between X/C = [0.9-1.0])
                              $!IF |CurrZ| > |ValZ2|
                                 $!VarSet |ValX2| = |CurrX|
                                 $!VarSet |ValY2| = |CurrY|
                                 $!VarSet |ValZ2| = |CurrZ|
                              $!ENDIF
                           $!ENDIF
                        $!ENDIF
                       # Mid Seed Point (closest point to x/c=0.75)
                       $!IF "|TEC_View|" == "WingUpper"
                        $!IF "|TEC_View|" == "WingLower"
                           $!IF |CurrZ| < |ValZ3|
                              $!IF |CurrX| > |Xpnt3|
                                 $!VarSet |delX3| = (|CurrX| - |Xpnt3|)
                              $!ELSE
                                 $!VarSet |delX3| = (|Xpnt3| - |CurrX|)
                              $!ENDIF
                           $!ENDIF
                        $!ELSE
                           $!IF |CurrZ| > |ValZ3|
                              $!IF |CurrX| > |Xpnt3|
                                 $!VarSet |delX3| = (|CurrX| - |Xpnt3|)
                              $!ELSE
                                 $!VarSet |delX3| = (|Xpnt3| - |CurrX|)
                              $!ENDIF
                           $!ENDIF
                        $!ENDIF
                        $!IF |delX3| < |Xdst3|
                           $!VarSet |ValX3| = |CurrX|
                           $!VarSet |ValY3| = |CurrY|
                           $!VarSet |ValZ3| = |CurrZ|
                           $!VarSet |Xdst3| = |delX3|
                        $!ENDIF
                       $!ENDIF
                       #----------------------------
                     $!ELSE
                       #----------------------------
                       # Fwd Seed Point
                        $!IF |CurrX| > |Xfwd|
                           $!VarSet |delX1| = (|CurrX| - |Xfwd|)
                        $!ELSE
                           $!VarSet |delX1| = (|Xfwd| - |CurrX|)
                        $!ENDIF
                        $!IF |delX1| < |Xdst1|
                           $!VarSet |ValX1| = |CurrX|
                           $!VarSet |ValY1| = |CurrY|
                           $!VarSet |ValZ1| = |CurrZ|
                           $!VarSet |Xdst1| = |delX1|
                        $!ENDIF
                       # Aft Seed Point
                        $!IF |CurrX| > |Xaft|
                           $!VarSet |delX2| = (|CurrX| - |Xaft|)
                        $!ELSE
                           $!VarSet |delX2| = (|Xaft| - |CurrX|)
                        $!ENDIF
                        $!IF |delX2| < |Xdst2|
                           $!VarSet |ValX2| = |CurrX|
                           $!VarSet |ValY2| = |CurrY|
                           $!VarSet |ValZ2| = |CurrZ|
                           $!VarSet |Xdst2| = |delX2|
                        $!ENDIF
                       # Mid Seed Point
                        $!IF |CurrX| > |Xmid|
                           $!VarSet |delX3| = (|CurrX| - |Xmid|)
                        $!ELSE
                           $!VarSet |delX3| = (|Xmid| - |CurrX|)
                        $!ENDIF
                        $!IF |delX3| < |Xdst3|
                           $!VarSet |ValX3| = |CurrX|
                           $!VarSet |ValY3| = |CurrY|
                           $!VarSet |ValZ3| = |CurrZ|
                           $!VarSet |Xdst3| = |delX3|
                        $!ENDIF
                       #----------------------------
                     $!ENDIF
                  $!ENDIF
                 #----------------------------
               $!ENDLOOP
              #----------------------------
              # Turn off streamline if Val[XYZ] and Val[XYZ]2 variables are invalid
               $!IF     |ValX1| >= ( 1*|MAXDIM|)
                  $!VarSet |Seed1| = "Off"
               $!ELSEIF |ValY1| >= ( 1*|MAXDIM|)
                  $!VarSet |Seed1| = "Off"
               $!ENDIF
               $!IF     |ValX2| >= ( 1*|MAXDIM|)
                  $!VarSet |Seed2| = "Off"
               $!ELSEIF |ValY2| >= ( 1*|MAXDIM|)
                  $!VarSet |Seed2| = "Off"
               $!ENDIF
               $!IF     |ValX3| >= ( 1*|MAXDIM|)
                  $!VarSet |Seed3| = "Off"
               $!ELSEIF |ValY3| >= ( 1*|MAXDIM|)
                  $!VarSet |Seed3| = "Off"
               $!ENDIF
               $!IF "|TEC_View|" == "WingLower"
                  $!IF |ValZ1| >= ( 1*|MAXDIM|)
                     $!VarSet |Seed1| = "Off"
                  $!ENDIF
                  $!IF |ValZ2| >= ( 1*|MAXDIM|)
                     $!VarSet |Seed2| = "Off"
                  $!ENDIF
                 #$!IF |ValZ3| >= ( 1*|MAXDIM|)
                     $!VarSet |Seed3| = "Off"
                 #$!ENDIF
               $!ELSE
                  $!IF |ValZ1| <= (-1*|MAXDIM|)
                     $!VarSet |Seed1| = "Off"
                  $!ENDIF
                  $!IF |ValZ2| <= (-1*|MAXDIM|)
                     $!VarSet |Seed2| = "Off"
                  $!ENDIF
                  $!IF |ValZ3| <= (-1*|MAXDIM|)
                     $!VarSet |Seed3| = "Off"
                  $!ENDIF
               $!ENDIF
              #----------------------------
              # Add StreamTrace at point(s) found
               $!ACTIVEFIELDMAPS = [|WingMaps|]
               $!IF "|Seed1|" != "Off"
                  $!STREAMTRACE ADD
                     STREAMTYPE = SURFACELINE
                     STREAMDIRECTION = BOTH
                     STARTPOS { X = |ValX1| Y = |ValY1| Z = |ValZ1| }
               $!ENDIF
               $!IF "|Seed2|" != "Off"
                  $!STREAMTRACE ADD
                     STREAMTYPE = SURFACELINE
                     STREAMDIRECTION = BOTH
                     STARTPOS { X = |ValX2| Y = |ValY2| Z = |ValZ2| }
               $!ENDIF
               $!IF "|Seed3|" != "Off"
                  $!STREAMTRACE ADD
                     STREAMTYPE = SURFACELINE
                     STREAMDIRECTION = BOTH
                     STARTPOS { X = |ValX3| Y = |ValY3| Z = |ValZ3| }
               $!ENDIF
              #----------------------------
            $!ENDIF
         $!ENDIF
        #----------------------------
        # Delete slice zone
         $!DELETEZONES [|NUMZONES|]
      $!ENDLOOP
   $!ENDLOOP
   # Delete dummy zone
   $!DELETEZONES [|MAPS_DUMMY|]

$!ENDIF
#===================================================================

#===================================================================
# Add Text Labels
#-------------------------------------
$!AttachText
  AnchorPos { X = 50 Y = 98.5 }
  TextShape { FontFamily = 'FreeSans' IsBold = No }
  Box { BoxType = Filled Margin = 10 Color = Black FillColor = White }
  Anchor = HeadCenter
  Text = 'DPW-7: |Q| | Rey#=|REYN|M, M=|MACH|, <greek>a</greek>=|ALPHA|<sup>o</sup>, C<sub>L</sub>=|CL|, C<sub>D</sub>=|CD|, C<sub>My</sub>=|CMy|'

$!AttachText
  AnchorPos { X = 50 Y = 1.5 }
  TextShape { FontFamily = 'FreeSans' IsBold = No }
  Box { BoxType = Filled Margin = 10 Color = Black FillColor = White }
  Anchor = Center
  Text = '|SolutionLabel|'
#===================================================================

$!DRAWGRAPHICS TRUE

$!FIELDLAYERS SHOWMESH = NO
$!FIELDLAYERS SHOWCONTOUR = YES
$!FIELDLAYERS SHOWSHADE = YES
$!FIELDLAYERS SHOWVECTOR = NO
$!FIELDLAYERS SHOWEDGE = NO
$!FIELDLAYERS SHOWSCATTER = NO
$!FIELDLAYERS USELIGHTINGEFFECT = NO
$!FIELDLAYERS USETRANSLUCENCY = NO
$!SLICELAYERS SHOW = NO
$!STREAMTRACELAYERS SHOW = YES
$!STREAMATTRIBUTES ADDARROWS = YES

#===================================================================
# Activate fuselage and wing surfaces
#-------------------------------------
$!ActiveFieldMaps = [|BodyMaps|,|WingMaps|]

$!View Fit

$!RedrawAll

#===================================================================
# View 1 - Full config, upper surface
#-------------------------------------
$!VarSet |ViewNum|  = 1
$!VarSet |ViewWid|  = 2500
$!VarSet |ViewX|    = 1325
$!VarSet |ViewY|    = 650
$!VarSet |ViewZ|    = 500
$!VarSet |PsiAng|   = 0
$!VarSet |ThetaAng| = 0
$!VarSet |AlphaAng| = 0
#---
$!ThreeDView
  PSIAngle   = |PsiAng|
  ThetaAngle = |ThetaAng|
  AlphaAngle = |AlphaAng|
  ViewerPosition { X = |ViewX| Y = |ViewY| Z = |ViewZ| }
  ViewWidth = |ViewWid|
$!ThreeDAxis FrameAxis { Size = 4 XYPos { X =  4 Y =  4 } }

$!GlobalContour  1  Legend{IsVertical = Yes RowSpacing = 1.0 XYPos { X = 97 Y = 75 }}
$!GlobalContour  2  Legend{IsVertical = Yes RowSpacing = 1.0 XYPos { X = 97 Y = 75 }}
$!GlobalContour  3  Legend{IsVertical = Yes RowSpacing = 1.0 XYPos { X = 97 Y = 75 }}

$!ActiveFieldMaps = [|BodyMaps|,|WingMaps|]

$!RedrawAll

# Create Cp contour plots
$!RUNMACROFUNCTION "ExportContours" ('Cp', |EnableStreamlines|,'|BodyMaps|,|WingMaps|','|OutputDirectoryPath||FilePrependLabel|_View|ViewNum|','Custom2','Custom2')

# Create Cf contour plots
$!RUNMACROFUNCTION "ExportContours" ('Cf', |EnableStreamlines|,'|BodyMaps|,|WingMaps|','|OutputDirectoryPath||FilePrependLabel|_View|ViewNum|','Custom2','Custom2')

# Create Cfx contour plots
$!RUNMACROFUNCTION "ExportContours" ('Cfx',|EnableStreamlines|,'|BodyMaps|,|WingMaps|','|OutputDirectoryPath||FilePrependLabel|_View|ViewNum|','Custom2','Custom2')
#===================================================================

#===================================================================
# View 2 - Full config, lower surface
#-------------------------------------
$!VarSet |ViewNum|  = 2
$!VarSet |ViewWid|  = 2500
$!VarSet |ViewX|    = 1325
$!VarSet |ViewY|    = 650
$!VarSet |ViewZ|    = -500
$!VarSet |PsiAng|   = 180
$!VarSet |ThetaAng| = 0
$!VarSet |AlphaAng| = 0
#---
$!ThreeDView
  PSIAngle   = |PsiAng|
  ThetaAngle = |ThetaAng|
  AlphaAngle = |AlphaAng|
  ViewerPosition { X = |ViewX| Y = |ViewY| Z = |ViewZ| }
  ViewWidth = |ViewWid|
$!ThreeDAxis FrameAxis { Size = 4 XYPos { X =  4 Y =  8 } }

$!GlobalContour  1  Legend{IsVertical = Yes RowSpacing = 1.0 XYPos { X = 97 Y = 75 }}
$!GlobalContour  2  Legend{IsVertical = Yes RowSpacing = 1.0 XYPos { X = 97 Y = 75 }}
$!GlobalContour  3  Legend{IsVertical = Yes RowSpacing = 1.0 XYPos { X = 97 Y = 75 }}

$!ActiveFieldMaps = [|BodyMaps|,|WingMaps|]

$!RedrawAll

# Create Cp contour plots
$!RUNMACROFUNCTION "ExportContours" ('Cp', |EnableStreamlines|,'|BodyMaps|,|WingMaps|','|OutputDirectoryPath||FilePrependLabel|_View|ViewNum|','Custom2','Custom2')

# Create Cf contour plots
$!RUNMACROFUNCTION "ExportContours" ('Cf', |EnableStreamlines|,'|BodyMaps|,|WingMaps|','|OutputDirectoryPath||FilePrependLabel|_View|ViewNum|','Custom2','Custom2')

# Create Cfx contour plots
$!RUNMACROFUNCTION "ExportContours" ('Cfx',|EnableStreamlines|,'|BodyMaps|,|WingMaps|','|OutputDirectoryPath||FilePrependLabel|_View|ViewNum|','Custom2','Custom2')
#===================================================================

#===================================================================
# View 3 - Fuselage side-view
#-------------------------------------
$!VarSet |ViewNum|  = 3
$!VarSet |ViewWid|  = 900
$!VarSet |ViewX|    = 1225
$!VarSet |ViewY|    = 0
$!VarSet |ViewZ|    = 200
$!VarSet |PsiAng|   = 90
$!VarSet |ThetaAng| = 0
$!VarSet |AlphaAng| = 0
#---
$!ThreeDView
  PSIAngle   = |PsiAng|
  ThetaAngle = |ThetaAng|
  AlphaAngle = |AlphaAng|
  ViewerPosition { X = |ViewX| Y = |ViewY| Z = |ViewZ| }
  ViewWidth = |ViewWid|
$!ThreeDAxis FrameAxis { Size = 4 XYPos { X =  4 Y =  4 } }

$!GlobalContour  1  Legend{IsVertical = No  RowSpacing = 1.0 XYPos { X = 97 Y = 30 }}
$!GlobalContour  2  Legend{IsVertical = No  RowSpacing = 1.0 XYPos { X = 97 Y = 30 }}
$!GlobalContour  3  Legend{IsVertical = No  RowSpacing = 1.0 XYPos { X = 97 Y = 30 }}

$!ActiveFieldMaps = [|BodyMaps|]

$!RedrawAll

# Create Cp contour plots
$!RUNMACROFUNCTION "ExportContours" ('Cp', |EnableStreamlines|,'|BodyMaps|,|WingMaps|','|OutputDirectoryPath||FilePrependLabel|_View|ViewNum|','Custom2','Custom2')

# Create Cf contour plots
$!RUNMACROFUNCTION "ExportContours" ('Cf', |EnableStreamlines|,'|BodyMaps|,|WingMaps|','|OutputDirectoryPath||FilePrependLabel|_View|ViewNum|','Custom2','Custom2')

# Create Cfx contour plots
$!RUNMACROFUNCTION "ExportContours" ('Cfx',|EnableStreamlines|,'|BodyMaps|,|WingMaps|','|OutputDirectoryPath||FilePrependLabel|_View|ViewNum|','Custom2','Custom2')
#===================================================================

#===================================================================
# View 4 - Wing, upper view
#-------------------------------------
$!VarSet |ViewNum|  = 4
$!VarSet |ViewWid|  = 1300
$!VarSet |ViewX|    = 1350
$!VarSet |ViewY|    = 650
$!VarSet |ViewZ|    = 500
$!VarSet |PsiAng|   = 0
$!VarSet |ThetaAng| = 0
$!VarSet |AlphaAng| = 0
#---
$!ThreeDView
  PSIAngle   = |PsiAng|
  ThetaAngle = |ThetaAng|
  AlphaAngle = |AlphaAng|
  ViewerPosition { X = |ViewX| Y = |ViewY| Z = |ViewZ| }
  ViewWidth = |ViewWid|
$!ThreeDAxis FrameAxis { Size = 4 XYPos { X =  4 Y =  4 } }

$!GlobalContour  1  Legend{IsVertical = Yes RowSpacing = 1.0 XYPos { X = 97 Y = 75 }}
$!GlobalContour  2  Legend{IsVertical = Yes RowSpacing = 1.0 XYPos { X = 97 Y = 75 }}
$!GlobalContour  3  Legend{IsVertical = Yes RowSpacing = 1.0 XYPos { X = 97 Y = 75 }}

$!ActiveFieldMaps = [|WingMaps|]

$!RedrawAll

# Create Cp contour plots
$!RUNMACROFUNCTION "ExportContours" ('Cp', |EnableStreamlines|,'|BodyMaps|,|WingMaps|','|OutputDirectoryPath||FilePrependLabel|_View|ViewNum|','Custom2','Custom2')

# Create Cf contour plots
$!RUNMACROFUNCTION "ExportContours" ('Cf', |EnableStreamlines|,'|BodyMaps|,|WingMaps|','|OutputDirectoryPath||FilePrependLabel|_View|ViewNum|','Custom2','Custom2')

# Create Cfx contour plots
$!RUNMACROFUNCTION "ExportContours" ('Cfx',|EnableStreamlines|,'|BodyMaps|,|WingMaps|','|OutputDirectoryPath||FilePrependLabel|_View|ViewNum|','Custom2','Custom2')
#===================================================================

#===================================================================
# View 5 - Fuselage/Wing Side-of-Body view
#-------------------------------------
$!VarSet |ViewNum|  = 5
$!VarSet |ViewWid|  = 400
$!VarSet |ViewX|    = 3225
$!VarSet |ViewY|    = 1500
$!VarSet |ViewZ|    = 1025
$!VarSet |PsiAng|   = 70
$!VarSet |ThetaAng| = -125
$!VarSet |AlphaAng| = 0
#---
$!ThreeDView
  PSIAngle   = |PsiAng|
  ThetaAngle = |ThetaAng|
  AlphaAngle = |AlphaAng|
  ViewerPosition { X = |ViewX| Y = |ViewY| Z = |ViewZ| }
  ViewWidth = |ViewWid|
$!ThreeDAxis FrameAxis { Size = 4 XYPos { X =  4 Y =  4 } }

$!GlobalContour  1  Legend{IsVertical = No  RowSpacing = 1.0 XYPos { X = 92 Y = 14 }}
$!GlobalContour  2  Legend{IsVertical = No  RowSpacing = 1.0 XYPos { X = 92 Y = 14 }}
$!GlobalContour  3  Legend{IsVertical = No  RowSpacing = 1.0 XYPos { X = 92 Y = 14 }}

$!ActiveFieldMaps = [|BodyMaps|,|WingMaps|]

$!RedrawAll

# Create Cp contour plots
$!RUNMACROFUNCTION "ExportContours" ('Cp', |EnableStreamlines|,'|BodyMaps|,|WingMaps|','|OutputDirectoryPath||FilePrependLabel|_View|ViewNum|','Custom2','Custom2')

# Create Cf contour plots
$!RUNMACROFUNCTION "ExportContours" ('Cf', |EnableStreamlines|,'|BodyMaps|,|WingMaps|','|OutputDirectoryPath||FilePrependLabel|_View|ViewNum|','Custom2','Custom2')

# Create Cfx contour plots
$!RUNMACROFUNCTION "ExportContours" ('Cfx',|EnableStreamlines|,'|BodyMaps|,|WingMaps|','|OutputDirectoryPath||FilePrependLabel|_View|ViewNum|','Custom2','Custom2')
#===================================================================

#===================================================================
# View 6 - Wing tip view
#-------------------------------------
$!VarSet |ViewNum|  = 6
$!VarSet |ViewWid|  = 300
$!VarSet |ViewX|    = 2375
$!VarSet |ViewY|    = 1500
$!VarSet |ViewZ|    = 575
$!VarSet |PsiAng|   = 70
$!VarSet |ThetaAng| = -130
$!VarSet |AlphaAng| = 0
#---
$!ThreeDView
  PSIAngle   = |PsiAng|
  ThetaAngle = |ThetaAng|
  AlphaAngle = |AlphaAng|
  ViewerPosition { X = |ViewX| Y = |ViewY| Z = |ViewZ| }
  ViewWidth = |ViewWid|
$!ThreeDAxis FrameAxis { Size = 4 XYPos { X =  4 Y =  4 } }

$!GlobalContour  1  Legend{IsVertical = No  RowSpacing = 1.0 XYPos { X = 92 Y = 14 }}
$!GlobalContour  2  Legend{IsVertical = No  RowSpacing = 1.0 XYPos { X = 92 Y = 14 }}
$!GlobalContour  3  Legend{IsVertical = No  RowSpacing = 1.0 XYPos { X = 92 Y = 14 }}

$!ActiveFieldMaps = [|BodyMaps|,|WingMaps|]

$!RedrawAll

# Create Cp contour plots
$!RUNMACROFUNCTION "ExportContours" ('Cp', |EnableStreamlines|,'|BodyMaps|,|WingMaps|','|OutputDirectoryPath||FilePrependLabel|_View|ViewNum|','Custom2','Custom2')

# Create Cf contour plots
$!RUNMACROFUNCTION "ExportContours" ('Cf', |EnableStreamlines|,'|BodyMaps|,|WingMaps|','|OutputDirectoryPath||FilePrependLabel|_View|ViewNum|','Custom2','Custom2')

# Create Cfx contour plots
$!RUNMACROFUNCTION "ExportContours" ('Cfx',|EnableStreamlines|,'|BodyMaps|,|WingMaps|','|OutputDirectoryPath||FilePrependLabel|_View|ViewNum|','Custom2','Custom2')
#===================================================================

#===================================================================
# View 7 - Full config, 3/4 view rear
#-------------------------------------
$!VarSet |ViewNum|  = 7
$!VarSet |ViewWid|  = 1500
$!VarSet |ViewX|    = 4100
$!VarSet |ViewY|    = 1500
$!VarSet |ViewZ|    = 1600
$!VarSet |PsiAng|   = 65
$!VarSet |ThetaAng| = -115
$!VarSet |AlphaAng| = 0
#---
$!ThreeDView
  PSIAngle   = |PsiAng|
  ThetaAngle = |ThetaAng|
  AlphaAngle = |AlphaAng|
  ViewerPosition { X = |ViewX| Y = |ViewY| Z = |ViewZ| }
  ViewWidth = |ViewWid|
$!ThreeDAxis FrameAxis { Size = 4 XYPos { X =  4 Y =  4 } }

$!GlobalContour  1  Legend{IsVertical = No  RowSpacing = 1.0 XYPos { X = 92 Y = 14 }}
$!GlobalContour  2  Legend{IsVertical = No  RowSpacing = 1.0 XYPos { X = 92 Y = 14 }}
$!GlobalContour  3  Legend{IsVertical = No  RowSpacing = 1.0 XYPos { X = 92 Y = 14 }}

$!ActiveFieldMaps = [|BodyMaps|,|WingMaps|]

$!RedrawAll

# Create Cp contour plots
$!RUNMACROFUNCTION "ExportContours" ('Cp', |EnableStreamlines|,'|BodyMaps|,|WingMaps|','|OutputDirectoryPath||FilePrependLabel|_View|ViewNum|','Custom2','Black')

# Create Cf contour plots
$!RUNMACROFUNCTION "ExportContours" ('Cf', |EnableStreamlines|,'|BodyMaps|,|WingMaps|','|OutputDirectoryPath||FilePrependLabel|_View|ViewNum|','Custom2','Black')

# Create Cfx contour plots
$!RUNMACROFUNCTION "ExportContours" ('Cfx',|EnableStreamlines|,'|BodyMaps|,|WingMaps|','|OutputDirectoryPath||FilePrependLabel|_View|ViewNum|','Custom2','Black')
#===================================================================

#===================================================================
# View 8 - Full config, 3/4 view front
#-------------------------------------
$!VarSet |ViewNum|  = 8
$!VarSet |ViewWid|  = 2200
$!VarSet |ViewX|    = -200
$!VarSet |ViewY|    = 1500
$!VarSet |ViewZ|    = 2500
$!VarSet |PsiAng|   = 40
$!VarSet |ThetaAng| = 130
$!VarSet |AlphaAng| = 5
#---
$!ThreeDView
  PSIAngle   = |PsiAng|
  ThetaAngle = |ThetaAng|
  AlphaAngle = |AlphaAng|
  ViewerPosition { X = |ViewX| Y = |ViewY| Z = |ViewZ| }
  ViewWidth = |ViewWid|
$!ThreeDAxis FrameAxis { Size = 4 XYPos { X =  4 Y =  4 } }

$!GlobalContour  1  Legend{IsVertical = No  RowSpacing = 1.0 XYPos { X = 92 Y = 14 }}
$!GlobalContour  2  Legend{IsVertical = No  RowSpacing = 1.0 XYPos { X = 92 Y = 14 }}
$!GlobalContour  3  Legend{IsVertical = No  RowSpacing = 1.0 XYPos { X = 92 Y = 14 }}

$!ActiveFieldMaps = [|BodyMaps|,|WingMaps|]

$!RedrawAll

# Create Cp contour plots
$!RUNMACROFUNCTION "ExportContours" ('Cp', |EnableStreamlines|,'|BodyMaps|,|WingMaps|','|OutputDirectoryPath||FilePrependLabel|_View|ViewNum|','Custom2','Black')

# Create Cf contour plots
$!RUNMACROFUNCTION "ExportContours" ('Cf', |EnableStreamlines|,'|BodyMaps|,|WingMaps|','|OutputDirectoryPath||FilePrependLabel|_View|ViewNum|','Custom2','Black')

# Create Cfx contour plots
$!RUNMACROFUNCTION "ExportContours" ('Cfx',|EnableStreamlines|,'|BodyMaps|,|WingMaps|','|OutputDirectoryPath||FilePrependLabel|_View|ViewNum|','Custom2','Black')
#===================================================================
