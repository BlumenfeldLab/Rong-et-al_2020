# A pulse of fMRI increases in subcortical arousal systems during transitions in attention
This repository contains key codes and files used in "A pulse of fMRI increases in subcortical arousal systems during transitions in attention" - Rong et al, 2020.

## Summary
A detailed description of all methods used in the paper are given in the methods section of the manuscript.  However, to facilitate reproducability of our results, we have included in this repository a number of key codes and files.  If you have further questions regarding this paper, we encourage you to contact [Dr. Hal Blumenfeld](mailto:hal.blumenfeld@yale.edu?subject=[GitHub%20-%20Rong%20et%20al])

### Software
Most of the software used in this project is part of the opensource SPM12 software package, which is downloadable from [here](http://www.fil.ion.ucl.ac.uk/SPM).  However, we used a custom version of the `spm_spm` function (see Methods), which is included in this repository in `Rong-et-al_2020/Software/SPM/spm_spm.m`.  We have additionally included the code used to generate the statistics used to analyse the timecourses in the paper.  These functions can be found in `Rong-et-al_2020/Software/Timecourse/***.m`

### Data
Due to HIPAA requirements, we are not able to make all the data openly available, but it is available upon reasonable request and agreement with the authors.  However, we are making available the masks and ROIs used in this work.  These can be found in `Rong-et-al_2020/Masks_ROIs/*.mat`
