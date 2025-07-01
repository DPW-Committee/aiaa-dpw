README

DPW6 Data Request Forms

Errata and Clarification

Tecplot Macro Scripts are provided for extracting wing section and nacelle pressure cuts:

DPW-VI.SectionalCutter_v1.mcr
nacellecutsC.mcr

CASE 1 - Verification Study:

DPW-VI.DataForm_Case1_ForceMoment_Turbulence_v4.dat
DPW-VI.DataForm_Case1_Pressure_Turbulence_v4.dat
DPW-VI.DataForm_Case1_SkinFriction_Turbulence_v4.dat

Ignore reference to ?CommonMB?, ?CommonOverset? etc. grids and instead refer to nomenclature from the TBWG web site.

CASE 2-5 ? CRM Configuration Studies:

Ignore reference to ?CommonMB?, ?CommonOverset? etc. grids and instead refer to nomenclature from the  DPW6 provided grids website ftp://cmb24.larc.nasa.gov/outgoing/DPW6

CASE 2 ? CRM Nacelle-Pylon Drag Increment / Grid Convergence Study:

Note: CASE 2A refers to the Wing-Body configuration; CASE 2B refers to the Wing-Body-Nacelle-Pylon configuration.

DPW-VI.DataForm_Case2_GridMetrics_v4.dat
DPW-VI.DataForm_ForceMoment_v4.dat
DPW-VI.DataForm_Sectional_lift_and_moment_v5.dat
DPW-VI.DataForm_SectionalCuts_v4.dat
DPW-VI.DataForm_SOBSeparation_v4.dat
DPW-VI.DataForm_TESeparation_v4.dat
DPW-VI.DataForm_Case2B_Nacelle Cuts_v4.dat

CASE 3 - CRM WB Static Aero-Elastic Effect:

Data can be appended to:

DPW-VI.DataForm_ForceMoment_v4.dat
DPW-VI.DataForm_Sectional_lift_and_moment_v5.dat
DPW-VI.DataForm_SectionalCuts_v4.dat
DPW-VI.DataForm_SOBSeparation_v4.dat
DPW-VI.DataForm_TESeparation_v4.dat

CASE 4 - CRM WB Grid Adaptation [Optional]:

Only data for one flow condition is asked for, however, the forms can accept results for additional angles of attack.  Data can be appended to:

DPW-VI.DataForm_ForceMoment_v4.dat
DPW-VI.DataForm_Sectional_lift_and_moment_v5.dat
DPW-VI.DataForm_SectionalCuts_v4.dat
DPW-VI.DataForm_SOBSeparation_v4.dat
DPW-VI.DataForm_TESeparation_v4.dat

CASE 5 - CRM WB Coupled Aero-Structural Simulation [Optional]:

DPW-VI.DataForm_Case5_BendingTwist_v4.dat

Only data for one flow condition is asked for, however, the forms can accept results for additional angles of attack.  Data can be appended to:

DPW-VI.DataForm_ForceMoment_v4.dat
DPW-VI.DataForm_Sectional_lift_and_moment_v5.dat
DPW-VI.DataForm_SectionalCuts_v4.dat
DPW-VI.DataForm_SOBSeparation_v4.dat
DPW-VI.DataForm_TESeparation_v4.dat

CASE 6 ? CRM WB User Generated Grids [Optional}:

Case 6 has not been formally asked for but is a placeholder for solutions based on user generated grids.  Data can be appended to:

DPW-VI.DataForm_ForceMoment_v4.dat
DPW-VI.DataForm_Sectional_lift_and_moment_v5.dat
DPW-VI.DataForm_SectionalCuts_v4.dat
DPW-VI.DataForm_SOBSeparation_v4.dat
DPW-VI.DataForm_TESeparation_v4.dat

Please provide some grid name identifier on line 
AUXDATA GridId   = "????."

For cases 2-6 a single set of forms can be used of a common set of solutions based on a single solver, turbulence model, grid type, etc.   A separate set of forms should be provided for each solver, turbulence model, grid type, etc.  Case 4 results can be included in the forms that also apply to the most similar grid type.  Otherwise Case 4 results can be given in a separate set of forms. 

