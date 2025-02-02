@echo off
setlocal enabledelayedexpansion

:: Skontrolujeme, Ëi je zadan˝ parameter (cesta k adres·ru)
if "%~1"=="" (
    echo Nezadali ste cestu k adresaru.
    echo Pouzitie: script.bat "Cesta\k\adresaru"
    goto :EOF
)

:: NastavÌme cestu k adres·ru
set "dirPath=%~1"

:: ZÌskanie aktu·lneho mesiaca a roka pomocou WMIC
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set datetime=%%a
set month=!datetime:~4,2!
set year=!datetime:~0,4!

:: ZÌskaù skr·ten˝ n·zov mesiaca (prvÈ 3 pÌsmen·)
for %%m in (
    Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
) do (
    set /a counter+=1
    if !counter! equ !month! set monthName=%%m
)

:: Skontrolovaù, Ëi uû v n·zve adres·ra je poûiadavka na mesiac a rok
for %%I in ("%dirPath%") do (
    set dirName=%%~nxI
    echo !dirName! | findstr /i "(%monthName% %year%)" >nul
    if !errorlevel! == 0 (
        echo Adresar uz obsahuje mesiac a rok v nazve: !dirName!
        goto :EOF
    )
)

:: Skontrolovaù, Ëi je adres·r odomknut˝
:: (Toto je len zjednoduöenÈ overenie - skutoËnÈ testovanie mÙûe byù komplexnejöie)
echo Testovanie prÌstupnosti adresara...
(
    >nul 2>&1 dir "%dirPath%"
) && (
    echo Adresar je dostupny a moze byt premenovany.
) || (
    echo Adresar nie je dostupny na premenovanie alebo je zamknuty.
    goto :EOF
)

:: Pridaù skr·ten˝ mesiac a rok do n·zvu adres·ra
set "newDirName=%dirName% (%monthName% %year%)"

:: Premenovaù adres·r
ren "%dirPath%" "%newDirName%"

echo Premenovanie dokoncene: "%dirName%" na "%newDirName%"
