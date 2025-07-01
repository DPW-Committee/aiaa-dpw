#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#   DPW-V FORCE & MOMENT DATA SUBMITTAL FORM (Version 1 - 11 MAY 2012)
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
#         GRID_LEVEL:   Level of grid refinement (1-6)
#              ZONES:   Number of grid zones
#        FIELD_NODES:   Number of field nodes
#        FIELD_CELLS:   Number of field cells
#     BOUNDARY_NODES:   Number of boundary nodes
#     BOUNDARY_FACES:   Number of boundary faces
#   BL_1ST_CELL_SIZE:   Size of 1st boundary layer cell
# BL_MAX-GROWTH_RATE:   Maximum growth rate in boundary layer cells
#           BL_CELLS:   Number of boundary layer cells
#
#   REFERENCE VALUES:
#                       Planform ref area, A         = 594720.00 inches^2
#                       Mean aerodynamic chord, Cref =    275.80 inches
#                       Full-span length, B          =   2313.50 inches
#                       Semi-span length, BO2        =   1156.75 inches
#                       x moment center              =   1325.90 inches
#                       y moment center              =    468.75 inches
#                       z moment center              =    177.95 inches
#                       Aspect Ratio, AR             =      9.00
#
#    FLOW CONDITIONS:
#                 Mach Number: 0.85
#             Reynolds Number: 5.0 million (based on Cref=275.80)
#             Freestream Temp: 100 deg F
#
#              NOTES: 1. All numerical data fields can be free-formatted.
#                     2. Please use at least 4 decimal places for coordinate values
#                     3. Please use at least 6 decimal places for coefficient values
#                     4. Only include one grid type, grid size, soln method, turb model, etc per form.
#                     5. Fill fields with value of -999 for data that are not available.
#
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

TITLE = "XXX"
VARIABLES = "GRID_LEVEL" "ZONES" "FIELD_NODES" "FIELD_CELLS" "BOUNDARY_NODES" "BOUNDARY_FACES" "BL_1ST_CELL_SIZE" "BL_MAX-GROWTH_RATE" "BL_CELLS"

#---------------------------------------------------
#   PARTICIPANT, GRID, AND SOLVER INFORMATION
#---------------------------------------------------
DATASETAUXDATA Name            = "Name of Participant"
DATASETAUXDATA SubmissionDate  = "Date of Submission"
DATASETAUXDATA SolverName      = "?"
DATASETAUXDATA BasicAlgorithm  = "?"
DATASETAUXDATA TurbulenceModel = "SA, SA-RC, SA-la, SST, SST-2003, Wilcox1998k-w, EARSMko2005, etc."
DATASETAUXDATA Miscellaneous   = "???"
DATASETAUXDATA CustomGridDescr = "Description Of Custom Grid"
DATASETAUXDATA GridType        = "Grid Type"
DATASETAUXDATA GridGenerator   = "Name of Grid Generation Program"
#GRID                  | Miscellaneous Notes
#----------------------|---------------------------------------------------------------------------------------------
DATASETAUXDATA L1Notes = ""
DATASETAUXDATA L2Notes = ""
DATASETAUXDATA L3Notes = ""
DATASETAUXDATA L4Notes = ""
DATASETAUXDATA L5Notes = ""
DATASETAUXDATA L6Notes = ""

ZONE T="XXX - Custom Grid"
 1  -999      100000      100000  -999  -999  -999  -999  -999
 2  -999     1000000     1000000  -999  -999  -999  -999  -999
 3  -999    10000000    10000000  -999  -999  -999  -999  -999
 4  -999   100000000   100000000  -999  -999  -999  -999  -999
 5  -999  1000000000  1000000000  -999  -999  -999  -999  -999
 6  -999 10000000000 10000000000  -999  -999  -999  -999  -999
