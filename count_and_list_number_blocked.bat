@echo off
@setlocal enableextensions
@cd /d "%~dp0"
@title Count BlockList the .txt list of blocked programs

set /p "blockedProgramsFile=Enter the name of the blocked programs file.txt (must be in the same folder): "
if not "%blockedProgramsFile:~-4%"==".txt" set "blockedProgramsFile=%blockedProgramsFile%.txt"

for /f %%c in ('find /c /v "" ^< "%blockedProgramsFile%"') do set "lineCount=%%c"

echo Current Directory: %~dp0
echo Blocked Programs List: %blockedProgramsFile%
echo Total Number of Blocked Programs: %lineCount%

echo.
echo Blocked Programs:


for /f "tokens=*" %%a in ('type "%blockedProgramsFile%" ^| findstr /v /c:"add_firewall_blocklist.bat" /c:"count_and_list_number_blocked.bat" /c:"BlockedPrograms.txt" /c:"remove_firewall_blocklist.bat"') do (
    echo %%a
)

echo.
pause
echo Press any key to exit...
