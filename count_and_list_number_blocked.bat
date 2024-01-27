@echo off
@title [FWB.bat] Count and List to BlockList [fwb-bat.e-girl.eu.org]
@setlocal enableextensions
@cd /d "%~dp0"


call :displayArt
echo *: (must be in the same folder and leave blank for default name)
set /p "blockedProgramsFile=Enter the name of the blocked programs file.txt* : "
if not defined blockedProgramsFile set "blockedProgramsFile=BlockedPrograms.txt"
if not "%blockedProgramsFile:~-4%"==".txt" set "blockedProgramsFile=%blockedProgramsFile%.txt"

cls
for /f %%c in ('find /c /v "" ^< "%blockedProgramsFile%"') do set "lineCount=%%c"

call :displayArt
echo Current Directory: %~dp0
echo Blocked Programs List: %blockedProgramsFile%
echo Total Number of Blocked Programs: %lineCount%

echo.
echo Blocked Programs:


for /f "tokens=*" %%a in ('type "%blockedProgramsFile%" ^| findstr /v /c:"add_firewall_blocklist.bat" /c:"count_and_list_number_blocked.bat" /c:"BlockedPrograms.txt" /c:"remove_firewall_blocklist.bat" /c:"%~nx0"') do (
    echo %%a
)

echo.
echo All programs have been counted from the firewall blocklist.
echo The list of blocked programs has been saved to %blockedProgramsFile%.
echo.
pause
echo Press any key to exit...

:displayArt
cls
echo [?]      Count       Blocklist
echo 8888888888 888       888 888888b.       888               888
echo 888        888   o   888 888  "88b      888               888
echo 888        888  d8b  888 888  .88P      888               888
echo 8888888    888 d888b 888 8888888K.      88888b.   8888b.  888888
echo 888        888d88888b888 888  "Y88b     888 "88b     "88b 888
echo 888        88888P Y88888 888    888     888  888 .d888888 888
echo 888        8888P   Y8888 888   d88P d8b 888 d88P 888  888 Y88b.
echo 888        888P     Y888 8888888P"  Y8P 88888P"  "Y888888  "Y888
echo 2024      (C) fwb-bat.e-girl.eu.org
echo.