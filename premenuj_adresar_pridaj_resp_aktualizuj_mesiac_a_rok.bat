@echo off
setlocal enabledelayedexpansion

:: Skontrolujeme, �i je zadan� parameter (cesta k adres�ru)
if "%~1"=="" (
    echo Nezadali ste cestu k adresaru.
    echo Pouzitie: script.bat "Cesta\k\adresaru"
    goto :EOF
)

:: Nastav�me cestu k adres�ru
set "dirPath=%~1"

:: Z�skanie aktu�lneho mesiaca a roka pomocou WMIC
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set datetime=%%a
set month=!datetime:~4,2!
set year=!datetime:~0,4!

:: Z�ska� skr�ten� n�zov mesiaca (prv� 3 p�smen�)
for %%m in (
    Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
) do (
    set /a counter+=1
    if !counter! equ !month! set monthName=%%m
)

:: Skontrolova�, �i n�zov adres�ra obsahuje mesiac a rok v z�tvork�ch na konci
set "dirName="
for %%I in ("%dirPath%") do (
    set dirName=%%~nxI
)

:: Skontrolujeme, �i n�zov obsahuje form�t (MMM YYYY) na konci
echo !dirName! | findstr /r "( [A-Za-z][a-z][a-z] [0-9][0-9][0-9][0-9] )$" >nul
if !errorlevel! == 0 (
    :: Ak n�zov kon�� z�tvorkami, odstr�nime ich a prid�me nov� mesiac a rok
    echo N�zov obsahuje mesiac a rok: !dirName!

    :: Odstr�nime star� mesiac a rok z konca n�zvu
    set "dirName=!dirName:~0,-10!"

    :: Pripoj�me nov� mesiac a rok
    set "newDirName=!dirName!(%monthName% %year%)"

    :: Premenova� adres�r
    ren "%dirPath%" "!newDirName!"
    echo Premenovanie dokoncene: !dirName! na !newDirName!
    goto :EOF
)

:: Ak n�zov neobsahuje mesiac a rok, prid�me ich na koniec
set "newDirName=%dirName% (%monthName% %year%)"
ren "%dirPath%" "%newDirName%"
echo Premenovanie dokoncene: "%dirName%" na "%newDirName%"
