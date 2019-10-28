#28-Oct-2019 14:12:21 RandNUmber: 1000
#28-Oct-2019 14:12:21 RandNUmber: 906
#28-Oct-2019 14:12:00 RandNUmber: 815
#28-Oct-2019 10:33:47 RandNUmber: 278

Installation:
-	download and unzip the ANTX2-toolbox
-	save the toolbox to your preferred drive/path
-	open Matlab, in Matlab set current path to the location of ANTX-Toolbox
-	 type and evaluate „antlink.m“  in the command window to temporally add all necessary paths to the matlabpath (these paths are temporally added and will lost after restarting Matlab). 
-	Alternatively, you can create a hyperlink that occurs each time Matlab is started (select this hyperlink to temporally add all necessary paths of the toolbox). 
To do this, you can copy the __startup.m’ file (located in the ANTX-directory) to the matlab-root-path (in Matlab type: ‘matlabroot’ to obtain your matlab-root-path, see also: https://de.mathworks.com/help/matlab/ref/startup.html?requestedDomain=de.mathworks.com). 
Rename this file to 'startup.m'
Finally, in the ‘startup.m’-file you have to set the path of ANTX-TBX. 

STUDY PATH:
set matlab’s current path to your mouse data –use „cd studypath”, where studypath is the current study-folder  or navigate to this path via Matlab’s current path (edit field in Matlab’s main window).
-example:  suppose data are in the study-folder „O:\TOMsampleData\harms\_retest_stack32“. This folder contains the folder ‘dat’ with subfolders (each subfolder of the ‘dat’-folder represents the data of one mouse) ? thus set path to: O:\TOMsampleData\harms\_retest_stack32


Start ANT:
  -type ant in Matlab editor to start ANT-GUI
The right figure shows the main panel, containing:
-	an upper listbox to display information & parameters 
-	a left listbox to display all mouse-folders, i.e. subfolders in the ‘dat’-directory, data of each mouse is stored in its own folder
-	 a right listbox main warping functions)
-	 some buttons (with tooltips) 
-	a menu-bar with functions and instant help if mouse pointer is hovered over a menu-bar-item (function’s help is displayed in the lower help figure)
