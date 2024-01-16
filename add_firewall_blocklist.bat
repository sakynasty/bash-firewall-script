@echo off
@title Add to BlockList and Firewall all .exe, .bat, .sh, .ps1 of this folder and sub-folder
@setlocal enableextensions
@cd /d "%~dp0"

set "outputFile=%~dp0\BlockedPrograms.txt"

if exist "%outputFile%" del "%outputFile%"

for /R %%f in (*.exe *.bat *.sh *.ps1) do (
    if /i "%%~nxf" neq "add_firewall_blocklist.bat" if /i "%%~nxf" neq "count_and_list_number_blocked.bat" if /i "%%~nxf" neq "BlockedPrograms.txt" if /i "%%~nxf" neq "remove_firewall_blocklist.bat" (
        echo Blocking program: %%f
	echo.
        netsh advfirewall firewall add rule name="Blocked Out: %%f" dir=out program="%%f" action=block
        echo Blocked Out: %%f

        netsh advfirewall firewall add rule name="Blocked In: %%f" dir=in program="%%f" action=block
        echo Blocked In: %%f

        echo %%f >> "%outputFile%"
    )
)

echo All programs have been blocked by the firewall.
echo The list of blocked programs has been saved to "%outputFile%".
pause
