#!MC 1410
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#   DPW-8/AePW-4 BOUNDARY LAYER PROFILE EXTRACTOR (Version 1 - August 27, 2025)
#      To BE USED WITH:
#          DPW8-AePW4_Profiles_v1.dat
#
#       INSTRUCTIONS:
#                  1.   Load surface and volume data into Tecplot
#                  2.   Assign ParticipantID    variable  in as the identifier of the dataset
#                  3.   Assign OutputFileName   variable  to the path where you would like the data
#                  4.   Assign (Xvar,Yvar,Zvar) variables to the variable number in dataset (typically 1,2,3)
#                  5.   Assign Mvar             variable  to the variable number in dataset
#                  6.   Assign CPvar            variable  to the variable number in dataset (if it exists)
#                  7.   Assign MRMSvar          variable  to the variable number in dataset (if it exists); Mach root-mean-square
#                  8.   Assign CPRMSvar         variable  to the variable number in dataset (if it exists); CP   root-mean-square
#                  9.   Assign WingMaps         variable  to define which zones define the wing surface
#                          - You must specify wing surface zone(s)
#                          - You may need to extract a Mach=0 isosurface or k=1 index prior to executing this macro
#                 10.   Assign PlotTime         variable (if multiple time steps are included in dataset)
#                          - Set to 999999 if only one time step is loaded into the Tecplot session
#                 11.   Assemble boundary-layer profile data from one solution into data form DPW8-AePW4_Profiles_v1.dat
#                          - You will have one data file for each solution
#                 12.   Data can be read in any unit or vehicle scale; all coordinates are transformed to full-scale, inches
#
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
$!DrawGraphics False

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#
#            USER CUSTOM READ DATA COMMAND
#            o Go To Scripting --> Record Macro
#               - Manually read your dataset
#               - Calculate M and CP, if needed, through one of these two methods
#                    Data --> Alter --> Specify Equations
#                    Analyze --> Calculate Variables
#               - Stop recording
#            o Copy the resulting macro command here
#            o Note the required variables for entry below (variable numbers, maps, etc.)
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

$!VarSet |ParticipantID|  = '001.01'       # Participant ID for this data set
$!VarSet |OutputFileName| = 'profiles.dat' # File name

$!VarSet |DescriptorText| = 'ALPHA K.KK - GRID L' # Text prepended in the resulting zone names

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#
#            PLOT TITLE SOLUTION INFORMATION
#
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#
$!VarSet |Xvar|      =  X    # Variable number to use for X coordinate (running from fuselage nose to tail)
$!VarSet |Yvar|      =  X    # Variable number to use for Y coordinate (running from symmetry plane to wing tip)
$!VarSet |Zvar|      =  X    # Variable number to use for Z coordinate (running from fuselage keel to crown)
$!VarSet |Mvar|      =  X    # Variable number to use for Mach number
$!VarSet |CPvar|     =  X    # Variable number to use for Cp, if available; use '' if not available
$!VarSet |MRMSvar|   =  ''   # Variable number to use for Mach number root mean square, if available; use '' if not available
$!VarSet |CPRMSvar|  =  ''   # Variable number to use for Cp root mean square, if available; use '' if not available

$!VarSet |IBlankvar| =  ''   # Variable number to use for blanking (for overset grids... do not surround the value with '')
$!VarSet |IBlankval| =  ''   # Value           to use for blanking (for overset grids... probably 0... do not surround the value with '')

$!VarSet |WingMaps|  = 'X'   # Zone numbers for the wing surface          ('1','1-2','1,3,5-6',etc.)
$!VarSet |VolMaps|   = 'X'   # Zone numbers for the volume                ('1','1-2','1,3,5-6',etc.)
$!VarSet |PlotTime|  = ''    # Note: Use |PlotTime| == '' if no solution time needs to be set.

$!VarSet |Xrev|      =  0    # Set to 1 only if X-axis is running from fuselage tail to nose (negative drag direction)
$!VarSet |Yrev|      =  0    # Set to 1 only if Y-axis is running from wing tip to the symmetry plane
$!VarSet |Zrev|      =  0    # Set to 1 only if Z-axis is running from fuselage crown to keel (negative lift direction)


#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#
# ! ! ! E N D   O F   U S E R   I N P U T ! ! !
#
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


$!VarSet |Debugger|    =  0 # UNIX-based system commands
$!VarSet |DebuggerPng| =  0 # Export pngs of cut locations (inside png/*)

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
  Height = 6
$!FrameName  = 'Frame 001'

$!PlotType = Cartesian3D

$!ThreeDAxis
  AspectRatioLimit = 25
  BoxAspectRatioLimit = 25
  XDetail { VarNum = |Xvar| ShowAxis = No RangeMin = 0.0 RangeMax = 1.0 GRSpacing = 10 AxisLine { Edge = 2 } }
  YDetail { VarNum = |Yvar| ShowAxis = No RangeMin = 0.0 RangeMax = 1.0 GRSpacing = 10 AxisLine { Edge = 3 } }
  ZDetail { VarNum = |Zvar| ShowAxis = No RangeMin = 0.0 RangeMax = 1.0 GRSpacing =  5 AxisLine { Edge = 2 } }
  AxisMode = XYZDepEndent
  XYDepXToYRatio = 1
  DepXToYRatio = 1
  DepXToZRatio = 1
  EdgeautoReset = Yes

$!GlobalRGB
  RedChannelVar = 3
  GreenChannelVar = 3
  BlueChannelVar = 3
  RangeMin = 0
  RangeMax = 1

$!Interface ZoneBoundingBoxMode = Off

$!ThreeDView
  PsiAngle = 60
  ThetaAngle = 130
  AlphaAngle = 15
$!View Fit


#===================================================================
# Populate variables and standardize variable names
#===================================================================
$!VarSet |TotalZones|      =   |NUMZONES|
$!VarSet |FirstProfile|    = ( |NUMZONES| + 1 )
$!VarSet |FirstProfileAll| =   |NUMZONES|

$!RenameDataSetVar
  Var = |Xvar|
  Name = 'X'
$!RenameDataSetVar
  Var = |Yvar|
  Name = 'Y'
$!RenameDataSetVar
  Var = |Zvar|
  Name = 'Z'
$!If "|CPvar|" == ""
  $!AlterData Equation  = "{CP} = -999"
  $!VarSet |CPvar|      = "|NUMVARS|"
$!EndIf
$!If "|Mvar|" == ""
  # Mach is required
  $!AlterData Equation = "{M} = -999"
  $!VarSet |Mvar|      = "|NUMVARS|"
  $!Quit
$!EndIf
$!If "|CPRMSvar|" == ""
  $!AlterData Equation  = "{CP_RMS} = -999"
  $!VarSet |CPRMSvar|   = "|NUMVARS|"
$!EndIf
$!If "|MRMSvar|" == ""
  $!AlterData Equation = "{M_RMS} = -999"
  $!VarSet |MRMSvar|      = "|NUMVARS|"
$!EndIf

$!If "|IBlankvar|" == ""
  # Nothing
  $!AlterData
    Equation = '{IBlank} = 999'
$!Else
  $!RenameDataSetVar
    Var = |IBlankvar|
    Name = 'IBlank'
$!EndIf

$!RenameDataSetVar
  Var = |Mvar|
  Name = 'Mach'
$!RenameDataSetVar
  Var = |CPvar|
  Name = 'CP'
$!RenameDataSetVar
  Var = |MRMSvar|
  Name = 'Mach_RMS'
$!RenameDataSetVar
  Var = |CPRMSvar|
  Name = 'CP_RMS'


#===================================================================
# Scaling/Translating Dataset (wind tunnel/metric->inches/etc.)
#===================================================================
# Reverse coordinate axes, if required by user input
#-------------------------------------
$!If |Xrev| == 1
  $!AlterData
    Equation = '{X} = -{X}'
$!EndIf
$!If |Yrev| == 1
  $!AlterData
    Equation = '{Y} = -{Y}'
$!EndIf
$!If |Zrev| == 1
  $!AlterData
    Equation = '{Z} = -{Z}'
$!EndIf

# Calculate scaling based on grid coordinate ranges... put tip at y=1156.75, regardless of the underlying loft
#-------------------------------------
$!ActiveFieldMaps = [|WingMaps|]
#$!Pause 'Xrange = (|MINX%.12f|,|MAXX%.12f|)\nYrange = (|MINY%.12f|,|MAXY%.12f|)\nZrange = (|MINZ%.12f|,|MAXZ%.12f|)'
$!VarSet |Scale|  = (|MAXY%.12f|)

$!AlterData
  Equation = '{X} = {X} / |Scale| * 1156.75'
$!AlterData
  Equation = '{Y} = {Y} / |Scale| * 1156.75'
$!AlterData
  Equation = '{Z} = {Z} / |Scale| * 1176.75'
#$!Pause 'Xrange = (|MINX%.12f|,|MAXX%.12f|)\nYrange = (|MINY%.12f|,|MAXY%.12f|)\nZrange = (|MINZ%.12f|,|MAXZ%.12f|)'

# Store for later processing and whatnot
$!AlterData
  Equation = '{XOrig} = {X}'
$!VarSet |XOrigvar| = |NUMVARS|
$!AlterData
  Equation = '{YOrig} = {Y}'
$!VarSet |YOrigvar| = |NUMVARS|
$!AlterData
  Equation = '{ZOrig} = {Z}'
$!VarSet |ZOrigvar| = |NUMVARS|


$!Blanking Value{Constraint 1 {Include = No }}
$!Blanking Value{Constraint 2 {Include = No }}
$!Blanking Value{Constraint 3 {Include = No }}
$!Blanking Value{Constraint 4 {Include = No }}
$!Blanking Value{Constraint 5 {Include = No }}
$!Blanking Value{Constraint 6 {Include = No }}
$!Blanking Value{Constraint 7 {Include = No }}
$!Blanking Value{Constraint 8 {Include = No }}

$!ExtEndedCommand
  CommandProcessorID = 'CFDAnalyzer4'
  Command = 'Calculate Function=\'GRIDKUNITNormal\' Normalization=\'None\' ValueLocation=\'CellCentered\' CalculateOnDemand=\'T\' UseMorePointsForFEGradientCalculations=\'F\''
$!VarSet |XNormvar| = ( |NUMVARS| - 2 )
$!VarSet |YNormvar| = ( |NUMVARS| - 1 )
$!VarSet |ZNormvar| = ( |NUMVARS|     )

$!ExtendedCommand 
  CommandProcessorID = 'CFDAnalyzer4'
  Command = 'Calculate Function=\'CELLVOLUME\' Normalization=\'None\' ValueLocation=\'Nodal\' CalculateOnDemand=\'T\' UseMorePointsForFEGradientCalculations=\'F\''
$!RenameDataSetVar 
  Var = 'Cell Volume'
  Name = 'Volume'
$!VarSet |VolumeOrigvar| = |NUMVARS|


#===================================================================
#Create Macro Function: ProfileCutter... tuned to operate at a constant y station, but can be easily generalized
#===================================================================
$!MACROFUNCTION
  Name = "ProfileCutter"

  $!VarSet |EtaStationFull| = ( |2|/1176.75 )
  $!VarSet |EtaStation| = ( floor(|EtaStationFull|*10000) / 10000 )

  $!If |OPSYS| == 1
    # UNIX or UNIX-like
    $!System "printf '\nEta %.4f...\n   Identifying key points...' |EtaStation|"
  $!EndIf
  
  $!ActiveFieldMaps = [|WingMaps|]

  # Extract surface slice to get the x/c mapping
  $!ExtractSliceToZones
    Origin {X = |1| Y = |2| Z = |3|}
    Normal {X = 0   Y = 1   Z = 0  }
    AutoStrandTransientData = Yes
    CopyCellCenteredValues = No
    ExtractMode = SingleZone
    Resulting1DZoneType = IOrderedIfPossible
    SliceSource = SurfaceZones
    SliceSurface = YPlanes
    TransientOperationMode = SingleSolutionTime
  
  $!VarSet |SurfaceSliceZone|  = "|NUMZONES|"
  $!RenameDataSetZone
    Zone = |NUMZONES|
    Name = 'Surface - y=|1|'

  $!FieldMap [1-|NUMZONES|]  Mesh{Show = No}
  $!FieldMap [  |NUMZONES|]  Mesh{Show = Yes Color = Black LineThickness = 0.4}

  $!FieldLayers ShowMesh = Yes

  $!ThreeDView PsiAngle = 0
  $!ThreeDView ThetaAngle = 0
  $!ThreeDView AlphaAngle = 0
  $!GlobalThreeD
    LightSource
      {
      XYZDirection{ X = 0.65 Y = -0.35 Z = 0.65 }
      Intensity = 75
      BackgroundLight = 25
      IncludeSpecular = Yes
      SpecularIntensity = 40
      SpecularShininess = 60
      }
  $!View Fit
  $!RedrawAll
 #$!Pause 'Eta |EtaStation|'


  #===================================================================
  # Shift surface cut to origin and scale to get the closest index
  #-------------------------------------
  # Get X2 (trailing edge)... need X2 before finding X1
  $!ActiveFieldMaps = [|SurfaceSliceZone|]
  $!VarSet |X2| = -99999
  $!Loop |MaxI|
    $!GetFieldValue |CurrX|
      Zone  = |SurfaceSliceZone|
      Var   = |Xvar|
      Index = |LOOP|

    $!GetFieldValue |CurrY|
      Zone  = |SurfaceSliceZone|
      Var   = |Yvar|
      Index = |LOOP|

    $!GetFieldValue |CurrZ|
      Zone  = |SurfaceSliceZone|
      Var   = |Zvar|
      Index = |LOOP|

    # Seeking X2 (trailing edge)
    $!If |CurrX| > |X2|
      $!VarSet |I2| = |LOOP|
      $!VarSet |X2| = |CurrX|
      $!VarSet |Y2| = |CurrY|
      $!VarSet |Z2| = |CurrZ|
        $!If |Debugger| == 1
          $!System "printf 'X2...  %6i: (%.4f,  %.4f,  %.4f)\n' |LOOP| |CurrX| |CurrY| |CurrZ|"
        $!EndIf
    $!EndIf
  $!EndLoop # Find X2

  # Now find X1 (leading edge)
  $!ActiveFieldMaps = [|SurfaceSliceZone|]
  $!VarSet |D1| = -999999
  $!Loop |MaxI|
    $!GetFieldValue |CurrX|
      Zone  = |SurfaceSliceZone|
      Var   = |Xvar|
      Index = |LOOP|

    $!GetFieldValue |CurrY|
      Zone  = |SurfaceSliceZone|
      Var   = |Yvar|
      Index = |LOOP|

    $!GetFieldValue |CurrZ|
      Zone  = |SurfaceSliceZone|
      Var   = |Zvar|
      Index = |LOOP|

    # Distance from target
    $!VarSet |CurrDSquared| = ( (|X2|-|CurrX|)**2 + (|Y2|-|CurrY|)**2 + (|Z2|-|CurrZ|)**2 )
    $!VarSet |CurrD|  = ( sqrt(|CurrDSquared|) )
    
    $!If |Debugger| == 1
      $!System "printf '  CurrD...  %.8f\n' |CurrD|"
    $!EndIf

    $!If |CurrD| > |D1|
      $!VarSet |I1| = |LOOP|
      $!VarSet |X1| = |CurrX|
      $!VarSet |Y1| = |CurrY|
      $!VarSet |Z1| = |CurrZ|
      $!VarSet |D1| = |CurrD|
      $!If |Debugger| == 1
        $!System "printf 'X1...  %6i: (%.4f,  %.4f,  %.4f)    %.1f\n' |LOOP| |CurrX| |CurrY| |CurrZ| |CurrD|"
      $!EndIf
    $!EndIf
  $!EndLoop # Find X1
  
  $!If |OPSYS| == 1
    # UNIX or UNIX-like
    $!System "printf '   Success! Leading and trailing edge points found\n'"
    $!System "printf '   Preparing and extracting volume slice...\n'"
  $!EndIf

  $!If |Debugger| == 1
    $!System "printf 'Index %4i: (x1, y1, z1) (%.4f,  %.4f,  %.4f)\n' |I1| |X1| |Y1| |Z1|"
    $!System "printf 'Index %4i: (x2, y2, z2) (%.4f,  %.4f,  %.4f)\n' |I2| |X2| |Y2| |Z2|"
  $!EndIf
  
  # Shift LE to origin
  $!VarSet |DeltaX| = ( |X2| - |X1| )
  $!VarSet |DeltaY| = ( |Y2| - |Y1| )
  $!VarSet |DeltaZ| = ( |Z2| - |Z1| )

  $!AlterData  [|SurfaceSliceZone|] Equation = '{X} = {X} - |X1|'
  $!AlterData  [|SurfaceSliceZone|] Equation = '{Y} = {Y} - |Y1|'
  $!AlterData  [|SurfaceSliceZone|] Equation = '{Z} = {Z} - |Z1|'

  # Remove sectional twist
  $!VarSet |TangentValue| = ( |DeltaZ| / |DeltaX|  )
  $!VarSet |AlphaSecRad|  = ( atan(|TangentValue|) )
  $!VarSet |AlphaSecDeg|  = ( |AlphaSecRad| * 180 / 3.14159265 )

  $!RotateData
    ZoneList =  [|SurfaceSliceZone|]
    Angle = |AlphaSecDeg|
    XVar = 'X'
    YVar = 'Y'
    ZVar = 'Z'
    OriginX = 0
    OriginY = 0
    OriginZ = 0
    NormalX = 0
    NormalY = 1
    NormalZ = 0

  $!ActiveFieldMaps = [|SurfaceSliceZone|]
  $!VarSet |X2New|  = ( |MAXX%.12f| )

  $!VarSet |C| = ( |X2New|)
  $!AlterData  [|SurfaceSliceZone|] Equation = '{X} = {X} / |C|'
  $!AlterData  [|SurfaceSliceZone|] Equation = '{Y} = {Y} / |C|'
  $!AlterData  [|SurfaceSliceZone|] Equation = '{Z} = {Z} / |C|'

  $!FieldMap [1-|NUMZONES|] Scatter{Show = No}
  $!FieldMap [|NUMZONES|]   Mesh   {Show = Yes}
  $!FieldLayers ShowMesh = Yes


  #===================================================================
  # Get coordinates and info at each target x/c value
  #-------------------------------------
  $!If |4| < 1
    # Hand work
    $!VarSet |NumXoCs| = 1
  $!Else
    $!VarSet |NumXoCs| = |4|
  $!EndIf
  $!If |Debugger| == 1
    $!System "printf 'Number of x/cs: %i\n' |NumXoCs|"
  $!EndIf
  
  $!VarSet |LOOPxoc|   = 0
  $!VarSet |FirstTime| = 1 # Only extract volume the first time
  $!Loop |NumXoCs|
    $!VarSet |LOOPxoc|   = ( |LOOPxoc| + 1 )
    $!VarSet |LoopM1|    = ( |LOOPxoc| - 1 )
    $!VarSet |XoCTarget| = ( |LoopM1| / |NumXoCs| )
    $!If |4| < 1
      # Hand work
      $!VarSet |XoCTarget| = |4|
    $!EndIf      
    
    $!If |OPSYS| == 1
      # UNIX or UNIX-like
      $!If |FirstTime| == 1
        # Nothing
      $!Else
        $!System "printf '   x/c = %.4f\n' |XoCTarget|"
      $!EndIf
    $!EndIf
   #$!Pause 'Searching for x/c= |XoCTarget|'
    
    # Find X3 (US) and X4 (LS)... store if it's the nearest to target x/c
    $!VarSet |DXoCus| =  999999
    $!VarSet |DXoCls| =  999999

    $!ActiveFieldMaps = [|SurfaceSliceZone|]
    $!VarSet |LOOPpoint|    = ( 0 )
    $!Loop |MaxI|
      $!VarSet |LOOPpoint|  = ( |LOOPpoint| + 1 )
      $!GetFieldValue |CurrX|
        Zone  = |SurfaceSliceZone|
        Var   = |Xvar|
        Index = |LOOPpoint|

      $!GetFieldValue |CurrY|
        Zone  = |SurfaceSliceZone|
        Var   = |Yvar|
        Index = |LOOPpoint|

      $!GetFieldValue |CurrZ|
        Zone  = |SurfaceSliceZone|
        Var   = |Zvar|
        Index = |LOOPpoint|

      # Find the upper surface
      # This includes some hand modifications for the CRM airfoil to account for
      # the reflexed lower surface
      $!VarSet |ZToBlank| = 0.00
      $!If |XoCTarget| > 0.80
        $!VarSet |ZToBlank| = 0.0075
      $!EndIf
      $!If |XoCTarget| > 0.945
        $!VarSet |ZToBlank| = 0.007
      $!EndIf
      $!If |XoCTarget| > 0.95
        $!VarSet |ZToBlank| = 0.0067
      $!EndIf

      # Get X3 (upper surface closest point)
      $!If |CurrZ| >= |ZToBlank|
        # Upper surface... how close to the target x/c?
        $!VarSet |DeltaNow| = ( abs(|CurrX|-|XoCTarget|) )
        
        $!If |DeltaNow| < |DXoCus|
          $!VarSet |I3|     = |LOOPpoint|
          $!VarSet |X3|     = |CurrX|
          $!VarSet |Y3|     = |CurrY|
          $!VarSet |Z3|     = |CurrZ|
          $!VarSet |DXoCus| = |DeltaNow|
          $!If |Debugger| == 1
            $!System "printf 'Upper x/c %.2f...  Distance of %.8f... Index %3i   (%.4f, %.4f, %.4f)\n' |XoCTarget| |DeltaNow| |I3| |X3| |Y3| |Z3|"
          $!EndIf
        $!EndIf # Closer?
      $!EndIf # Upper Surface?

      # Get X4 (lower surface closest point)
      $!If |CurrZ| < |ZToBlank|
        # Lower surface... how close to the target x/c?
        $!VarSet |DeltaNow| = ( abs(|CurrX|-|XoCTarget|) )
        $!If |DeltaNow| < |DXoCls|
          $!VarSet |I4|     = |LOOPpoint|
          $!VarSet |X4|     = |CurrX|
          $!VarSet |Y4|     = |CurrY|
          $!VarSet |Z4|     = |CurrZ|
          $!VarSet |DXoCls| = |DeltaNow|
          $!If |Debugger| == 1
            $!System "printf 'Lower x/c %.2f...  Distance of %.8f... Index %3i   (%.4f, %.4f, %.4f)\n' |XoCTarget| |DeltaNow| |I4| |X4| |Y4| |Z4|"
          $!EndIf
        $!EndIf # Closer?
      $!EndIf # Lower surface?
    $!EndLoop # Checking each point index to get index of closest point on both US and LS

    # Careful treatment of the leading edge
    $!If |XoCTarget| == 0
      $!If |X3| < |X4|
        $!VarSet |I4| = |I3|
        $!VarSet |X4| = |X3|
        $!VarSet |Y4| = |Y3|
        $!VarSet |Z4| = |Z3|
      $!Else
        $!VarSet |I3| = |I4|
        $!VarSet |X3| = |X4|
        $!VarSet |Y3| = |Y4|
        $!VarSet |Z3| = |Z4|
      $!EndIf
    $!EndIf

    $!VarSet |X3Nice| = ( floor(|X3|*10000) / 10000 )
    $!VarSet |X4Nice| = ( floor(|X4|*10000) / 10000 )

    # Show airfoil profile with key points
    $!DrawGraphics False

    $!CreateNewFrame XYPos { X = 1.0 Y = 6.25 } Width = 9 Height = 2.0
    $!FrameControl ActivateByNumber
      Frame = 2
    $!FrameLayout ShowHeader = No
    $!PlotType = XYLine

    $!DeleteLineMaps
    $!CreateLineMap
    $!LineMap [1]  Name = 'Airfoil'
    $!LineMap [1]  Assign{XAxisVar = 'X' YAxisVar = 'Z' Zone = |SurfaceSliceZone|}
    $!LineMap [1]  Lines{LineThickness = 1.2}
    $!LineMap [1]  Symbols{Show = No Size = 2 FillMode = UseLineColor}
    $!XYLineAxis ViewportPosition{X1 = 10 X2 = 95 Y1 = 10 Y2 = 97 }

    $!XYLineAxis XDetail 1 {RangeMin = -0.01 RangeMax = 1.01 Gridlines{Show = Yes} Title{ShowOnAxisLine = No} TickLabel{TextShape{SizeUnits = Point Height = 14}} Gridlines{LinePattern = Solid} Gridlines{PatternLength = 0.2} }
    $!XYLineAxis YDetail 1 {RangeMin = -0.09 RangeMax = 0.07 Gridlines{Show = Yes} Title{ShowOnAxisLine = No} TickLabel{TextShape{SizeUnits = Point Height = 14}} Gridlines{LinePattern = Solid} Gridlines{PatternLength = 0.2} }

    $!CreateLineMap
    $!DuplicateLineMap
      SourceMap = 1
      DestinationMap = 2
    $!CreateLineMap
    $!DuplicateLineMap
      SourceMap = 1
      DestinationMap = 3
    $!DuplicateLineMap
      SourceMap = 1
      DestinationMap = 4
    $!DuplicateLineMap
      SourceMap = 1
      DestinationMap = 5

    $!LineMap [1]  Symbols{Show = Yes Color = Red   SymbolShape{GeomShape = Circle} Size = 0.5}
    $!LineMap [2]  Symbols{Show = Yes Color = Green SymbolShape{GeomShape = Square}}
    $!LineMap [3]  Symbols{Show = Yes Color = Blue  SymbolShape{GeomShape = Diamond}}
    $!LineMap [4]  Symbols{Show = Yes Color = Black SymbolShape{GeomShape = Del}}
    $!LineMap [5]  Symbols{Show = Yes Color = Black SymbolShape{GeomShape = Grad}}

    $!LineMap [2]  Indices{IRange{Min = |I1| Max = |I1|}}
    $!LineMap [3]  Indices{IRange{Min = |I2| Max = |I2|}}
    $!LineMap [4]  Indices{IRange{Min = |I3| Max = |I3|}}
    $!LineMap [5]  Indices{IRange{Min = |I4| Max = |I4|}}

    $!ActiveLineMaps = [1-|NUMLINEMAPS|]
    $!LinePlotLayers ShowLines = Yes
    $!LinePlotLayers ShowSymbols = Yes

    # Get full-scale coordinates and normals
    $!FrameControl ActivateByNumber
      Frame = 1
    
    # LE and TE, no normals
    $!GetFieldValue |X1orig|
      Zone  = |SurfaceSliceZone|
      Var   = |XOrigvar|
      Index = |I1|

    $!GetFieldValue |Y1orig|
      Zone  = |SurfaceSliceZone|
      Var   = |YOrigvar|
      Index = |I1|

    $!GetFieldValue |Z1orig|
      Zone  = |SurfaceSliceZone|
      Var   = |ZOrigvar|
      Index = |I1|
    
    $!GetFieldValue |X2orig|
      Zone  = |SurfaceSliceZone|
      Var   = |XOrigvar|
      Index = |I2|

    $!GetFieldValue |Y2orig|
      Zone  = |SurfaceSliceZone|
      Var   = |YOrigvar|
      Index = |I2|

    $!GetFieldValue |Z2orig|
      Zone  = |SurfaceSliceZone|
      Var   = |ZOrigvar|
      Index = |I2|
    
    
    # With normals
    $!GetFieldValue |X3orig|
      Zone  = |SurfaceSliceZone|
      Var   = |XOrigvar|
      Index = |I3|

    $!GetFieldValue |Y3orig|
      Zone  = |SurfaceSliceZone|
      Var   = |YOrigvar|
      Index = |I3|

    $!GetFieldValue |Z3orig|
      Zone  = |SurfaceSliceZone|
      Var   = |ZOrigvar|
      Index = |I3|

    $!GetFieldValue |X3normorig|
      Zone  = |SurfaceSliceZone|
      Var   = |XNormvar|
      Index = |I3|

    $!GetFieldValue |Y3normorig|
      Zone  = |SurfaceSliceZone|
      Var   = |YNormvar|
      Index = |I3|

    $!GetFieldValue |Z3normorig|
      Zone  = |SurfaceSliceZone|
      Var   = |ZNormvar|
      Index = |I3|

    # X4
    $!GetFieldValue |X4orig|
      Zone  = |SurfaceSliceZone|
      Var   = |XOrigvar|
      Index = |I4|

    $!GetFieldValue |Y4orig|
      Zone  = |SurfaceSliceZone|
      Var   = |YOrigvar|
      Index = |I4|

    $!GetFieldValue |Z4orig|
      Zone  = |SurfaceSliceZone|
      Var   = |ZOrigvar|
      Index = |I4|

    $!GetFieldValue |X4normorig|
      Zone  = |SurfaceSliceZone|
      Var   = |XNormvar|
      Index = |I4|

    $!GetFieldValue |Y4normorig|
      Zone  = |SurfaceSliceZone|
      Var   = |YNormvar|
      Index = |I4|

    $!GetFieldValue |Z4normorig|
      Zone  = |SurfaceSliceZone|
      Var   = |ZNormvar|
      Index = |I4|

    $!FrameControl ActivateByNumber
      Frame = 2
    $!DrawGraphics True
    $!RedrawAll
    
    $!VarSet |X3OrigNice| = ( floor(|X3Orig|*10) / 10 )
    $!VarSet |Y3OrigNice| = ( floor(|Y3Orig|*10) / 10 )
    $!VarSet |Z3OrigNice| = ( floor(|Z3Orig|*10) / 10 )
    $!VarSet |X4OrigNice| = ( floor(|X4Orig|*10) / 10 )
    $!VarSet |Y4OrigNice| = ( floor(|Y4Orig|*10) / 10 )
    $!VarSet |Z4OrigNice| = ( floor(|Z4Orig|*10) / 10 )

    $!AttachText
      AnchorPos { X = 1 Y = 99}
      TextShape { IsBold = No Height = 9 }
      Box { BoxType = Filled }
      Anchor = HeadLeft
      Text = 'Eta: |EtaStation|'
    $!AttachText
      AnchorPos { X = 99 Y = 99}
      TextShape { IsBold = No Height = 9 }
      Box { BoxType = Filled }
      Anchor = HeadRight
      Text = 'US: |X3Nice|\n(|X3OrigNice|,  |Y3OrigNice|,  |Z3OrigNice|)\n(|X3|, |Y3|, |Z3|) at |I3|'
    $!AttachText
      AnchorPos { X = 99 Y =   1}
      TextShape { IsBold = No Height = 9 }
      Box { BoxType = Filled }
      Anchor = Right
      Text = 'LS: |X4Nice|\n(|X4OrigNice|,  |Y4OrigNice|,  |Z4OrigNice|)\n(|X4|, |Y4|, |Z4|) at |I4|'

    $!FrameControl ActivateByNumber
      Frame = 1
    
    $!If |Debugger| == 1
      $!VarSet |LpkCounter| = ( 1 )
      $!SaveLayout  "step|LpkCounter|.lpk"
        IncludeData = Yes
        IncludePreview = No
    $!EndIf
   #$!Pause 'Key points found'


    #===================================================================
    # Extract volume slice, including blanking
    #-------------------------------------
    $!ActiveFieldMaps = [|VolMaps|]
    # Only run for the first x/c to save time
    $!If |FirstTime| == 1
      # Set up space blanking so I don't pull out the entire volume... based on X1, X2, X3, and X4
      $!VarSet |XBlank1| = ( |X1Orig| - 0.25*|C| )
      $!VarSet |XBlank2| = ( |X2Orig| + 0.25*|C| )
      $!VarSet |ZBlank1| = ( |Z3Orig| + 0.25*|C| )
      $!VarSet |ZBlank2| = ( |Z4Orig| - 0.25*|C| )
  
      $!Blanking Value{Include = Yes}
      $!Blanking Value{Constraint 1 {Include = Yes VarA = 'Z' Include = Yes RelOp = GreaterThan ValueCutoff = |ZBlank1|}}
      $!Blanking Value{Constraint 2 {Include = Yes VarA = 'Z' Include = Yes RelOp = LessThan    ValueCutoff = |ZBlank2|}}
      $!Blanking Value{Constraint 3 {Include = Yes VarA = 'X' Include = Yes RelOp = LessThan    ValueCutoff = |XBlank1|}}
      $!Blanking Value{Constraint 4 {Include = Yes VarA = 'X' Include = Yes RelOp = GreaterThan ValueCutoff = |XBlank2|}}
      $!Blanking Value{Constraint 5 {Include = No }}
      $!Blanking Value{Constraint 6 {Include = No }}
      $!Blanking Value{Constraint 7 {Include = No }}
      $!Blanking Value{Constraint 8 {Include = No }}
      
      # Apply blanking if overset... override previous batch setup a few lines above
      $!If "|IBlankvar|" != ""
        # Need cell-based blanking... probably for overset
        $!Blanking Value{Constraint 8 {Include = Yes VarA = 'IBlank' Include = Yes RelOp = EqualTo ValueCutoff = |IBlankval|}}
      $!EndIf
      
      $!If |Debugger| == 1
        $!VarSet |LpkCounter| = ( |LpkCounter| + 1 )
        $!SaveLayout  "step|LpkCounter|.lpk"
          IncludeData = Yes
          IncludePreview = No
      $!EndIf

      $!ExtractSliceToZones
        Origin {X = |1| Y = |2| Z = |3|}
        Normal {X = 0   Y = 1   Z = 0  }
        AutoStrandTransientData = Yes
        CopyCellCenteredValues = No
        ExtractMode = SingleZone
        SliceSource = VolumeZones
        SliceSurface = YPlanes
        TransientOperationMode = SingleSolutionTime
      $!VarSet |VolumeSliceZone|  = |NUMZONES|
      $!RenameDataSetZone
        Zone = |NUMZONES|
        Name = 'Volume - y=|1|'
      $!VarSet |FirstTime| = 0
      
      $!If |OPSYS| == 1
        # UNIX or UNIX-like
        $!If |4| < 1
          $!System "printf '   x/c = %.4f\n' |XoCTarget|"
        $!Else
          $!System "printf '   x/c = 0.0000\n'"
        $!EndIf
      $!EndIf
      
      $!ActiveFieldMaps = [|VolumeSliceZone|]
      $!ThreeDView PsiAngle = 90
      $!ThreeDView ThetaAngle = 0
      $!ThreeDView AlphaAngle = 0
      $!View FitSurfaces
        ConsiderBlanking = Yes
      $!RedrawAll

      $!If |Debugger| == 1
        $!VarSet |LpkCounter| = ( |LpkCounter| + 1 )
        $!SaveLayout  "step|LpkCounter|.lpk"
          IncludeData = Yes
          IncludePreview = No
        $!EndIf
    $!EndIf # Extract volume slice if the first x/c for this eta
    
    
    #===================================================================
    # Extract upper surface profile
    #-------------------------------------
    $!ActiveFieldMaps = [|VolumeSliceZone|]
    
    # Set up blanking to pull out upper surface (based on X3)
    $!VarSet |ZBlank1| = ( |Z3Orig| + 0.25*|C|      )
    $!VarSet |ZBlank2| = ( |Z3Orig|                 )
    $!VarSet |XBlank1| = ( |X3Orig| - 0.25*|C|      )
    $!VarSet |XBlank2| = ( |X3Orig| + 0.25*|C|      )
    
    $!Blanking Value{Include = Yes}
    $!Blanking Value{Constraint 1 {Include = Yes VarA = 'Z' Include = Yes RelOp = GreaterThan ValueCutoff = |ZBlank1|}}
    $!Blanking Value{Constraint 2 {Include = Yes VarA = 'Z' Include = Yes RelOp = LessThan    ValueCutoff = |ZBlank2|}}
    $!Blanking Value{Constraint 3 {Include = Yes VarA = 'X' Include = Yes RelOp = LessThan    ValueCutoff = |XBlank1|}}
    $!Blanking Value{Constraint 4 {Include = Yes VarA = 'X' Include = Yes RelOp = GreaterThan ValueCutoff = |XBlank2|}}
    
    $!If |Debugger| == 1
      $!System "printf 'Target: (%.4f,  %.4f,  %.4f) and normal (%.4f,  %.4f,  %.4f)\n' |X3Orig| |Y3Orig| |Z3Orig| |X3NormOrig| |Y3NormOrig| |Z3NormOrig|"
    $!EndIf

    # Rotate the vector 90 degrees around y to get the plane-normal vector...
    # So a plane with equation (a,b,c) turns into a normal of (c,b,-a)
    $!VarSet |XNormOut| = (      |Z3NormOrig| )
    $!VarSet |YNormOut| = (      |Y3NormOrig| ) # Not actually used, because I extract in the x-z plane
    $!VarSet |ZNormOut| = ( -1 * |X3NormOrig| )

    $!SliceLayers Show = Yes
    $!SliceAttributes 1  SliceSource = SurfaceZones
    $!SliceAttributes 1  EdgeLayer{Show = Yes}
    $!SliceAttributes 1  SliceSurface = Arbitrary
    $!SliceAttributes 1  PrimaryPosition{X = |X3Orig|   Y = |Y3Orig| Z = |Z3Orig|  }
    $!SliceAttributes 1  Normal{         X = |XNormOut| Y = 0        Z = |ZNormOut|}
    $!ExtractSlices
      Group = 1
      TransientOperationMode = SingleSolutionTime

    # Height from surface
    $!AlterData [|NUMZONES|] Equation = "{H}   = sqrt( ({X}-|X3Orig|)**2 + ({Y}-|Y3Orig|)**2 + ({Z}-|Z3Orig|)**2  )"
    $!AlterData [|NUMZONES|] Equation = "{HoC} = {H} / |C|"
    
    $!FieldMap  [|NUMZONES|] Mesh { Show = Yes Color = Red LineThickness = 0.4 }
    
    $!VarSet |XoCTargetFull| = ( floor(|XoCTarget|*10000) / 100 )
    $!If |XoCTargetFull| < 10
      $!VarSet |XoCTargetFull| = '0|XoCTargetFull|'
    $!EndIf
    $!If |XoCTargetFull| == 0
      $!VarSet |XoCTargetFull| = '00'
    $!EndIf
    
    $!RenameDataSetZone
      Zone = |NUMZONES|
      Name = '|ParticipantID| - eta=|EtaStation| - x/c=|XoCTargetFull| - Upper Surface'
    
    $!If |Debugger| == 1
      $!VarSet |LpkCounter| = ( |LpkCounter| + 1 )
      $!SaveLayout  "step|LpkCounter|.lpk"
        IncludeData = Yes
        IncludePreview = No
    $!EndIf
    
    
    #===================================================================
    # Extract lower surface profile
    #-------------------------------------
    $!ActiveFieldMaps = [|VolumeSliceZone|]

    # Set up blanking to pull out upper surface (based on X4)
    $!VarSet |ZBlank1| = ( |Z4Orig| - 0.25*|C| )
    $!VarSet |ZBlank2| = ( |Z4Orig|                 )
    $!Blanking Value{Include = Yes}
    $!Blanking Value{Constraint 1 {Include = Yes VarA = 'Z' Include = Yes RelOp = LessThan    ValueCutoff = |ZBlank1|}}
    $!Blanking Value{Constraint 2 {Include = Yes VarA = 'Z' Include = Yes RelOp = GreaterThan ValueCutoff = |ZBlank2|}}

    $!If |Debugger| == 1
      $!System "printf 'Target: (%.4f,  %.4f,  %.4f) and normal (%.4f,  %.4f,  %.4f)\n' |X4Orig| |Y4Orig| |Z4Orig| |X4NormOrig| |Y4NormOrig| |Z4NormOrig|"
    $!EndIf

    # Rotate the surface-normal vector 90 degrees around y to get the plane-normal vector
    # So a plane with equation (a,b,c) turns into a normal of (c,b,-a)
    $!VarSet |XNormOut| = (      |Z4NormOrig| )
    $!VarSet |YNormOut| = (      |Y4NormOrig| ) # Not actually used, because I extract in the x-z plane
    $!VarSet |ZNormOut| = ( -1 * |X4NormOrig| )

    $!SliceLayers Show = Yes
    $!SliceAttributes 2  SliceSource = SurfaceZones
    $!SliceAttributes 2  EdgeLayer{Show = Yes}
    $!SliceAttributes 2  SliceSurface = Arbitrary
    $!SliceAttributes 2  PrimaryPosition{X = |X4Orig|   Y = |Y4Orig| Z = |Z4Orig|  }
    $!SliceAttributes 2  Normal{         X = |XNormOut| Y = 0        Z = |ZNormOut|}
    
    $!ExtractSlices
      Group = 2
      TransientOperationMode = SingleSolutionTime

    # Height from surface
    $!AlterData [|NUMZONES|] Equation = "{H}   = sqrt( ({X}-|X4Orig|)**2 + ({Y}-|Y4Orig|)**2 + ({Z}-|Z4Orig|)**2  )"
    $!AlterData [|NUMZONES|] Equation = "{HoC} = {H} / |C|"

    $!RenameDataSetZone
      Zone = |NUMZONES|
      Name = '|ParticipantID| - |DescriptorText| - eta=|EtaStation| - x/c=|XoCTargetFull| - Lower Surface'

    $!If |Debugger| == 1
      $!VarSet |LpkCounter| = ( |LpkCounter| + 1 )
      $!SaveLayout  "step|LpkCounter|.lpk"
        IncludeData = Yes
        IncludePreview = No
    $!EndIf
    
    
    #===================================================================
    # Visualize airfoil cut with normal vectors
    #-------------------------------------
    $!FieldMap  [|NUMZONES|] Mesh { Show = Yes Color = Green LineThickness = 0.4 }
    $!ThreeDView PsiAngle = 90
    $!ThreeDView ThetaAngle = 0
    $!ThreeDView AlphaAngle = 0

    # Reset blanking... not needed as it's blanked before extraction
    $!Blanking Value{Include = No}
    
    $!If |Debugger| == 1
      $!VarSet |LpkCounter| = ( |LpkCounter| + 1 )
      $!SaveLayout  "step|LpkCounter|.lpk"
        IncludeData = Yes
        IncludePreview = No
    $!EndIf
      
    $!SliceAttributes 1  ShowGroup = Yes
    $!SliceAttributes 1  EdgeLayer{Color = Red}
    $!SliceAttributes 1  EdgeLayer{LineThickness = 1.5}
    
    $!SliceAttributes 2  ShowGroup = Yes
    $!SliceAttributes 2  EdgeLayer{Color = Green}
    $!SliceAttributes 2  EdgeLayer{LineThickness = 1.5}
    $!FieldLayers ShowMesh = No
    $!View FitSurfaces
      ConsiderBlanking = Yes
    
    $!FieldMap [1-|VolumeSliceZone|]  Mesh{Show = No}
    $!FieldMap [|FirstProfile|-|NUMZONES|] Mesh{LineThickness = 0.3}
    $!RedrawAll
    
    $!If |DebuggerPng| == 1
      $!PrintSetup Palette = Color
      $!ExportSetup ImageWidth = 600
      $!ExportSetup UseSuperSampleAntiAliasing = Yes
      $!ExportSetup ExportFName = 'png/eta|EtaStation|-xoc|XoCTargetFull|.png'
      $!Export 
        ExportRegion = AllFrames
    $!EndIf
    $!If |Debugger| == 1
      $!VarSet |LpkCounter| = ( |LpkCounter| + 1 )
      $!SaveLayout  "step|LpkCounter|.lpk"
        IncludeData = Yes
        IncludePreview = No
    $!EndIf
    
    # Visualize extracted profiles (not just the cutting planes)
    $!ActiveFieldMaps += [|FirstProfile|-|NUMZONES|]
    
    $!FieldLayers ShowMesh = Yes
    $!Blanking Value{Include = No}
    $!SliceLayers Show = No
    
    $!RedrawAll 
    $!ExportSetup ExportFName = 'png/profiles-eta|EtaStation|-xoc|XoCTargetFull|.png'
    $!Export 
      ExportRegion = AllFrames

    $!If |Debugger| == 1
      $!VarSet |LpkCounter| = ( |LpkCounter| + 1 )
      $!SaveLayout  "step|LpkCounter|.lpk"
        IncludeData = Yes
        IncludePreview = No
    $!EndIf
      

    # Planform view
    $!SliceLayers Show = No
    $!ActiveFieldMaps = [|WingMaps|,|FirstProfile|-|NUMZONES|]
    $!ThreeDView PsiAngle = 0
    $!ThreeDView ThetaAngle = 0
    $!ThreeDView AlphaAngle = 0

    $!If |Debugger| == 1
      $!VarSet |LpkCounter| = ( |LpkCounter| + 1 )
      $!SaveLayout  "step|LpkCounter|.lpk"
        IncludeData = Yes
        IncludePreview = No
    $!EndIf

    $!GlobalThreeD
      LightSource
        {
        XYZDirection{ X = 0.65 Y = -0.35 Z = 0.65 }
        Intensity = 75
        BackgroundLight = 25
        IncludeSpecular = Yes
        SpecularIntensity = 40
        SpecularShininess = 60
        }
    $!View DataFit
      ConsiderBlanking = Yes
    $!RedrawAll

    $!If |Debugger| == 1
      $!VarSet |LpkCounter| = ( |LpkCounter| + 1 )
      $!SaveLayout  "step|LpkCounter|.lpk"
        IncludeData = Yes
        IncludePreview = No
    $!EndIf
      
    
    $!FrameControl ActivateByNumber
      Frame = 2
    $!FrameControl DeleteActive
    $!If |Debugger| == 1
      $!VarSet |LpkCounter| = ( |LpkCounter| + 1 )
      $!SaveLayout  "step|LpkCounter|.lpk"
        IncludeData = Yes
        IncludePreview = No
    $!EndIf
  $!EndLoop # |NumXoCs|    going through each x/c
  
  $!If |Debugger| == 1
    $!VarSet |LpkCounter| = ( |LpkCounter| + 1 )
    $!SaveLayout  "step|LpkCounter|.lpk"
      IncludeData = Yes
      IncludePreview = No
  $!EndIf

  $!DeleteZones  [|SurfaceSliceZone|,|VolumeSliceZone|]
  
  $!If |Debugger| == 1
    $!VarSet |LpkCounter| = ( |LpkCounter| + 1 )
    $!SaveLayout  "step|LpkCounter|.lpk"
      IncludeData = Yes
      IncludePreview = No
  $!EndIf

  $!SliceLayers Show = No
  $!RedrawAll
$!EndMacroFunction


#===================================================================
# Prepare the setup for the macro
#-------------------------------------
$!If "|PlotTime|" != ""
  $!GlobalTime
    SolutionTime = |PlotTime|
$!EndIf

$!FieldMap  [|WingMaps|]
  Mesh { Show = No Color = Black LineThickness = 0.1 }
  ConTour
    {
    ConTourType = BothLinesAndFlood
    LineConTourGroup = 1
    FloodColoring = Group1
    Color = CusTom2
    UseLightingEffect = Yes
    }
  Vector { Color = Black }
  Scatter { Color = Black }
  Shade { Color = CusTom2 }
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
$!StreamTraceLayers
  Show = No

$!View Fit
$!FrameControl ActivateByNumber
  Frame = 1

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

$!DrawGraphics True

$!FieldLayers ShowMesh = No
$!FieldLayers ShowContour = No
$!FieldLayers ShowShade = Yes
$!FieldLayers ShowVector = No
$!FieldLayers ShowEdge = No
$!FieldLayers ShowScatter = No
$!FieldLayers UseTranslucency = No
$!SliceLayers Show = No
$!StreamTraceLayers Show = No
$!StreamAttributes AddArrows = No



#===================================================================
# Create Sectional Cuts
#-------------------------------------
# Hand Work

$!RunMacroFunction "ProfileCutter" (-999, 580.8041, -999, 0.3040) # ESP     (eta=0.5021)
$!RunMacroFunction "ProfileCutter" (-999, 580.8041, -999, 0.7903) # ESP     (eta=0.5021)

$!RunMacroFunction "ProfileCutter" (-999, 578.0280, -999, 0.3040) # Kulite  (eta=0.4997)
$!RunMacroFunction "ProfileCutter" (-999, 578.0280, -999, 0.7903) # Kulite  (eta=0.4997)

$!RunMacroFunction "ProfileCutter" (-999, 697.2889, -999, 0.3097) # ESP     (eta=0.6028)
$!RunMacroFunction "ProfileCutter" (-999, 697.2889, -999, 0.7677) # ESP     (eta=0.6028)

$!RunMacroFunction "ProfileCutter" (-999, 694.5127, -999, 0.3097) # Kulite  (eta=0.6004)
$!RunMacroFunction "ProfileCutter" (-999, 694.5127, -999, 0.7677) # Kulite  (eta=0.6004)



# HERITAGE DPW EXTRACTION LOCATIONS
# WING SECTION  1: SKIPPED AS THERE MAY BE FUSELAGE INTERFERENCE IN THE EXTRACTION

# WING SECTION  2: ETA = 0.1150, CHORD=459.571
$!RunMacroFunction "ProfileCutter" (1002.168, 133.026, 176.306, 20)

# WING SECTION  3: ETA = 0.1250, CHORD=452.687
$!RunMacroFunction "ProfileCutter" (1010.656, 144.594, 176.539, 20)

# WING SECTION  4: ETA = 0.1306, CHORD=448.836
$!RunMacroFunction "ProfileCutter" (1015.435, 151.074, 176.659, 20)

# WING SECTION  5: ETA = 0.2009, CHORD=400.743
$!RunMacroFunction "ProfileCutter" (1076.873, 232.444, 177.509, 20)

# WING SECTION  6: ETA = 0.2828, CHORD=344.991
$!RunMacroFunction "ProfileCutter" (1148.974, 327.074, 178.606, 20)

# WING SECTION  7: ETA = 0.3430, CHORD=304.101
$!RunMacroFunction "ProfileCutter" (1202.038, 396.765, 180.222, 20)

# WING SECTION  8: ETA = 0.3700, CHORD=285.806
$!RunMacroFunction "ProfileCutter" (1225.822, 427.998, 181.162, 20)

# WING SECTION  9: ETA = 0.3971, CHORD=278.111
$!RunMacroFunction "ProfileCutter" (1249.711, 459.370, 182.250, 20)

# WING SECTION 10: ETA = 0.5024, CHORD=248.312
$!RunMacroFunction "ProfileCutter" (1342.440, 581.148, 188.658, 20)

# WING SECTION 11: ETA = 0.6028, CHORD=219.904
$!RunMacroFunction "ProfileCutter" (1430.914, 697.333, 198.060, 20)

# WING SECTION 12: ETA = 0.7268, CHORD=184.844
$!RunMacroFunction "ProfileCutter" (1540.091, 840.704, 213.659, 20)

# WING SECTION 13: ETA = 0.8456, CHORD=151.235
$!RunMacroFunction "ProfileCutter" (1644.738, 978.148, 233.317, 20)

# WING SECTION 14: ETA = 0.9500, CHORD=121.735
$!RunMacroFunction "ProfileCutter" (1736.708,1098.926, 253.727, 20)

# WING SECTION 15: ETA = 0.9700, CHORD=116.095
$!RunMacroFunction "ProfileCutter" (1754.313,1122.048, 257.777, 20)

# WING SECTION 16: ETA = 0.9900, CHORD=110.452
$!RunMacroFunction "ProfileCutter" (1771.927,1145.183, 261.823, 20)



#===================================================================
# Visualize Profile Extractions
#-------------------------------------
$!Blanking Value{Include = No}
$!ActiveFieldMaps = [|WingMaps|,|FirstProfileAll|-|NUMZONES|]

$!ThreeDView
  PsiAngle = 60
  ThetaAngle = 130
  AlphaAngle = 15
$!View Fit

#===================================================================
$!WriteDataSet  "|ParticipantID|-|OutputFileName|"
  IncludeText = No
  IncludeGeom = No
  IncludeCusTomLabels = No
  IncludeDataShareLinkage = Yes
  ZoneList =  [|FirstProfile| - |NUMZONES|]
  VarList =  ['X','Y','Z','Mach','Mach_RMS','Volume','H','HoC']
  Binary = No
  UsePointFormat = Yes
  Precision = 12
  TecplotVersionToWrite = TecplotCurrent
 #VarList =  ['X','Y','Z','CP','Mach','CP_RMS','Mach_RMS','Volume','H','HoC']

$!If |Debugger| == 1
  $!SaveLayout  "final.lpk"
    IncludeData = Yes
    IncludePreview = No
$!EndIf

$!If |OPSYS| == 1
  $!System "printf '\n\nExtraction complete\n'"
$!EndIf

$!Quit
