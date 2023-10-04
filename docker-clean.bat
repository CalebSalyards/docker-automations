@echo off
set appname=BYU-I CIT %_fBCyan%Docker%_RESET% Cleanup Script
title %appname%
Set _fLGray=[37m
Set _fBRed=[91m
Set _fBGreen=[92m
Set _fBYellow=[93m
Set _fBCyan=[96m
Set _RESET=[0m
NET FILE
IF NOT %ERRORLEVEL% == 0 (cls & mode con:cols=32 lines=3 & echo ELEVATING SCRIPT & powershell "Start-Process -FilePath '%0' -Verb RunAs" & exit)
mode con:cols=80 lines=30
cls
echo.
echo %_fBGreen%%appname%%_RESET%
echo.
cd %TEMP%
echo The purpose of this application is to clean up an installation 
echo of %_fBCyan%Docker%_RESET% and its respective components automatically to free 
echo up any of the resources it researved for itself.
echo.
echo %_fBYellow%WARNING!%_RESET% If you proceed, %_fBCyan%Docker%_RESET% and all of its components will 
echo be automatically uninstalled and permanently lost. Please do 
echo not proceed unless you are okay with that.
echo.
pause

:detect%_fBCyan%Docker%_RESET%
cls
echo.
echo %_fBGreen%%appname%%_RESET%
echo.
echo %_fBGreen%STEP 1.%_RESET% Detecting %_fBCyan%Docker%_RESET% Desktop application and configuration
echo Searching for installation of %_fBCyan%Docker%_RESET%...
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Docker Desktop" >nul
if NOT %ERRORLEVEL% == 0 echo. && echo %_fBRed%ERROR!%_RESET% %_fBCyan%Docker%_RESET% appears to be improperly installed. & echo Please uninstall %_fBCyan%Docker%_RESET% manually before continuing. && echo. && pause && goto cleanUpDocker
echo %_fBCyan%Docker%_RESET% installation found.
timeout /t 1 /nobreak > NUL
:uninstallDocker
echo.
echo %_fBGreen%STEP 2.%_RESET% Uninstalling %_fBCyan%Docker%_RESET%
echo Running %_fBCyan%Docker%_RESET% ininstall command...%_fLGray%
FOR /F "tokens=2* skip=2" %%a in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Docker Desktop" /v "UninstallString"') do (start "" cmd /C start "" %%b >NUL 2>&1)
echo %_RESET%%_fBCyan%Docker%_RESET% uninstaller has been lauchned. 
echo Please echo %_fBGreen%follow the prompts and continue here%_RESET% once the uninstaller completes.
pause
timeout /t 1 /nobreak > NUL
:cleanUpDocker
echo.
echo %_fBGreen%STEP 3.%_RESET% Cleaning up Docker data
echo Attempting to remove any remaining WSL distrubutions...%_fLGray%
wsl --unregister %_fBCyan%Docker%_RESET%-desktop-data
wsl --unregister %_fBCyan%Docker%_RESET%-desktop

:turnOffWSL
timeout /t 1 /nobreak > NUL
echo.
echo %_fBGreen%STEP 4.%_RESET% Removing WSL
echo %_RESET%%_fBCyan%Docker%_RESET% may have turned on the %_fBCyan%Windows Subsystem for Linux%_RESET%.
choice /m "Would you like to turn it off? "
if %ERRORLEVEL% == 1 goto WSLoff
if %ERRORLEVEL% == 2 goto completed
pause
goto quit

:WSLoff
timeout /t 1 /nobreak > NUL
echo Turning of %_fBCyan%Windows Subsystem for Linux%_RESET%...%_fLGray%
dism.exe /online /disable-feature /featurename:Microsoft-Windows-Subsystem-Linux /norestart >nul
if NOT %ERRORLEVEL% == 3010 (echo %_fBYellow%WARNING!%_RESET% Something went wrong... & echo Search for 'Windows Features' and disable WSL manually.) else echo %_RESET%The %_fBCyan%Windows Subsystem for Linux%_RESET% has been turned off.
timeout /t 2 /nobreak > NUL
goto completed

:completed
timeout /t 1 /nobreak > NUL
cls
echo.
echo %_fBGreen%%appname%%_RESET%
echo.
echo %_fBGreen%Done! All unneeded resources have been freed.%_RESET%
echo You may need to reboot to ensure all changes have been completed.
choice /m "Would you like to reboot now? "
if %ERRORLEVEL% == 1 goto reboot
if %ERRORLEVEL% == 2 goto quit
goto quit

:reboot
echo Setting reboot countdown...
shutdown -r -t 61
timeout /t 3 /nobreak > NUL

:quit
echo Wrapping up. Thank's for dropping by!
timeout /t 3 /nobreak > NUL
exit