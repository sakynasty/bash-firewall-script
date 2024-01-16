@echo off
@title Remove to BlockList and Firewall all .exe, .bat, .sh, .ps1 of this folder and sub-folder
setlocal enabledelayedexpansion

set "blocklistFolder=%~dp0"

for /r "%blocklistFolder%" %%f in (*.txt) do (
    if /i "%%~nxf" neq "add_firewall_blocklist.bat" if /i "%%~nxf" neq "count_and_list_number_blocked.bat" if /i "%%~nxf" neq "BlockedPrograms.txt" if /i "%%~nxf" neq "remove_firewall_blocklist.bat" (
        echo Processing file: %%~nxf
        echo.

        for /f "usebackq tokens=*" %%l in ("%%f") do (
            echo Removing program: %%l
            netsh advfirewall firewall delete rule name="%%l"
        )

        echo.
    )
)

echo All programs have been removed from the firewall blocklist.
pause
