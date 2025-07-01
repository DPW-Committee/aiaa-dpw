#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#   DPW-V TURBULENCE MODEL VERIFICATION DATA SUBMITTAL FORM (Version 1 - 11 MAY 2012)
#
#       Due 21 MAY 2012
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
#       NOMENCLATURE:
#                  X:   X coordinate
#              ALPHA:	Angle of Attack, deg
#                 CL:	Coefficient of Lift
#                 CD:	Coefficient of Drag
#                 CP:   Coefficient of pressure
#                 CF:   Skin-friction coefficient at wall [tauw/(freestream dynamic pressure)]
#
#   REFERENCE VALUES:
#
#    FLOW CONDITIONS:          Case3.1    Case3.2    Case3.3
#                 Mach Number: 0.20       0.20       0.15
#             Reynolds Number: 5.0x10^6   3x10^6     6*10^6    (based on Reference Length=1.0)
#             Freestream Temp: 540 deg R  540 deg R  540 deg R (80.33 deg F) 
#
#              NOTES: 1. All numerical data fields can be free-formatted.
#                     2. Please use at least 4 decimal places for coordinate values
#                     3. Please use at least 6 decimal places for coefficient values
#                     4. Only include one grid type, grid size, soln method, turb model, etc per form.
#                     5. Fill fields with value of -999 for data that are not available.
#
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

TITLE = "XXX"
VARIABLES =   "X"      "CP"    "CF"

#---------------------------------------------------
#   PARTICIPANT, GRID, AND SOLVER INFORMATION
#---------------------------------------------------
DATASETAUXDATA Name            = "Name of Participant"
DATASETAUXDATA SubmissionDate  = "Date of Submission"
DATASETAUXDATA SolverName      = "?"
DATASETAUXDATA BasicAlgorithm  = "?"
DATASETAUXDATA TurbulenceModel = "SA, SA-RC, SA-la, SST, SST-2003, Wilcox1998k-w, EARSMko2005, etc."
DATASETAUXDATA Miscellaneous   = "???"
DATASETAUXDATA GridId          = "CommonStructured, CommonQuad, CommonTriangle, Custom, etc."

#-------------------------------------------------------------------------------
#CASE 3.1: TURBULENCE MODEL VERIFICATION: 2D ZERO PRESSURE GRADIENT FLAT PLATE
#-------------------------------------------------------------------------------
ZONE T="XXX - Case3.1(TMV): 2D ZERO PRESSURE GRADIENT FLAT PLATE"
            ???.???? ?.?????? ?.??????
            ???.???? ?.?????? ?.??????
etc.

#-------------------------------------------------------------------------------
#CASE 3.2: TURBULENCE MODEL VERIFICATION: 2D BUMP-IN-CHANNEL
#-------------------------------------------------------------------------------
ZONE T="XXX - Case3.2(TMV): 2D BUMP-IN-CHANNEL"
            ???.???? ?.?????? ?.??????
            ???.???? ?.?????? ?.??????
etc.

#-------------------------------------------------------------------------------
#CASE 3.3: TURBULENCE MODEL VERIFICATION: 2D NACA 0012 AIRFOIL
#-------------------------------------------------------------------------------
DATASETAUXDATA CL_ALPHA0  = "?"
DATASETAUXDATA CD_ALPHA0  = "?"
ZONE T="XXX - Case3.3(TMV): 2D NACA 0012 AIRFOIL (ALPHA0)"
            ???.???? ?.?????? ?.??????
            ???.???? ?.?????? ?.??????
etc.

DATASETAUXDATA CL_ALPHA10 = "?"
DATASETAUXDATA CD_ALPHA10 = "?"
ZONE T="XXX - Case3.3(TMV): 2D NACA 0012 AIRFOIL (ALPHA10)"
            ???.???? ?.?????? ?.??????
            ???.???? ?.?????? ?.??????
etc.

DATASETAUXDATA CL_ALPHA15 = "?"
DATASETAUXDATA CD_ALPHA15 = "?"
ZONE T="XXX - Case3.3(TMV): 2D NACA 0012 AIRFOIL (ALPHA15)"
            ???.???? ?.?????? ?.??????
            ???.???? ?.?????? ?.??????
etc.
