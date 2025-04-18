::--------------------------------------------------
:: Modifies on : 20240818
:: By Meir.e
:: Menu in batch.
:: https://github.com/Meir-Tools
:: Meir-Tools | VMware assist tools
::--------------------------------------------------
:: Run once , can run inly in batch file , Global
::--------------------------------------------------
@ECHO OFF & TITLE Meir-Tools & SET BATman="%~dp0BATman" & SET dta_ini="%~dp0dta.ini" 
if exist %BATman%.* ( echo %BATman% -^> Installed ) else ( echo %BATman% -^> Not Installed & PAUSE)
if exist %dta_ini%.* ( echo %dta_ini% -^> Installed ) else ( echo %dta_ini% -^> Not Installed & PAUSE)
 
::--------------------------------------------------
:: Meir-Tools | set Global variables
::--------------------------------------------------
 
::--------------------------------------------------
:: Meir-Tools | VMware assist | set Global variables
::--------------------------------------------------
 
::--------------------------------------------------
:: Meir-Tools | VMware assist | set the custom image to work on
::--------------------------------------------------
::--------------------------------------------------
:: Run once , can run inly in batch file , Global
::--------------------------------------------------
:Main
	::--------------------------------------------------
	:: Print Header | 
	::--------------------------------------------------
	CLS
	CALL %BATman% :MAN_Print_Logo_shrinked1 %0
	ECHO MAN-MENU
	echo ----------------------------------------------------------------------
	CALL %BATman% :ini_print %dta_ini%
	echo ----------------------------------------------------------------------
	::--------------------------------------------------
	:: Notes | 
	::--------------------------------------------------
	setlocal enabledelayedexpansion &REM Note , may find a way or a need to exit it by 'endlocal' somwhere in the code.
	::--------------------------------------------------
	:: Print Menu here
	::--------------------------------------------------
	CALL %BATman% :MAN_ShowMenu %0
	CALL :OPT%M% &REM replace here the IF %M%==1 GOTO OPT1 ...statements....
	::--------------------------------------------------
GOTO :Main
::--------------------------MAN Functions------------------------------------------------
:OPT1 | 1 - ping_all - ofc_ip=!ini_ofc_ip!
	::--------------------------------------------------
	::    Ping_all
	::--------------------------------------------------
	for /L %%z in (1,1,254) do ping %ini_ofc_ip%%%z -w 1 -n 1 -i 1
	
EXIT /B 0
:OPT2 | 2 - get by mac - mac_addr=!ini_mac_addr!
	CALL %BATman% :GetIP_byMAC "%ini_mac_addr%"
	pause
EXIT /B 0
  
:OPT- | - - - - - - costum functions here - - - - - - - - - -  
	PAUSE
EXIT /B 0 
:OPTA | A - arp -a
	arp -a
	pause
EXIT /B 0
:OPTP | P - ipconfig
	ipconfig /all
	pause
EXIT /B 0
:OPTE | E - Edit
	echo %lpath% &REM set lpath=%0 ::in top
	start "" "C:\Program Files\Notepad++\notepad++.exe" %~f0
	pause
EXIT /B 0
:OPTI | I - Info
	cls
	CALL %BATman% :Info_About
	echo.
	echo This is Home Assistant Menu 
	pause 
EXIT /B 0
:OPTQ | Q - exit
	exit
EXIT /B 0
::---Functions------------------------------------------------
:fChk_print_install_status 
	set mpath="%~1"
	if exist %mpath% ( echo %mpath% -^> Installed ) else ( echo %mpath% -^> Not Installed )
EXIT /B 0
:fChknRun 
	set mpath="%~1"
	if exist %mpath% ( echo %mpath% -^> Installed & start "" %mpath% ) else ( echo %mpath% -^>Error-File Not Exist & pause )
EXIT /B 0
 