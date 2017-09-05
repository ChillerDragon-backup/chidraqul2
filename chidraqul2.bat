@echo off
set select_world=2
set cdir="C:\Users\%USERNAME%\AppData\Roaming\chidraqul\chidraqul2"
if not exist "%cdir%" (
echo Error opening chidraqul2 directory
goto failed 
)
if not exist "%cdir%\chidraqul2_world2.bat" (
echo Error opening chidraqul2_world2
goto failed 
)
if not exist "%cdir%\chidraqul2_world3.bat" (
echo Error opening chidraqul2_world3
goto failed 
)
:main
cls
if %select_world%==2 (
echo use the keys 'w' and 's' to select
echo press 'e' to start
echo.
echo.
echo ^>world2^<
echo  world3
) else (
echo use the keys 'w' and 's' to select
echo press 'e' to start
echo.
echo.
echo  world2
echo ^>world3^<
)
choice /c wseq /n >nul
if %errorlevel%==1 set select_world=2
if %errorlevel%==2 set select_world=3
if %errorlevel%==3 goto start
if %errorlevel%==4 exit
goto main
:start
if %select_world%==2 (
cls
call C:\Users\%USERNAME%\AppData\Roaming\chidraqul\chidraqul2\chidraqul2_world2.bat
exit
) else (
cls
call C:\Users\%USERNAME%\AppData\Roaming\chidraqul\chidraqul2\chidraqul2_world3.bat
exit
)
:failed
echo ################################
echo Failed loading chidraqul2.
echo Need help? Contact the dev on:
echo skype: BloodWork131
echo mail: chillerdragon@gmail.com
echo ################################
pause >nul
