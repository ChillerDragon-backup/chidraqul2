@echo off
color 07
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
if not exist "%cdir%\changelog\changelog_size.txt" (
echo Error loading changelog size
echo press any key to continue to main menu
pause >nul
goto main
)
set /p pages=<%cdir%\changelog\changelog_size.txt
set /a page=%pages%
call :print_changelog
:changelog
choice /c wseq /n >nul
if %errorlevel%==1 call :page_up
if %errorlevel%==2 call :page_down
if %errorlevel%==3 goto main
if %errorlevel%==4 goto main
goto changelog
:main
cls
if %select_world%==1 (
echo use the keys 'w' and 's' to select
echo press 'e' to start
echo.
echo ^>inf_world2^<
echo  world2
echo  world3
) else if %select_world%==2 (
echo use the keys 'w' and 's' to select
echo press 'e' to start
echo.
echo  inf_world2
echo ^>world2^<
echo  world3
) else if %select_world%==3 (
echo use the keys 'w' and 's' to select
echo press 'e' to start
echo.
echo  inf_world2
echo  world2
echo ^>world3^<
)
choice /c wseq /n >nul
if %errorlevel%==1 call :option_up
if %errorlevel%==2 call :option_down
if %errorlevel%==3 goto start
if %errorlevel%==4 exit
goto main
exit /b 0
:option_up
if %select_world% gtr 1 ( set /a select_world=%select_world%-1)
exit /b 0
:option_down
if %select_world% lss 3 ( set /a select_world=%select_world%+1)
exit /b 0
:start
if %select_world%==2 (
cls
call C:\Users\%USERNAME%\AppData\Roaming\chidraqul\chidraqul2\chidraqul2_world2.bat
exit
) else if %select_world%==3 (
cls
call C:\Users\%USERNAME%\AppData\Roaming\chidraqul\chidraqul2\chidraqul2_world3.bat
exit
) else if %select_world%==1 (
cls
call C:\Users\%USERNAME%\AppData\Roaming\chidraqul\chidraqul2\chidraqul2_inf_world2.bat
exit
) else (
echo something went wrong
)
exit /b 0
:failed
echo ################################
echo Failed loading chidraqul2.
echo Need help? Contact the dev on:
echo skype: BloodWork131
echo mail: chillerdragon@gmail.com
echo ################################
pause >nul
exit /b 0
:page_down
if %page% gtr 0 ( set /a page=%page%-1 )
call :print_changelog
exit /b 0
:page_up
if %page% lss %pages% ( set /a page=%page%+1 )
call :print_changelog
exit /b 0
:print_changelog
cls
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo          CHIDRAQUL2
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo 'w' and 's' to change page 'e' start
echo page %page%/%pages%
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
type %cdir%\changelog\changelog%page%.txt
exit /b 0
