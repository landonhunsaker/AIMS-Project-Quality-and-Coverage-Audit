# AIMS-Project-Quality-and-Coverage-Audit
A quality-controlled heat map production and project summary of over 20 million observations of STIC Data from the Aquatic Intermittency Effects on Microbiomes (AIMS) project. 

# Introduction

The Aquatic Intermittency Effects on Microbiomes (AIMS) project is a multi-agency collaborative research effort with the goal of understanding how stream intermittency (periods of drying and rewetting) influences stream ecosystems. Within the project, in-stream sensors are deployed at monitoring sites throughout multiple watersheds to collect Stream Temperature, Intermittency, and Conductivity (STIC) data. This data consists of time series observations from different sites across the United States. Each site conducts a measurement every 15 minutes, collecting the time, device used, conductivity (uS/cm), Temperature (C), stream status (1 = wet, 0 = dry), and a read quality flag (Poor-Good). There are three regions included within the STIC data, each containing three watersheds. These regions span a broad range of climatic and hydrologic conditions. Regions included are:

  Great Plains: 
    *Kings Creek - Konza Prairie Biological Station
    Shane Creek - Konza Prairie Biological Station
    Young Meyer Ranch - Colorado *
  Mountain West: 
     *Johnston Draw - Idaho
     Gibson Jack Creek - Idaho
     Dry Creek - Idaho*
  Southeast:
     *Talladega - Alabama
     Paint Rock - Alabama
     Shambley Creek - Alabama*

  The Raw STIC data contains 14 columns and approximately 22 million rows of observations. Columns include the project (project), date and time (datetime), the unique site ID (siteId), the resource type (rtype), the sublocation of the instrument (sublocation), the serial number of the device (SN), the conductivity (condUncal), Temperature (TempC), deployment period (rep), specific conductivity (SpC), whether the measurement was wet or dry (wetdry), the quality of the measurement (qual_rating), an internal code for the quality (QAQC), and the Year the measurement took place (year).

# Skills:
R • Quality Control • Data Visualization • Git

# Files Included:
• A zipped folder containing the raw CSV files used for analysis. These can also be retrieved from the public AIMS Hydroshare data.
• A folder containing the final deliverables.
• An R file containing the code necessary to run and produce the attached deliverables.
• An optional R file to help with unzipping and organizing the CSV files to prepare for analysis. (If you use this helper code, ensure that you do not change the organization or naming of the files before running the code.)
• A final PDF containing a neat summary of the project and some example outputs.

# Author:
Landon Hunsaker
LinkedIn: [www.linkedin.com/in/landon-hunsaker-81124437b]
