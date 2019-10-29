


# ANTX

ANTX stands for **A** tlas **N** ormalization **T** oolbox using elasti **X**. It is a MATLAB toolbox for image registration of mouse magnetic resonance imaging data developed for research laboratories/departments.

## **Requirements**
- Windows (tested: Windows 10)
- Linux (tested: Ubuntu 16.04.6 LTS, MINT17)
- MAC (tested: OS X El Capital v10.11.6)
- MATLAB, version R2015b/16a were tested, versions above 2018b should work

## **Installation via GITHUB**
LINK: https://github.com/pstkoch/antx2

OPTION-A : Download using GIT client 
           ADVANTAGE: update option 
_ download & install GIT client --> https://git-scm.com/downloads
  .. just follow instructions and keep the proposed properties when ask for
_ browse to LINK: https://github.com/pstkoch/antx2
- select "installfromgithub.m" and click [RAW]-button 
  or copyNpaste this link: https://raw.githubusercontent.com/pstkoch/antx2/master/installfromgithub.m
- select "save as" (cmd+s or ctrl+s) and save file as "installfromgithub.m"
- copy "installfromgithub.m" to the location where antx toolbox should be installed.
  ..please don't create a folder with name "antx2", this folder will be created later on
- set MATLAB's current working dir to the location of "installfromgithub.m" 
- type installfromgithub to open the installer/check updates window
- select [FRESH INSTALL] ...than select the hyperlink "install" ..wait..and hit [close] to close the window 
   
  *** start ant gui ***
- set MATLAB's current working dir to "antx2" dir 
- type antlink to link paths
- type ant to open ant-gui 

  *** check for updates ***
 - To check for updates select EXTRAS/CHECK FOR UPATES (GITHUB) from the ant main gui

-----------------------------------------------
OPTION-B : just download no update option 
           ADVANTAGE: more simple installation
-----------------------------------------------
- select [Clone & download button]
- select [Download ZIP]
- unzip folder & copy entire "antx2"-folder to desired location

  *** start ant gui ***
- set MATLAB's current working dir to "antx2" dir 
- type antlink to link paths
- type ant to open ant-gui  


=============================================
Installation via googledrive (older versions):
=============================================
LINK: https://drive.google.com/drive/u/1/folders/0B9o4cT_le3AhSFJRdUx3eXlyUWM
-	download and unzip the ANTX2-toolbox
-	save the toolbox to your preferred drive/path
-	open Matlab, in Matlab set current path to the location of ANTX-Toolbox
-	 type and evaluate �antlink.m�  in the command window to temporally add all necessary paths to the matlabpath (these paths are temporally added and will lost after restarting Matlab). 
-	Alternatively, you can create a hyperlink that occurs each time Matlab is started (select this hyperlink to temporally add all necessary paths of the toolbox). 
To do this, you can copy the __startup.m� file (located in the ANTX-directory) to the matlab-root-path (in Matlab type: �matlabroot� to obtain your matlab-root-path, see also: https://de.mathworks.com/help/matlab/ref/startup.html?requestedDomain=de.mathworks.com). 
Rename this file to 'startup.m'
Finally, in the �startup.m�-file you have to set the path of ANTX-TBX. 

STUDY PATH:
set matlab�s current path to your mouse data �use �cd studypath�, where studypath is the current study-folder  or navigate to this path via Matlab�s current path (edit field in Matlab�s main window).
-example:  suppose data are in the study-folder �O:\TOMsampleData\harms\_retest_stack32�. This folder contains the folder �dat� with subfolders (each subfolder of the �dat�-folder represents the data of one mouse) ? thus set path to: O:\TOMsampleData\harms\_retest_stack32


Start ANT:
  -type ant in Matlab editor to start ANT-GUI
The right figure shows the main panel, containing:
-	an upper listbox to display information & parameters 
-	a left listbox to display all mouse-folders, i.e. subfolders in the �dat�-directory, data of each mouse is stored in its own folder
-	 a right listbox main warping functions)
-	 some buttons (with tooltips) 
-	a menu-bar with functions and instant help if mouse pointer is hovered over a menu-bar-item (function�s help is displayed in the lower help figure)