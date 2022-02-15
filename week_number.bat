:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Mod:  Pierre AREFIEV, 2022-02-15
::
:: Func: Based on DateToWeek with some modification to print
::    the current week only
::
:: Args: %1 day of the target week
::       %2 month of the target week
::       %3 year of the target week
::
:: Out:  Prints wanted week number
:: 
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

@echo off

set day=%1
set month=%2
set year=%3
set cw=0

if [%1]==[] echo no day & goto :eof
if [%2]==[] echo no month & goto :eof
if [%3]==[] echo no year & goto :eof

call :DateToWeek %year% %month% %day%
echo Target week is: %cw%
goto :EOF


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:DateToWeek %yy% %mm% %dd% 
::
:: By:   Ritchie Lawrence, Updated 2002-11-20. Version 1.1
::
:: Func: Returns given week number
:: 
:: Args: %1 year component to be converted, 2 or 4 digits (by val)
::       %2 month component to be converted, leading zero ok (by val)
::       %3 day of month to be converted, leading zero ok (by val)
::       %4 var to receive year, 4 digits (by ref)
::       %5 var to receive calendar week, 2 digits, 01 to 53 (by ref)
::       %6 var to receive day of week, 1 digit, 1 to 7 (by ref)
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set yy=%1&set mm=%2&set dd=%3
if 1%yy% LSS 200 if 1%yy% LSS 170 (set yy=20%yy%) else (set yy=19%yy%)
set /a dd=100%dd%%%100,mm=100%mm%%%100
set /a z=14-mm,z/=12,y=yy+4800-z,m=mm+12*z-3,Jd=153*m+2
set /a Jd=Jd/5+dd+y*365+y/4-y/100+y/400-32045
set /a y=yy+4798,Jp=y*365+y/4-y/100+y/400-31738,t=Jp+3,Jp=t-t%%7
set /a y=yy+4799,Jt=y*365+y/4-y/100+y/400-31738,t=Jt+3,Jt=t-t%%7
set /a y=yy+4800,Jn=y*365+y/4-y/100+y/400-31738,t=Jn+3,Jn=t-t%%7
if %Jd% GEQ %Jn% (set /a Jr=%Jn%) else (if %Jd% GEQ %Jt% set /a Jr=%Jt%)
set /a diff=Jd-Jr,cw=diff/7+1
