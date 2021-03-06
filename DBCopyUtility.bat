@echo off
cls
:INIT
IF NOT DEFINED rootid SET "rootid=DBCU-Files"
IF NOT DEFINED id SET id=DB
IF NOT DEFINED currentCkpt SET "currentCkpt=NOL"

IF NOT DEFINED dirIDLocal set "dirIDLocal=c:\Thrive"
IF NOT DEFINED dirIDLocal2 set "dirIDLocal2=c:\Thrive\sfdata"

IF NOT DEFINED dirIDNetwork set "dirIDNetwork=\\192.168.0.10\Thrive"
IF NOT DEFINED dirIDNetwork2 set "dirIDNetwork2=\\192.168.0.10\Thrive\sfdata"

IF not defined newFolderPerExtension set newFolderPerExtension = n

:NOL
SET currentCkpt = NOL
echo **********************************************************
echo ** Welcome to DB Copy Utility ****************************
echo ** Sources are Currently Defined *************************
echo ** Edit .bat file if you wish to modify Sources **********
echo **********************************************************
echo ---------------------------------------------------------------
echo ---------------------------------------------------------------
echo ------------------- Source Options ----------------------------
echo ---------------------------------------------------------------
echo ------(L)----- LOCAL %dirIDLocal%
echo ------------       %dirIDLocal2%
echo ---------------------------------------------------------------                               
echo ------(N)---- NETWORK %dirIDNetwork%
echo ------------         %dirIDNetwork2%
echo ---------------------------------------------------------------
echo ---------------------------------------------------------------
echo ---------------------------------------------------------------
echo **********************************************************
echo ** Would you like to Copy from Network or Local? (N/L) ***
echo **********************************************************
echo ************(( N = Network    L = Local ))****************
echo **********************************************************
set /P NET="N/L: "
IF /I %NET% == n goto NA
IF /I %NET% == l goto LA

goto INVALID

:NA
cls
set "DL=Network"
SET currentCkpt = NA
SET id=DB-Network
SET  dirID=%dirIDNetwork% 
SET dirID2=%dirIDNetwork2%
echo Directory 1 %dirID%
echo Directory 2 %dirID2%
GOTO FOL

:LA
cls
set "DL=Local"
SET currentCkpt = LA
SET id=DB-Local
SET dirID=%dirIDLocal%
SET dirID2=%dirIDLocal2%
echo Directory 1 %dirID%
echo Directory 2 %dirID2%
GOTO FOL

:FOL
cls
SET currentCkpt = FOL

echo ***************************************************
echo ** Current Directory (%DL%) 
echo ***************************************************
echo ** Create Custom Folder Name? (Y/N) ***************
echo ***************************************************
echo **((Select N for Default Folder Name))*************
echo **((Folder Directory will be created on Desktop))**
echo ***************************************************
set /P FOLD="Custom Folder Name? Y/N: "
IF /I %FOLD% == y goto CFOL
IF /I %FOLD% == n goto DFOL
goto INVALID

:DFOL
SET currentCkpt = DFOL
if not exist "C:\Users\%username%\Desktop\%rootid%\%id%" mkdir C:\Users\%username%\Desktop\%rootid%\%id%
if not defined destinationFolder set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%"
echo **********************************************************************************
echo ** Default Folder Created: %destinationFolder% ***********************************
echo **********************************************************************************
set "newFolderPerExtension=n"

if /I %newFolderPerExtension% == n mkdir "%destinationFolder%\Thrive"
if /I %newFolderPerExtension% == n mkdir "%destinationFolder%\Thrive\sfdata"
set "thriveFolder=%destinationFolder%\Thrive"
set "sfFolder=%destinationFolder%\Thrive\sfdata"
GOTO SN

:CFOL
SET currentCkpt = CFOL
set /p id="Enter Folder Name (No Spaces Please): "
if not exist "C:\Users\%username%\Desktop\%rootid%\%id%" mkdir C:\Users\%username%\Desktop\%rootid%\%id%"
if not defined destinationFolder set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%"

echo ************************************************************************************
echo ********* Custom Folder Created: %destinationFolder% *******************************
echo ************************************************************************************
set "newFolderPerExtension=n"
if /I %newFolderPerExtension% == n mkdir "%destinationFolder%\Thrive"
if /I %newFolderPerExtension% == n mkdir "%destinationFolder%\Thrive\sfdata"
set "thriveFolder=%destinationFolder%\Thrive"
set "sfFolder=%destinationFolder%\Thrive\sfdata"
GOTO SN

:BEG
cls
SET currentCkpt = BEG
echo ************************************
echo ** Copy Specific Extension? (Y/N) **
echo ************************************
echo ****************************************************
echo *****((Choose N to Quick Sync Entire Directory))****
echo ****************************************************

set /P SEL="Y/N: "
IF /I %SEL% == y goto nfpx
IF /I %SEL% == n goto CONF
goto INVALID

:conf
cls
echo *****************************************************************
echo *****************************************************************
echo ***** Current Directory (%DL%)       
echo ***** -------Sources----------------
echo ***** %dirID%                       
echo ***** %dirID2%                      
echo *****                               
echo *****-------Destination ------------                                          
echo ***** %destinationFolder%             
echo *****                               
echo ************************************************************************************************************
echo *****                                                                                                    ***
echo *****   Are You Sure you would like to Sync Entire Directory?                                            ***
echo *****   All files in the Destination Folder will be checked against the Sources                          ***
echo *****   Existing Files that are not in the Source Folder will be Removed from the Destination Folder     ***
echo *****                                                                                                    ***
echo *****                    Type (Y) to Sync Directory        Type (N) to navigate to Copy by Selection     *** 
echo *****                                                                                                    ***
echo ************************************************************************************************************
set /P CON="Sync Directory? Y/N: "
IF /I %CON% == y goto ME
IF /I %CON% == n goto 0
goto INVALID

:nfpx
cls
SET currentCkpt = nfpx
echo ** Current Source (%DL%)***********************
echo *******************************************************
echo ** Organize Extensions into their own folders? (Y/N) **
echo *******************************************************
echo *******************************************************
echo *****((DOES NOT WORK WHEN SYNC ENTIRE DB))*************
echo *******************************************************
set /p newFolderPerExtension="Oganize Extensions into Folders? Y/N: "
goto 0


:SN
cls
echo ***************************************************
echo ***************************************************
echo ***** Current Source (%DL%)       
echo ***** -------Sources----------------
echo ***** %dirID%                       
echo ***** %dirID2%                      
echo *****                               
echo *****-------Destination ------------                                          
echo ***** %destinationFolder%       
echo ***************************************************
echo ***************************************************
echo ***************** FULL SYNC NOW? (Y/N) ************
echo ***************************************************
echo ***************************************************
set /P PICK="(Y/N): "

if /I %PICK% == y GOTO ME
if /I %PICK% == n GOTO 0


goto MENU






:0 
cls
SET currentCkpt = 0
echo %thriveFolder%
echo %sfFolder%
echo *******************************************************************************
echo ***************************** Choose Sync Type ********************************
echo *******************************************************************************
echo ****************  0 =  Sync With Source                      ******************
echo ****************  1 =  Sync Only *Below* Defined File Types  ******************
echo ****************  2 = .CDX                                   ******************
echo ****************  3 = .DSN (Data Source Name)                ******************
echo ****************  4 = .DBC                                   ******************
echo ****************  5 = .DBF                                   ******************
echo ****************  6 = .DCT                                   ******************
echo ****************  7 = .DCX                                   ******************
echo ****************  8 = .FPT                                   ******************
echo ****************  9 = .FXP                                   ******************
echo **************** 10 = .PRG                                   ******************
echo **************** 11 =  Microsoft Access Files                ******************
echo **************** 12 = .TXT                                   ******************
echo **************** 13 = .BAK                                   ******************
echo *******************************************************************************
echo *******************************************************************************
echo ** Current Source (%DL%)       
echo ** FOLDER SPACE: %destinationFolder%  
echo ******************************************************************************* 
echo *******************************************************************************
set /P INPUT="Selection #: "                                   

if /I %INPUT% == 1 GOTO 1
if /I %INPUT% == 2 GOTO 2
if /I %INPUT% == 3 GOTO 3
if /I %INPUT% == 4 GOTO 4
if /I %INPUT% == 5 GOTO 5
if /I %INPUT% == 6 GOTO 6
if /I %INPUT% == 7 GOTO 7
if /I %INPUT% == 8 GOTO 8
if /I %INPUT% == 9 GOTO 9
if /I %INPUT% == 10 GOTO 10
if /I %INPUT% == 11 GOTO 11
if /I %INPUT% == 12 GOTO 12
if /I %INPUT% == 13 GOTO 13
if /I %INPUT% == 0 GOTO ME
goto INVALID

:REP
echo ***************************************************
echo ***************************************************
echo ******************** COMPLETE *********************
echo ***************************************************
echo ***************************************************
goto MENU

:MENU
SET currentCkpt = MENU
echo ***************************************************
echo ********************************************************
echo *************************************************************
echo ******************************************************************
echo -----------------------------------------------------------------------
echo -***************** MENU ********************----------------------
echo -**** 1. Sync *Last Selection*              :  Last Sync (%lastSEL%) at (%time%) on (%date%)     
echo -**** 2. Change Sync Type                   :  Change the Extension to Copy  
echo -**** 3. Folder Creation                    :  Change / Customize Destination Path  
echo -**** 4. Change Source Location (N/L)       :  Current Source (%DL%)  
echo -**** 5. Exit                               :  Exit DBCopyUtility     
echo -**************************************************---------------
echo -**Current Destination Path (%destinationFolder%)
echo -**********************************************************************
echo ******************************************************************
echo *************************************************************
echo ********************************************************
echo ***************************************************
echo **********************************************

set /P chos="Where to?: "

IF /I %chos% == 1 goto QP

IF /I %chos% == 2 goto 0

IF /I %chos% == 3 goto FOL

if /I %chos% == 4 goto INIT

if /I %chos% == 5 EXIT
goto INVALID


:QP
if /I %INPUT% == 0 GOTO ME
if /I %INPUT% == 1 GOTO CONF
if /I %INPUT% == 2 GOTO 2
if /I %INPUT% == 3 GOTO 3
if /I %INPUT% == 4 GOTO 4
if /I %INPUT% == 5 GOTO 5
if /I %INPUT% == 6 GOTO 6
if /I %INPUT% == 7 GOTO 7
if /I %INPUT% == 8 GOTO 8
if /I %INPUT% == 9 GOTO 9
if /I %INPUT% == 10 GOTO 10
if /I %INPUT% == 11 GOTO 11
if /I %INPUT% == 12 GOTO 12
if /I %INPUT% == 13 GOTO 13
if /I %INPUT% == 14 GOTO 1

goto INVALID

:1
goto All

:2
if /I %newFolderPerExtension% == y mkdir "%destinationFolder%\.cdx"
if /I %newFolderPerExtension% == y set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\.cdx
Goto 2a
:2a
set "lastSEL=.CDX"
robocopy %dirID% %thriveFolder% *.cdx
robocopy %dirID2% %sfFolder% *.cdx
set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\"
Goto REP

:3
if /I %newFolderPerExtension% == y mkdir "%destinationFolder%\.dsn"
if /I %newFolderPerExtension% == y set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\.dsn"
goto 3a
:3a
set lastSEL = .DSN"
robocopy %dirID%  %thriveFolder% *.dsn
robocopy %dirID2% %sfFolder% *.dsn
set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\"
Goto REP

:4
if /I %newFolderPerExtension% == y mkdir "%destinationFolder%\.dbc"
if /I %newFolderPerExtension% == y set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\.dbc"
goto 4a
:4a
set "lastSEL=.DBC"
robocopy %dirID%  %thriveFolder% *.dbc
robocopy %dirID2% %sfFolder% *.dbc
set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\"
Goto REP

:5
if /I %newFolderPerExtension% == y mkdir "%destinationFolder%\.dbf"
if /I %newFolderPerExtension% == y set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\.dbf"
goto 5a
:5a
set "lastSEL=.DBF"
robocopy %dirID%  %thriveFolder% *.dbf
robocopy %dirID2% %sfFolder% *.dbf
set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\"
Goto REP

:6
if /I %newFolderPerExtension% == y mkdir "%destinationFolder%\.dct"
if /I %newFolderPerExtension% == y set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\.dct"
goto 6a
:6a
set "lastSEL=.DCT"
robocopy %dirID%  %thriveFolder% *.dct
robocopy %dirID2% %sfFolder% *.dct
set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\"
Goto REP

:7
if /I %newFolderPerExtension% == y mkdir "%destinationFolder%\.dcx"
if /I %newFolderPerExtension% == y set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\.dcx"
goto 7a
:7a
set "lastSEL=.DCX"
robocopy %dirID%  %thriveFolder% *.dcx
robocopy %dirID2% %sfFolder% *.dcx
set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\"
Goto REP

:8
if /I %newFolderPerExtension% == y mkdir "%destinationFolder%\.fpt"
if /I %newFolderPerExtension% == y set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\.fpt"
goto 8a
:8a
set "lastSEL=.FPT"
robocopy %dirID%  %thriveFolder% *.fpt
robocopy %dirID2% %sfFolder% *.fpt
set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\"
Goto REP

:9
if /I %newFolderPerExtension% == y mkdir "%destinationFolder%\.fxp"
if /I %newFolderPerExtension% == y set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\.fxp"
goto 9a
:9a
set "lastSEL=.FXP"
robocopy %dirID%  %thriveFolder% *.fxp
robocopy %dirID2% %sfFolder% *.fxp
set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\"
Goto REP

:10
if /I %newFolderPerExtension% == y mkdir "%destinationFolder%\.prg"
if /I %newFolderPerExtension% == y set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\.prg"
goto 10a
:10a
set "lastSEL=.PRG"
robocopy %dirID%  %thriveFolder% *.prg
robocopy %dirID2% %sfFolder% *.prg
set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\"
Goto REP

:11
if /I %newFolderPerExtension% == y mkdir "%destinationFolder%\Microsoft-Access-Files"
if /I %newFolderPerExtension% == y set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\Microsoft-Access-Files"
goto 11a
:11a
set "lastSEL=MICROSOFT ACCESS"
robocopy %dirID% %thriveFolder% *.accdb *.mdb
robocopy %dirID2% %sfFolder% *.mdb *.accdb
set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\"
Goto REP

:12
if /I %newFolderPerExtension% == y mkdir "%destinationFolder%\.txt"
if /I %newFolderPerExtension% == y set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\.txt"
goto 12a
:12a
set "lastSEL=.TXT"
robocopy %dirID%  %thriveFolder% *.txt
robocopy %dirID2% %sfFolder% *.txt
set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\"
Goto REP

:13
if /I %newFolderPerExtension% == y mkdir "%destinationFolder%\.bak"
if /I %newFolderPerExtension% == y set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\.bak"
goto 13a
:13a
set "lastSEL=.BAK"
robocopy %dirID%  %thriveFolder% *.bak
robocopy %dirID2% %sfFolder% *. bak
set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\"
Goto REP

:14
cls
set "lastSEL=FULL SYNC"
set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\"
robocopy %dirID%  %destinationFolder% /MIR
GOTO REP



:ENTIRE
robocopy %dirID%  %thriveFolder% /xf *.txt *.exe *.bmp *.pdf *.xls *.tmp *.dll *.dat *.ini
robocopy %dirID2% %sfFolder% /xf *.txt *.exe *.bmp *.pdf *.xls *.tmp *.dll *.dat *.ini
goto REP

:ME
set "lastSEL=Full Sync"
set "INPUT=0"
robocopy %dirID%  %destinationFolder% /MIR /xf *.txt *.exe *.bmp *.pdf *.xls *.tmp *.dll *.dat *.ini
goto REP


:INVALID
cls

echo ===========================================================================================================
echo ==************************************************************=============================================
echo ==**********************INVALID SELECTION*********************=============================================
echo ==*************************TRY AGAIN**************************=============================================
echo ==************************************************************=============================================
echo ===========================================================================================================
goto INIT

:All
set "lastSEL=All Defined"
set "newFolderPerExtension=y"
if /I %newFolderPerExtension% == y mkdir "%destinationFolder%\.cdx"
if /I %newFolderPerExtension% == y set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\.cdx"
robocopy %dirID% %thriveFolder% *.cdx
robocopy %dirID2% %sfFolder% *.cdx
set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\"
if /I %newFolderPerExtension% == y mkdir "%destinationFolder%\.dsn"
if /I %newFolderPerExtension% == y set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\.dsn"
robocopy %dirID%  %thriveFolder% *.dsn
robocopy %dirID2% %sfFolder% *.dsn
set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\"
if /I %newFolderPerExtension% == y mkdir "%destinationFolder%\.dbc"
if /I %newFolderPerExtension% == y set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\.dbc"
robocopy %dirID%  %thriveFolder% *.dbc
robocopy %dirID2% %sfFolder% *.dbc
set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\"
if /I %newFolderPerExtension% == y mkdir "%destinationFolder%\.dbf"
if /I %newFolderPerExtension% == y set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\.dbf"
robocopy %dirID%  %thriveFolder% *.dbf
robocopy %dirID2% %sfFolder% *.dbf
set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\"
if /I %newFolderPerExtension% == y mkdir "%destinationFolder%\.dct"
if /I %newFolderPerExtension% == y set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\.dct"
robocopy %dirID%  %thriveFolder% *.dct
robocopy %dirID2% %sfFolder% *.dct
set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\"
if /I %newFolderPerExtension% == y mkdir "%destinationFolder%\.dcx"
if /I %newFolderPerExtension% == y set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\.dcx"
robocopy %dirID%  %thriveFolder% *.dcx
robocopy %dirID2% %sfFolder% *.dcx
set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\"
if /I %newFolderPerExtension% == y mkdir "%destinationFolder%\.fpt"
if /I %newFolderPerExtension% == y set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\.fpt"
robocopy %dirID%  %thriveFolder% *.fpt
robocopy %dirID2% %sfFolder% *.fpt
set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\"
if /I %newFolderPerExtension% == y mkdir "%destinationFolder%\.fxp"
if /I %newFolderPerExtension% == y set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\.fxp"
robocopy %dirID%  %thriveFolder% *.fxp
robocopy %dirID2% %sfFolder% *.fxp
set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\"
if /I %newFolderPerExtension% == y mkdir "%destinationFolder%\.prg"
if /I %newFolderPerExtension% == y set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\.prg"
robocopy %dirID%  %thriveFolder% *.prg
robocopy %dirID2% %sfFolder% *.prg
set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\"
if /I %newFolderPerExtension% == y mkdir "%destinationFolder%\Microsoft-Access-Files"
if /I %newFolderPerExtension% == y set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\Microsoft-Access-Files"
robocopy %dirID% %thriveFolder% *.accdb *.mdb
robocopy %dirID2% %sfFolder% *.mdb *.accdb
set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\"
if /I %newFolderPerExtension% == y mkdir "%destinationFolder%\.txt"
if /I %newFolderPerExtension% == y set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\.txt"
robocopy %dirID%  %thriveFolder% *.txt
robocopy %dirID2% %sfFolder% *.txt
set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\"
if /I %newFolderPerExtension% == y mkdir "%destinationFolder%\.bak"
if /I %newFolderPerExtension% == y set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\.bak"
robocopy %dirID%  %thriveFolder% *.bak
robocopy %dirID2% %sfFolder% *. bak
set "destinationFolder= C:\Users\%username%\Desktop\%rootid%\%id%\"
set "newFolderPerExtension=n"
Goto REP
