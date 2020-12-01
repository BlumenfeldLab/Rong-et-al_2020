# A pulse of fMRI increases in subcortical arousal systems during transitions in attention
This repository contains key codes and files used in "A pulse of fMRI increases in subcortical arousal systems during transitions in attention" - Rong et al, 2020.

## Summary
A detailed description of all methods used in the paper are given in the methods section of the manuscript.  However, to facilitate reproducability of our results, we have included in this repository a number of key codes and files.  If you have further questions regarding this paper, we encourage you to contact [Dr. Hal Blumenfeld](mailto:hal.blumenfeld@yale.edu?subject=[GitHub%20-%20Rong%20et%20al])

### Software
Most of the software used in this project is part of the opensource SPM12 software package, which is downloadable from [here](http://www.fil.ion.ucl.ac.uk/SPM).  However, we used a custom version of the `spm_spm` function (see Methods), which is included in this repository in `Rong-et-al_2020/Software/SPM/spm_spm.m`.  We have additionally included the code used to generate the statistics used to analyse the timecourses in the paper.  These functions can be found in `Rong-et-al_2020/Software/Timecourse/ConfidenceInterval.m`.  The setup (paths etc) are well commented in both codes, and a detailed description of their purpose is given in the methods.

### Data
Data for the HCP gambling task are freely available in the public domain through the Human Connectome Project website as detailed in the Methods section. Data for the CPT/RTT task are available from the corresponding author subject to anonymization to protect privacy of clinical data and implementation of a data sharing agreement as required by the local IRB. Regions of interest for analyses are publicly available through MARSBAR as described in the Methods section of the paper, except for 1. our added gray matter template for midbrain and pons, which can be found at Rong-et-al_2020/Masks_ROIs/gray_matter_midbrain_pons_roi.nii, and 2. our added ROIs for midbrain and thalamus used for Figure 4, which can be found at Rong-et-al_2020/Masks_ROIs/*.mat
