::-------------------------------------------------------------------------------------------
:: Modifies on : 05-01-2023
:: By Meir.e
:: Functions libarary here.
:: REF|https://github.com/Meir-E/MAN/blob/main/Menu_MAN.bat
:: default on : %USERPROFILE%\Documents\GitHub\Functions\BATman.bat
::-----------------Run once , can run inly in batch file , Global----------------------------
::add: @ECHO OFF & TITLE Meir-E &SET MAN_Func=CALL %USERPROFILE%\Documents\GitHub\Functions\BATman.bat 
::or: @ECHO OFF & TITLE Meir-E &SET BATman=%USERPROFILE%\Documents\GitHub\Functions\BATman.bat &call %1
::replace: CALL :func
::with: CALL !MAN_Func! :func
SET BATman=%USERPROFILE%\Documents\GitHub\Functions\BATman
SET local_path="%0\.."
CALL %*
EXIT /B %ERRORLEVEL%
::----------------------------Functions-----------------------------------------
:ConsolePrint <>
	setlocal
	<nul set /p "=%~1"
	endlocal
EXIT /B 0
:GetChar <res>
	setlocal
	:: 0123456789abcdefghijklmnopqrstuvwxyz , can change here what char are available,Mei-R
	for /F "tokens=1 delims=," %%a in ('"choice /N /C 0123456789abcdefghijklmnopqrstuvwxyz"') do (set "result=%%a")
	endlocal & set result=%result% & set %~1=%result%
EXIT /B 0
:ini_print <ini_file_path>
	::ref | 20221217_|https://github.com/Meir-E/Batch_INI_API
	for /f "usebackq tokens=1-2 delims==" %%a in (%1) do (
      echo %%a %%b
	  SET ini_%%a=%%b
	)
EXIT /B 0 
:AHK_Send_Keys <Key_strokes>
	:: May requare Admin mode
	::ref | https://github.com/Meir-E/AHK_Send_Key
	setlocal
	start "" %local_path%\AHK_Send_Key.exe %1
	endlocal
EXIT /B 0  
:AHK_Img_Click <Img_path>
	:: May requare Admin mode
	::ref | https://github.com/Meir-E/AHK_Img_Click
	setlocal
	start "" %local_path%\AHK_Img_Click.exe %1
	endlocal
EXIT /B 0 
:ConsolePrintColor <hexColorCode> <str>
	setlocal
	::need run once | REF | https://stackoverflow.com/questions/30025027/code-for-changing-colors-in-batch-how-is-it-working
	for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%m in (1) do rem"') do (set "BS_Char=%%a" ) & echo off &REM Generate the BS Character Method.
	call :ConsolePrint %BS_Char% > "%~2" &REM moves BS character
	findstr /v /a:%1 /R "^$" "%~2" nul
	del "%~2" > nul 2>&1i
	endlocal
	EXIT /B 0
::------------------------------------MAN_Functions-------------------------------------------
:Print_MAN_Logo
:MAN_Print_Logo
	echo ---------------------------------------------BATman-------
	echo "       @@@@        @@@.      @@@       #@*     @*      "      
	echo "       @@*@(      @&#@.     @@@@@      #@@     @#      "      
	echo "       @@ (@.    @@ #@.    @@   @@     #@*@    @#      "      
	echo "       @@  @@   @@  #@.   @@=====@@    #@* @   @#      "      
	echo "       @@   @@ (@   #@.  @@       @@   #@*  @ @@#      "      
	echo "       @@    @@@,   #@. @@         @@  #@     @@#      "
	echo ----------------------------------------------------------
EXIT /B 0
:MAN_Print_Logo_shrinked1
	echo ---------------------------------------------BATman-------
	echo "       @@@@        @@@.      @@@       #@*     @*      "      
	echo "       @@ (@.    @@ #@.    @@   @@     #@*@    @#      "      
	echo "       @@  @@   @@  #@.   @@=====@@    #@* @   @#      "      
	echo "       @@    @@@,   #@. @@         @@  #@     @@#      "
	echo ----=Meir-Tools=------------------------------------------
EXIT /B 0
:MAN_Print_Meir_tools_Logo
	echo ---------------------------------------------BATman-------------------  
	echo "       @@@@        @@@.               #@*          @@@@@@@@@@@@     "        
	echo "       @@*@(      @&#@.      @@@                   @@.        @@    "        
	echo "       @@ (@.    @@ #@.   @@    .@@   #@*          @@.       @@/    "        
	echo "       @@  @@   @@  #@.  @@@@@@@@@@@  #@*          @@@@@@@@@/       "        
	echo "       @@   @@ (@   #@.  @@           #@*          @@.     *@@.     "        
	echo "       @@    @@@,   #@.  .@@,   .@@*  #@*          @@.       &@@    "        
	echo "                             /#(.                                   "
	echo ----=Meir-Tools=------------------------------------------------------
EXIT /B 0
:MAN_Print_Meir_tools_Logo_shrinked1  &REM ### TBD
	echo ---------------------------------------------BATman-------------------    
	echo "       @@@@        @@@.      @@@      #@*          @@@@@@@@@@@@ 
	echo "       @@ (@.    @@ #@.   @@    .@@                @@.       @@/    "        
	echo "       @@  @@   @@  #@.  @@=======@@  #@*          @@======@@/      "        
	echo "       @@    @@@,   #@.   @.______.   #@*          @@.      *@@.    "
	echo ----=Meir-Tools=------------------------------------------------------
EXIT /B 0
:ShowMenu <file_path>	
:MAN_ShowMenu <file_path>	
	:: Print Menu here, 
	:: example :ShowMenu %0
	:: need add: CALL %BATman% :GetChar M & CALL :OPT%M%
	FOR /f "tokens=1-2 delims=|" %%a IN ('findstr /R /C:":OPT" %1') do (echo ^> %%b)
	::CALL :ConsolePrint "Type 1, 2, 3, or 4 then press ENTER: " & echo.
	CALL :ConsolePrint "Type 1, 2, 3, or 4 then press ENTER: " & echo. & CALL :GetChar M &REM 
	::CALL :OPT%M% &REM replace here the IF %M%==1 GOTO OPT1 ...statements....
EXIT /B 0
:GetIP_byMAC <MAC_num> &REM update_20012023
	FOR /F "tokens=1" %%F IN ('"arp -a | findstr /R /C:%1"') DO set Result=%%F
	IF [%Result%]==[] (echo String is Empty, no IP.&EXIT /B 1) else (echo %Result% )
EXIT /B 0
:Edit_me    &REM | E - Edit
	:: need send the '%0' over the function
	::set lpath=%0 ::in top
	echo %lpath%
	start "" "C:\Program Files\Notepad++\notepad++.exe" %lpath%
	pause
EXIT /B 0
:Info_About &REM I - Info and About
	CALL :MAN_Print_Meir_tools_Logo_shrinked1 &REM ### 
	echo info about this MAN menu , how to use , TBD
	echo By Meir-Tools ^| https://github.com/Meir-Tools/MAN
	echo Revision 0.9b , date 20240725
EXIT /B 0
::------------------------------------END--------------------------------------------------------
:: TBD
:: add Check_Installed function to checl files installed ? 
:: 
:: 
:: 