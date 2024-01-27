@echo off
@title [FWB.bat] Remove to BlockList and Firewall [fwb-bat.e-girl.eu.org]
@setlocal enableextensions
@setlocal enabledelayedexpansion
@cd /d "%~dp0"

>nul 2>&1 net session || (
    call :displayArt
    echo The script requires administrative privileges to act on the Windows Firewall.
    echo Restart it as administrator.
    echo.
    pause
    exit /b
)

call :displayArt
echo *: (must be in the same folder and leave blank for default name)
set /p "blockedProgramsFile=Enter the name of the blocked programs file.txt* : "
if not defined blockedProgramsFile set "blockedProgramsFile=BlockedPrograms.txt"
if not "%blockedProgramsFile:~-4%"==".txt" set "blockedProgramsFile=%blockedProgramsFile%.txt"

call :displayArt
echo Currently unblocks Internet access via the firewall to all executable files with one of its extensions :
echo *.exe, *.bat, *.com, *.cmd, *.sh, *.ps1, *.sh, *.bin, *.run, *.out, *.command, *.app, *.elf, *.jar, 
echo *.py, *.pl, *.deb, *.rpm, *.tar.gz, *.tar, *.xz, *.zip, *.dmg, *.app, *.pkg, *.js, *.html, *.rb, 
echo *.gem, *.java, *.class, *.jsp, *.war, *.html, *.htm, *.css, *.scss, *.less, *.sass, *.php,
echo *.py, *.pyc, *.pyo, *.pyd, *.lua
for /r %%f in (*.txt) do (
    if /i "%%~nxf" neq "add_firewall_blocklist.bat" if /i "%%~nxf" neq "count_and_list_number_blocked.bat" if /i "%%~nxf" neq "BlockedPrograms.txt" if /i "%%~nxf" neq "%~nx0" if /i "%%~nxf" neq "remove_firewall_blocklist.bat" (
        for /f "usebackq tokens=*" %%l in ("%%f") do (
            netsh advfirewall firewall delete rule name="%%l" >>nul
        )
    )
)

call :displayArt
echo All programs have been unblocked from the firewall blocklist.
echo The list of blocked programs has been saved to %blockedProgramsFile%.
set /p "viewList=Do you want to view the list of unblocked programs? [y/N]: "

if /i "%viewList%"=="y" (
    call :displayArt
    echo The list of executables concerned is as follows.
    echo.
    type "%blockedProgramsFile%"
    echo.
    pause
)

echo.
pause
exit /b

:displayArt
cls
echo [-]   Firewall       Blocklist
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