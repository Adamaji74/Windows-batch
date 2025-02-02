@echo off
setlocal enabledelayedexpansion

:: Skontroluj, či bol zadaný URL ako parameter
if "%~1"=="" (
    echo Zadajte URL súboru.
    exit /b
)

:: Získaj hlavičky pomocou curl a vyextrahuj hodnotu Content-Length
for /f "tokens=2 delims=:" %%a in ('curl -I %1 2^>nul ^| findstr /i "Content-Length"') do (
    set file_size=%%a
)

:: Odstránenie medzier z výsledku
set file_size=%file_size: =%

:: Ak nebola nájdená veľkosť, vypíše chybovú hlášku
if "%file_size%"=="" (
    echo Nemôžem získať veľkosť súboru z URL.
    exit /b
)

:: Formátovanie čísla s oddelením tisícov
set formatted_size=
set /a length=0

:: Prechádzaj každou číslicou a formátuj číslo
for /l %%i in (0,1,1000) do (
    set digit=!file_size:~%%i,1!
    if "!digit!" neq "" (
        set formatted_size=!formatted_size!!digit!
        set /a length+=1
    )
    if !length! geq 3 (
        set formatted_size=!formatted_size!,!
        set length=0
    )
)

:: Odstránenie poslednej čiarky, ak existuje
if "!formatted_size:~-1!"=="," (
    set formatted_size=!formatted_size:~0,-1!
)

:: Vytlačí veľkosť súboru s formátovaním
echo Velkost: !formatted_size!

endlocal
