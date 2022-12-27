@echo off
setlocal disableDelayedExpansion
set q=^"
echo(
echo(
::!q! - кавычка

::call :c 0F "00 - "&call :c 00 "TEST" /n
::call :c 0F "11 - "&call :c 11 "TEST" /n
::call :c 0F "22 - "&call :c 22 "TEST" /n
::call :c 0F "33 - "&call :c 33 "TEST" /n
::call :c 0F "44 - "&call :c 44 "TEST" /n
::call :c 0F "55 - "&call :c 55 "TEST" /n
::call :c 0F "66 - "&call :c 66 "TEST" /n
::call :c 0F "77 - "&call :c 77 "TEST" /n
::call :c 0F "88 - "&call :c 88 "TEST" /n
::call :c 0F "99 - "&call :c 99 "TEST" /n
::call :c 0F "AA - "&call :c AA "TEST" /n
::call :c 0F "BB - "&call :c BB "TEST" /n
::call :c 0F "CC - "&call :c CC "TEST" /n
::call :c 0F "DD - "&call :c DD "TEST" /n
::call :c 0F "EE - "&call :c EE "TEST" /n
::call :c 0F "FF - "&call :c FF "TEST" /n

goto conuser
:conuser
if "%1" == "runas" (
	goto rcomp
)
set ruser=
set cuser=0
mode con:cols=90 lines=4
cls
echo.
call :c 0E "Enter "& call :c 4F "user"& call :c 0E " for connection to Remote PC: "& call :c 06 "Or leave it blank for "& call :c 4F "%USERNAME%" /n
call :c 4F "#"& call :c 04 ">" & set /P ruser=""
if "%ruser%"=="" (
 set ruser=%USERNAME%
 goto rcomp
) 
set cuser=1
::
:rrunas
mode con:cols=90 lines=5
set shadowPath="C:\Users\Public\shadow.bat"
copy %~dpnx0 %shadowPath% /Y >NUL  2>NUL
runas /user:%ruser% "%shadowPath% runas"
if errorlevel 1 (
	cls
	mode con:cols=60 lines=4
	echo.
	call :c 0E "Username or password "& call :c 4F "incorrent"& call :c 0E ", try again dude" /n
	pause
	goto conuser
)
exit
:rcomp
cls
mode con:cols=60 lines=4
set rcomp=
echo.
call :c 0E "Enter "& call :c 4F "name"& call :c 0E " or "& call :c 4F "IP"& call :c 0E " of a Remote PC: " /n
call :c 4F "#"& call :c 04 ">" & set /P rcomp=""
::
:erport
set rport=
if "%rcomp%"=="" (
 goto rcomp
) 
mode con:cols=70 lines=4
cls
color 04
echo.
call :c 0E "Enter "& call :c 4F "port"& call :c 0E " of a Remote PC: "& call :c 06 "Or leave it blank for default "& call :c 4F "3389" /n
call :c 4F "#"& call :c 04 ">" & set /P rport=""
if "%rport%"=="" (
 set rport=3389
) 
:rrid
set rid=
cls
if "%rcomp%"=="" (
 goto rcomp
) 
mode con:cols=80 lines=30
echo.
color 0F
call :c 0E "Server: "& call :c 4F "%rcomp%" /n
call :c 0E "Port: "& call :c 4F "%rport%" /n
query session /server:%rcomp%
call :c 0E "Enter RDP user "& call :c 4F "ID" /n
call :c 0E "Or Type "& call :c 4F "  n  "& call :c 0E " For Normal/Not shadow RDP" /n
call :c 4F "#"& call :c 04 ">" & set /P rid=""
:erid
set contype=
cls
if "%rid%"=="" (
 goto rrid
) 
if /I "%rid%"=="n" (
 goto normrdp
) 
mode con:cols=40 lines=11
echo.
call :c 0E "Server: "& call :c 4F "%rcomp%" /n
call :c 0E "User ID: "& call :c 4F "%rid%" /n
call :c 4F "Type "& call :c 0E " of connection:" /n
call :c 4F "  1  "& call :c 0E " - Just view" /n 
call :c 4F "  2  "& call :c 0E " - Just view without prompt" /n
call :c 4F "  3  "& call :c 0E " - Control" /n
call :c 4F "  4  "& call :c 0E " - Control without prompt" /n
:contype
call :c 0E "Select connection "& call :c 4F "type" /n
call :c 4F "#"& call :c 04 ">" & set /P contype=""
mode con:cols=85 lines=15
if "%contype%"=="1" (
 goto contype%contype%
) 
if "%contype%"=="2" (
 goto contype%contype%
) 
if "%contype%"=="3" (
 goto contype%contype%
) 
if "%contype%"=="4" (
 goto contype%contype%
) else (
	if "%contype%"=="" (
		goto erid
	) else (
		goto erid
	)
)
set contype = ""
goto go
:go
call :c 4F "%rcomp%"& call :c 0E " with user ID "& call :c 4F "%rid%" /n
start mstsc /v:%rcomp% /shadow:%rid% %contype2%

:whatnext
echo.
set nextt=
call :c 0E "Type "& call :c 4F "1"& call :c 0E " for "& call :c 4F "other RDP"& call :c 0E " connection " /n
call :c 0E "Or type "& call :c 4F "0"& call :c 0E " for "& call :c 4F "exit" /n
call :c 4F "#"& call :c 04 ">" & set /P nextt=""
if "%nextt%"=="0" (
 goto exitt
) 
if "%nextt%"=="1" (
 goto :rcomp
) else (
 cls
 goto whatnext
)
:normrdp 
cls
echo.
call :c 0E "Normal RDP connecting to server "& call :c 4F "%rcomp%"& call :c 0E ".."
start mstsc /v:%rcomp%:%rport%
echo.
goto whatnext

:contype1
set contype2=
cls
echo.
call :c 0E "Starting viewing for server "
goto go
:contype2
cls
echo.
set contype2=/noconsentprompt
call :c 0E "Starting viewing without prompt for server "
goto go
:contype3
cls
echo.
set contype2=/control
call :c 0E "Starting shadow control for server "
goto go
:contype4
cls
echo.
set contype2=/noconsentprompt /control
call :c 0E "Starting shadow control without prompt for server "
goto go
:exitt
exit

echo(

exit /b

:c
setlocal enableDelayedExpansion
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:colorPrint Color  Str  [/n]
setlocal
set "s=%~2"
call :colorPrintVar %1 s %3
exit /b

:colorPrintVar  Color  StrVar  [/n]
if not defined DEL call :initColorPrint
setlocal enableDelayedExpansion
pushd .
':
cd \
set "s=!%~2!"
:: The single blank line within the following IN() clause is critical - DO NOT REMOVE
for %%n in (^"^

^") do (
  set "s=!s:\=%%~n\%%~n!"
  set "s=!s:/=%%~n/%%~n!"
  set "s=!s::=%%~n:%%~n!"
)
for /f delims^=^ eol^= %%s in ("!s!") do (
  if "!" equ "" setlocal disableDelayedExpansion
  if %%s==\ (
    findstr /a:%~1 "." "\'" nul
    <nul set /p "=%DEL%%DEL%%DEL%"
  ) else if %%s==/ (
    findstr /a:%~1 "." "/.\'" nul
    <nul set /p "=%DEL%%DEL%%DEL%%DEL%%DEL%"
  ) else (
    >colorPrint.txt (echo %%s\..\')
    findstr /a:%~1 /f:colorPrint.txt "."
    <nul set /p "=%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%"
  )
)
if /i "%~3"=="/n" echo(
popd
exit /b


:initColorPrint
for /f %%A in ('"prompt $H&for %%B in (1) do rem"') do set "DEL=%%A %%A"
<nul >"%temp%\'" set /p "=."
subst ': "%temp%" >nul
exit /b


:cleanupColorPrint
2>nul del "%temp%\'"
2>nul del "%temp%\colorPrint.txt"
>nul subst ': /d
exit /b