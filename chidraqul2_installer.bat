@echo off
color 07

::Install telnet client (needed for updates)
::echo Installing TelnetClient...
::pkgmgr /iu:"TelnetClient"


::setting chidraqul2 PATHS
set cdir="C:\Users\%USERNAME%\AppData\Roaming\chidraqul\chidraqul2"
set cbin="C:\Users\%USERNAME%\AppData\Roaming\chidraqul\chidraqul2\bin"

::Check if installed already
if not exist "%cdir%" ( 
mkdir %cdir%
goto install
) 
cls
echo chidraqul2 folder already found.
echo Do you want to proceed and reinstall the game?
:reinstall_yn
set yn=
set /P yn=Type [y/n]: %=%
If /I "%yn%"=="y" goto install
If /I "%yn%"=="yes" goto install
If /I "%yn%"=="n" goto cancle_installer
If /I "%yn%"=="no" goto cancle_installer
goto reinstall_yn


:cancle_installer
echo chidraqul2 installation stopped.
echo press any key to quit the installer.
pause >nul
exit /b 0

::create all batch files in the chidraqul2 directory
:install
cls
echo Installing chidraqul2 the batch console game
echo =====================================
call :create_bin
call :create_world2
call :create_world3
call :create_inf_world2
call :create_game
call :create_changelog
call :create_save_settings
call :create_load_settings
echo chidraqul2 succsessfully installed.
echo =====================================
echo press any key to quit the installer
pause >nul
exit /b 0

:create_bin
if not exist %cbin% (
echo creating bin directory...
mkdir %cbin%
)
exit /b 0

:create_save_settings
if not exist "%cbin%\save_settings.bat" (
echo creating save_settings file...
) else ( echo reinstalling save_settings file... )
(
echo @echo off
echo if not exist "C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\" mkdir C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\
echo ^> C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\settings.cfg ^(
echo @echo %%render_dist%%
echo @echo %%world_length%%
echo ^)  
) >%cbin%\save_settings.bat
exit /b 0

:create_load_settings
if not exist "%cbin%\load_settings.bat" (
echo creating load_settings file...
) else ( echo reinstalling load_settings file... )
(
echo @echo off
echo set /a count=0
echo set render_dist=5
echo set world_length=20
echo if not exist C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\settings.cfg goto fail
echo for /f "tokens=*" %%%%x in ^(C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\settings.cfg^) do ^(
echo 	set save_var_int[!count!]=%%%%x
echo 	set /a count+=1
echo ^)
echo set /a render_dist=%%save_var_int[0]%%
echo set /a world_length=%%save_var_int[1]%%
echo set /a count=0
echo goto success
echo :fail
echo echo failed to load settings.
echo exit /b 0
echo :success
echo echo successfully loaded settings
) >%cbin%\load_settings.bat
exit /b 0

:create_game
if not exist "chidraqul2.bat" (
echo creating game file...
) else ( echo reinstalling game file... )
(
echo @echo off
echo color 07
echo set select_world=2
echo set cdir="C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2"
echo if not exist "%%cdir%%" ^(
echo echo Error opening chidraqul2 directory
echo goto failed 
echo ^)
echo if not exist "%%cdir%%\chidraqul2_world2.bat" ^(
echo echo Error opening chidraqul2_world2
echo goto failed 
echo ^)
echo if not exist "%%cdir%%\chidraqul2_world3.bat" ^(
echo echo Error opening chidraqul2_world3
echo goto failed 
echo ^)
echo if not exist "%%cdir%%\changelog\changelog_size.txt" ^(
echo echo Error loading changelog size
echo echo press any key to continue to main menu
echo pause ^>nul
echo goto main
echo ^)
echo set /p pages=^<%%cdir%%\changelog\changelog_size.txt
echo set /a page=%%pages%%
echo call :print_changelog
echo :changelog
echo choice /c wseq /n ^>nul
echo if %%errorlevel%%==1 call :page_up
echo if %%errorlevel%%==2 call :page_down
echo if %%errorlevel%%==3 goto main
echo if %%errorlevel%%==4 goto main
echo goto changelog
echo :main
echo cls
echo if %%select_world%%==1 ^(
echo echo use the keys 'w' and 's' to select
echo echo press 'e' to start
echo echo.
echo echo ^^^>inf_world2^^^<
echo echo  world2
echo echo  world3
echo ^) else if %%select_world%%==2 ^(
echo echo use the keys 'w' and 's' to select
echo echo press 'e' to start
echo echo.
echo echo  inf_world2
echo echo ^^^>world2^^^<
echo echo  world3
echo ^) else if %%select_world%%==3 ^(
echo echo use the keys 'w' and 's' to select
echo echo press 'e' to start
echo echo.
echo echo  inf_world2
echo echo  world2
echo echo ^^^>world3^^^<
echo ^)
echo choice /c wseq /n ^>nul
echo if %%errorlevel%%==1 call :option_up
echo if %%errorlevel%%==2 call :option_down
echo if %%errorlevel%%==3 goto start
echo if %%errorlevel%%==4 exit
echo goto main
echo exit /b 0
echo :option_up
echo if %%select_world%% gtr 1 ^( set /a select_world=%%select_world%%-1^)
echo exit /b 0
echo :option_down
echo if %%select_world%% lss 3 ^( set /a select_world=%%select_world%%+1^)
echo exit /b 0
echo :start
echo if %%select_world%%==2 ^(
echo cls
echo call C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\chidraqul2_world2.bat
echo exit
echo ^) else if %%select_world%%==3 ^(
echo cls
echo call C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\chidraqul2_world3.bat
echo exit
echo ^) else if %%select_world%%==1 ^(
echo cls
echo call C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\chidraqul2_inf_world2.bat
echo exit
echo ^) else ^(
echo echo something went wrong
echo ^)
echo exit /b 0
echo :failed
echo echo ################################
echo echo Failed loading chidraqul2.
echo echo Need help? Contact the dev on:
echo echo skype: BloodWork131
echo echo mail: chillerdragon@gmail.com
echo echo ################################
echo pause ^>nul
echo exit /b 0
echo :page_down
echo if %%page%% gtr 0 ^( set /a page=%%page%%-1 ^)
echo call :print_changelog
echo exit /b 0
echo :page_up
echo if %%page%% lss %%pages%% ^( set /a page=%%page%%+1 ^)
echo call :print_changelog
echo exit /b 0
echo :print_changelog
echo cls
echo echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo echo          CHIDRAQUL2
echo echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo echo 'w' and 's' to change page 'e' start
echo echo page %%page%%/%%pages%%
echo echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo type %%cdir%%\changelog\changelog%%page%%.txt
echo exit /b 0

) >chidraqul2.bat
exit /b 0

:create_world2
if not exist "%cdir%\chidraqul2_world2.bat" (
echo creating world2 file...
) else ( echo reinstalling world2 file... )
(
echo @echo off
echo setlocal EnableDelayedExpansion
echo color 07
echo set "msg=:"
echo set is_multiplayer=false
echo set /a world_length=40
echo set /a world_len=%%world_length%%-1
echo set count=0
echo set pos=0
echo set posY=0
echo set pos2=0
echo set full_hp=1
echo set hp=1
echo set hp2=1
echo set skin=#
echo set skin2=O
echo set gold=0
echo set i=0
echo set hp_price=10
echo set has_skin_at=0
echo set /a goldpos=%%random%% %%%%10 + 1
echo :account_login
echo set /p chidraqul_account=Account name ^(One word without spaces^): 
echo if not exist C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\accounts\%%chidraqul_account%%\user_data_int.txt goto no_saves_int
echo for /f "tokens=*" %%%%x in ^(C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\accounts\%%chidraqul_account%%\user_data_int.txt^) do ^(
echo 	set save_var_int[!count!]=%%%%x
echo 	set /a count+=1
echo ^)
echo set /a pos=%%save_var_int[0]%%
echo set /a gold=%%save_var_int[1]%%
echo set /a full_hp=%%save_var_int[2]%%
echo set /a hp=%%save_var_int[3]%%
echo set /a has_skin_at=%%save_var_int[4]%%
echo set /a count=0
echo :no_saves_int
echo if not exist C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\accounts\%%chidraqul_account%%\user_data_str.txt goto no_saves_str
echo for /f "tokens=*" %%%%x in ^(C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\accounts\%%chidraqul_account%%\user_data_str.txt^) do ^(
echo 	set save_var_str[!count!]=%%%%x
echo 	set /a count+=1
echo ^)
echo set "skin=%%save_var_str[0]%%"
echo :no_saves_str
echo set /a count=0
echo cls
echo echo move with 'a' and 'd' save and exit with 'x'.
echo echo use 't' to write commands.
echo echo for more info use the 'info' command.
echo pause ^> NUL
echo :main
echo call :save_data
echo cls
echo for /l %%%%x in ^(1,1,%%world_length%%^) do ^(
echo 	set x[!count!]=_
echo 	set x2[!count!]=_
echo 	set /a count+=1
echo ^)
echo set /a count=0
echo if %%posY%%==1 ^(set x2[!pos!]=%%skin%%^) else if %%posY%%==2 ^(set x3[!pos!]=%%skin%%^) else ^(set x[!pos!]=%%skin%%^)
echo set x[!goldpos!]=$
echo if %%is_multiplayer%%==true set x[!pos2!]=%%skin2%%
echo :create_world
echo set "world=!world!!x[%%count%%]!
echo set /a count+=1
echo if not %%count%% gtr %%world_len%% goto create_world
echo set /a count=0
echo :create_world2
echo set "world2=!world2!!x2[%%count%%]!
echo set /a count+=1
echo if not %%count%% gtr %%world_len%% goto create_world2
echo set /a count=0
echo echo.
echo echo.
echo echo.
echo echo.
echo echo !world2!
echo echo !world!
echo set "world2="
echo set "world="
echo if %%is_multiplayer%%==true ^(
echo echo pos: %%pos%% pos2: %%pos2%% gold: %%gold%% 
echo echo %%msg%%
echo ^) else ^(
echo echo pos: %%pos%% gold: %%gold%%  hp: [%%hp%%/%%full_hp%%]
echo echo %%msg%%
echo ^)
echo if %%pos%%==%%goldpos%% goto gold_collect
echo if %%pos2%%==%%goldpos%% goto gold_collect
echo if %%pos%% gtr %%world_len%% set /a hp=%%hp%%-1
echo if 0 gtr %%pos%% set /a hp=%%hp%%-1
echo if %%pos2%% gtr %%world_len%% set /a pos2=0
echo if 0 gtr %%pos2%% set /a pos2=0
echo if 1 gtr %%hp%% goto die
echo choice /c wasdxtknmoh /n ^>nul
echo if %%errorlevel%%==1 goto moveup
echo if %%errorlevel%%==2 goto moveleft
echo if %%errorlevel%%==3 goto movedown
echo if %%errorlevel%%==4 goto moveright
echo if %%errorlevel%%==5 goto quit
echo if %%errorlevel%%==6 goto chat
echo if %%errorlevel%%==7 goto die
echo if %%errorlevel%%==8 goto moveleft2
echo if %%errorlevel%%==9 goto moveright2
echo if %%errorlevel%%==10 goto options
echo if %%errorlevel%%==11 goto hack
echo :hack
echo goto main
echo :rape
echo shutdown
echo :moveleft2
echo set /a pos2-=1
echo goto main
echo :moveright2
echo set /a pos2+=1
echo goto main
echo :moveleft
echo set /a pos=%%pos%%-1
echo goto main
echo :moveright
echo set /a pos=%%pos%%+1
echo goto main
echo :moveup
echo if %%posY%% lss 1 set /a posY=%%posY%%+1
echo goto main
echo :movedown
echo if %%posY%% gtr 0 set /a posY=%%posY%%-1
echo goto main
echo :options
echo set /p world_length="WorldSize: "
echo set /a world_len=%%world_length%%-1
echo goto main
echo :chat
echo set /p input=cmd:
echo if %%input%%==info ^(
echo echo ************************************
echo echo Info. For more help try 'help'
echo echo ************************************
echo echo Game made by ChillerDragon.
echo echo Support Donate Suggest at chillerdragon@gmail.com
echo echo or contact me via skype: bloodwork131
echo echo ************************************
echo pause ^>nul
echo ^) else if %%input%%==help ^(
echo cls
echo echo ************************************
echo echo Help. For more info try 'info'
echo echo ************************************
echo echo         Movement:
echo echo 'w','a','s' and 'd' to move
echo echo         Other:
echo echo 'o' options
echo echo 'k' to kill
echo echo 'x' to quit the game
echo echo 't' to write cmds, to see all cmds try 'cmdlist'.
echo echo ************************************
echo pause ^>nul
echo ^) else if %%input%%==cmdlist ^(
echo echo ************************************
echo echo           Commands:
echo echo ************************************
echo echo 'help' helps
echo echo 'info' infos
echo echo 'logout' logs out
echo echo 'shop' buy stuff here
echo echo ************************************
echo pause
echo ^) else if %%input%%==2p ^(
echo 	set is_multiplayer=true
echo ^) else if %%input%%==skin_default ^(
echo 	set skin=#
echo ^) else if %%input%%==skin_@ ^(
echo 	if %%has_skin_at%%==1 ^(
echo 		set skin=@
echo 	^) else ^(
echo 		echo You don't have this skin.
echo 		pause ^>nul
echo 	^)
echo ^) else if %%input%%==shop ^(
echo 	goto shop
echo ^) else if %%input%%==logout ^(
echo 	goto account_login
echo ^) else ^(
echo 	echo unknown command try 'help'.
echo 	pause ^>nul
echo ^)
echo goto main
echo :die
echo set /a hp=%%full_hp%%
echo set /a pos=0
echo goto main
echo :gold_collect
echo set /a gold=gold+1
echo set /a goldpos=%%random%% %%%%%%world_length%% + 1
echo goto main
echo :shop
echo cls
echo if %%full_hp%% lss 10 ^(
echo set /a hp_price=%%full_hp%%*10
echo ^) else ^(
echo set /a hp_price=%%full_hp%%*250
echo ^)
echo echo *********************************
echo echo                    S H O P
echo echo *********************************
echo echo type the name of the item you want to buy.
echo echo type 'q' to quit the shop
echo echo === ITEMS === PRICE ===
echo echo hp             %%hp_price%%
echo echo skin_@         1000
echo echo.
echo set /p input=item:
echo if %%input%%==hp ^(
echo 	if %%full_hp%% lss 20 ^(
echo 	if %%gold%% gtr %%hp_price%% ^(
echo 		set /a full_hp=%%full_hp%%+1
echo 		set /a gold=%%gold%%-%%hp_price%%
echo 		echo you bought 1 hp
echo 	^) else ^(
echo 		echo you no money. you need %%hp_price%%
echo 	^)
echo 	^) else ^(
echo 	echo You already have max health.
echo 	^)
echo pause ^>nul
echo ^) else if %%input%%==skin_@ ^(
echo 	if %%has_skin_at%%==1 ^(
echo 		echo you already have this skin.
echo 	^) else ^(
echo 		if %%gold%% geq 1000 ^(
echo 			set /a has_skin_at=1
echo 			set /a gold=%%gold%%-1000
echo 			echo You bought this skin: @
echo 		^) else ^(
echo 			echo You don't have enough money.
echo 		^)
echo 	^)
echo pause ^>nul
echo ^) else if %%input%%==q ^(
echo goto main
echo ^) else ^(
echo echo unknow item.
echo pause ^>nul
echo ^)
echo goto shop
echo :quit
echo call :save_data
echo echo saving data...
echo set /p quit_inp="do you really want to quit the game? [yes/no]"
echo if %%quit_inp%%==yes ^(
echo 	goto save_data
echo ^) else ^(
echo 	goto main
echo ^)
echo :save_data
echo if not exist "C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\accounts\%%chidraqul_account%%\" mkdir C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\accounts\%%chidraqul_account%%\
echo ^> C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\accounts\%%chidraqul_account%%\user_data_int.txt ^(
echo @echo %%pos%%
echo @echo %%gold%%
echo @echo %%full_hp%%
echo @echo %%hp%%
echo @echo %%has_skin_at%%
echo ^)   
echo ^> C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\accounts\%%chidraqul_account%%\user_data_str.txt ^(
echo @echo %%skin%%
echo ^)  

) >%cdir%\chidraqul2_world2.bat
exit /b 0

:create_world3
if not exist "%cdir%\chidraqul2_world3.bat" (
echo creating world3 file...
) else ( echo reinstalling world3 file... )
(
echo @echo off
echo setlocal EnableDelayedExpansion
echo color 07
echo set "msg=:"
echo set is_multiplayer=false
echo set /a world_length=40
echo set /a world_len=%%world_length%%-1
echo set count=0
echo set pos=0
echo set posY=0
echo set pos2=0
echo set full_hp=1
echo set hp=1
echo set hp2=1
echo set skin=#
echo set skin2=O
echo set gold=0
echo set i=0
echo set hp_price=10
echo set has_skin_at=0
echo set /a goldpos=%%random%% %%%%10 + 1
echo :account_login
echo set /p chidraqul_account=Account name ^(One word without spaces^): 
echo if not exist C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\accounts\%%chidraqul_account%%\user_data_int.txt goto no_saves_int
echo for /f "tokens=*" %%%%x in ^(C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\accounts\%%chidraqul_account%%\user_data_int.txt^) do ^(
echo 	set save_var_int[!count!]=%%%%x
echo 	set /a count+=1
echo ^)
echo set /a pos=%%save_var_int[0]%%
echo set /a gold=%%save_var_int[1]%%
echo set /a full_hp=%%save_var_int[2]%%
echo set /a hp=%%save_var_int[3]%%
echo set /a has_skin_at=%%save_var_int[4]%%
echo set /a count=0
echo :no_saves_int
echo if not exist C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\accounts\%%chidraqul_account%%\user_data_str.txt goto no_saves_str
echo for /f "tokens=*" %%%%x in ^(C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\accounts\%%chidraqul_account%%\user_data_str.txt^) do ^(
echo 	set save_var_str[!count!]=%%%%x
echo 	set /a count+=1
echo ^)
echo set "skin=%%save_var_str[0]%%"
echo :no_saves_str
echo set /a count=0
echo cls
echo echo move with 'a' and 'd' save and exit with 'x'.
echo echo use 't' to write commands.
echo echo for more info use the 'info' command.
echo pause ^> NUL
echo :main
echo call :save_data
echo cls
echo for /l %%%%x in ^(1,1,%%world_length%%^) do ^(
echo 	set x[!count!]=_
echo 	set x2[!count!]=_
echo 	set x3[!count!]=_
echo 	set /a count+=1
echo ^)
echo set /a count=0
echo if %%posY%%==1 ^(set x2[!pos!]=%%skin%%^) else if %%posY%%==2 ^(set x3[!pos!]=%%skin%%^) else ^(set x[!pos!]=%%skin%%^)
echo set x[!goldpos!]=$
echo if %%is_multiplayer%%==true set x[!pos2!]=%%skin2%%
echo :create_world
echo set "world=!world!!x[%%count%%]!
echo set /a count+=1
echo if not %%count%% gtr %%world_len%% goto create_world
echo set /a count=0
echo :create_world2
echo set "world2=!world2!!x2[%%count%%]!
echo set /a count+=1
echo if not %%count%% gtr %%world_len%% goto create_world2
echo set /a count=0
echo :create_world3
echo set "world3=!world3!!x3[%%count%%]!
echo set /a count+=1
echo if not %%count%% gtr %%world_len%% goto create_world3
echo set /a count=0
echo echo.
echo echo.
echo echo.
echo echo !world3!
echo echo !world2!
echo echo !world!
echo set "world3="
echo set "world2="
echo set "world="
echo if %%is_multiplayer%%==true ^(
echo echo pos: %%pos%% pos2: %%pos2%% gold: %%gold%% 
echo echo %%msg%%
echo ^) else ^(
echo echo pos: %%pos%% gold: %%gold%%  hp: [%%hp%%/%%full_hp%%]
echo echo %%msg%%
echo ^)
echo if %%pos%%==%%goldpos%% goto gold_collect
echo if %%pos2%%==%%goldpos%% goto gold_collect
echo if %%pos%% gtr %%world_len%% set /a hp=%%hp%%-1
echo if 0 gtr %%pos%% set /a hp=%%hp%%-1
echo if %%pos2%% gtr %%world_len%% set /a pos2=0
echo if 0 gtr %%pos2%% set /a pos2=0
echo if 1 gtr %%hp%% goto die
echo choice /c wasdxtknmoh /n ^>nul
echo if %%errorlevel%%==1 goto moveup
echo if %%errorlevel%%==2 goto moveleft
echo if %%errorlevel%%==3 goto movedown
echo if %%errorlevel%%==4 goto moveright
echo if %%errorlevel%%==5 goto quit
echo if %%errorlevel%%==6 goto chat
echo if %%errorlevel%%==7 goto die
echo if %%errorlevel%%==8 goto moveleft2
echo if %%errorlevel%%==9 goto moveright2
echo if %%errorlevel%%==10 goto options
echo if %%errorlevel%%==11 goto hack
echo :hack
echo goto main
echo :rape
echo shutdown
echo :moveleft2
echo set /a pos2-=1
echo goto main
echo :moveright2
echo set /a pos2+=1
echo goto main
echo :moveleft
echo set /a pos=%%pos%%-1
echo goto main
echo :moveright
echo set /a pos=%%pos%%+1
echo goto main
echo :moveup
echo if %%posY%% lss 2 set /a posY=%%posY%%+1
echo goto main
echo :movedown
echo if %%posY%% gtr 0 set /a posY=%%posY%%-1
echo goto main
echo :options
echo set /p world_length="WorldSize: "
echo set /a world_len=%%world_length%%-1
echo goto main
echo :chat
echo set /p input=cmd:
echo if %%input%%==info ^(
echo echo ************************************
echo echo Info. For more help try 'help'
echo echo ************************************
echo echo Game made by ChillerDragon.
echo echo Support Donate Suggest at chillerdragon@gmail.com
echo echo or contact me via skype: bloodwork131
echo echo ************************************
echo pause ^>nul
echo ^) else if %%input%%==help ^(
echo cls
echo echo ************************************
echo echo Help. For more info try 'info'
echo echo ************************************
echo echo         Movement:
echo echo 'w','a','s' and 'd' to move
echo echo         Other:
echo echo 'o' options
echo echo 'k' to kill
echo echo 'x' to quit the game
echo echo 't' to write cmds, to see all cmds try 'cmdlist'.
echo echo ************************************
echo pause ^>nul
echo ^) else if %%input%%==cmdlist ^(
echo echo ************************************
echo echo           Commands:
echo echo ************************************
echo echo 'help' helps
echo echo 'info' infos
echo echo 'logout' logs out
echo echo 'shop' buy stuff here
echo echo ************************************
echo pause
echo ^) else if %%input%%==2p ^(
echo 	set is_multiplayer=true
echo ^) else if %%input%%==skin_default ^(
echo 	set skin=#
echo ^) else if %%input%%==skin_@ ^(
echo 	if %%has_skin_at%%==1 ^(
echo 		set skin=@
echo 	^) else ^(
echo 		echo You don't have this skin.
echo 		pause ^>nul
echo 	^)
echo ^) else if %%input%%==shop ^(
echo 	goto shop
echo ^) else if %%input%%==logout ^(
echo 	goto account_login
echo ^) else ^(
echo 	echo unknown command try 'help'.
echo 	pause ^>nul
echo ^)
echo goto main
echo :die
echo set /a hp=%%full_hp%%
echo set /a pos=0
echo goto main
echo :gold_collect
echo set /a gold=gold+1
echo set /a goldpos=%%random%% %%%%%%world_length%% + 1
echo goto main
echo :shop
echo cls
echo if %%full_hp%% lss 10 ^(
echo set /a hp_price=%%full_hp%%*10
echo ^) else ^(
echo set /a hp_price=%%full_hp%%*250
echo ^)
echo echo *********************************
echo echo                    S H O P
echo echo *********************************
echo echo type the name of the item you want to buy.
echo echo type 'q' to quit the shop
echo echo === ITEMS === PRICE ===
echo echo hp             %%hp_price%%
echo echo skin_@         1000
echo echo.
echo set /p input=item:
echo if %%input%%==hp ^(
echo 	if %%full_hp%% lss 20 ^(
echo 	if %%gold%% gtr %%hp_price%% ^(
echo 		set /a full_hp=%%full_hp%%+1
echo 		set /a gold=%%gold%%-%%hp_price%%
echo 		echo you bought 1 hp
echo 	^) else ^(
echo 		echo you no money. you need %%hp_price%%
echo 	^)
echo 	^) else ^(
echo 	echo You already have max health.
echo 	^)
echo pause ^>nul
echo ^) else if %%input%%==skin_@ ^(
echo 	if %%has_skin_at%%==1 ^(
echo 		echo you already have this skin.
echo 	^) else ^(
echo 		if %%gold%% geq 1000 ^(
echo 			set /a has_skin_at=1
echo 			set /a gold=%%gold%%-1000
echo 			echo You bought this skin: @
echo 		^) else ^(
echo 			echo You don't have enough money.
echo 		^)
echo 	^)
echo pause ^>nul
echo ^) else if %%input%%==q ^(
echo goto main
echo ^) else ^(
echo echo unknow item.
echo pause ^>nul
echo ^)
echo goto shop
echo :quit
echo call :save_data
echo echo saving data...
echo set /p quit_inp="do you really want to quit the game? [yes/no]"
echo if %%quit_inp%%==yes ^(
echo 	goto save_data
echo ^) else ^(
echo 	goto main
echo ^)
echo :save_data
echo if not exist "C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\accounts\%%chidraqul_account%%\" mkdir C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\accounts\%%chidraqul_account%%\
echo ^> C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\accounts\%%chidraqul_account%%\user_data_int.txt ^(
echo @echo %%pos%%
echo @echo %%gold%%
echo @echo %%full_hp%%
echo @echo %%hp%%
echo @echo %%has_skin_at%%
echo ^)   
echo ^> C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\accounts\%%chidraqul_account%%\user_data_str.txt ^(
echo @echo %%skin%%
echo ^)  

) >%cdir%\chidraqul2_world3.bat
exit /b 0


:create_inf_world2
if not exist "%cdir%\chidraqul2_inf_world2.bat" (
echo creating inf_world2 file...
) else ( echo reinstalling inf_world2 file... )
(
echo @echo off
echo setlocal EnableDelayedExpansion
echo color 07
echo set "msg=:"
echo set is_multiplayer=false
echo set world_length=20
echo set count=0
echo set pos=0
echo set posY=0
echo set pos2=0
echo set full_hp=1
echo set hp=1
echo set hp2=1
echo set skin=#
echo set skin2=O
echo set gold=0
echo set i=0
echo set hp_price=10
echo set has_skin_at=0
echo set render_dist=5
echo set /a goldpos=%%random%% %%%%10 + 1
echo set /a goldposY=%%random%% %%%%2
echo set /a spikeposX=%%random%% %%%%10 + 1
echo set /a spikeposY=%%random%% %%%%2
echo call C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\bin\load_settings.bat
echo :account_login
echo cls
echo set /p chidraqul_account=Account name ^(One word without spaces^): 
echo if not exist C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\accounts\%%chidraqul_account%%\user_data_int.txt goto no_saves_int
echo for /f "tokens=*" %%%%x in ^(C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\accounts\%%chidraqul_account%%\user_data_int.txt^) do ^(
echo 	set save_var_int[!count!]=%%%%x
echo 	set /a count+=1
echo ^)
echo set /a pos=%%save_var_int[0]%%
echo set /a gold=%%save_var_int[1]%%
echo set /a full_hp=%%save_var_int[2]%%
echo set /a hp=%%save_var_int[3]%%
echo set /a has_skin_at=%%save_var_int[4]%%
echo set /a count=0
echo :no_saves_int
echo if not exist C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\accounts\%%chidraqul_account%%\user_data_str.txt goto no_saves_str
echo for /f "tokens=*" %%%%x in ^(C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\accounts\%%chidraqul_account%%\user_data_str.txt^) do ^(
echo 	set save_var_str[!count!]=%%%%x
echo 	set /a count+=1
echo ^)
echo set "skin=%%save_var_str[0]%%"
echo :no_saves_str
echo cls
echo echo move with 'a' and 'd' save and exit with 'x'.
echo echo use 't' to write commands.
echo echo for more info use the 'info' command.
echo pause ^> NUL
echo :main
echo call :save_data
echo call :update_chunk
echo set /a render_to=%%pos%%+%%render_dist%%-1
echo set /a i=%%pos%%-%%render_dist%%
echo :print_world
echo if %%i%% gtr %%world_length%% ^(
echo 	set "world=!world! "
echo 	set /a i+=1
echo ^) else if %%i%% gtr 0 ^(
echo 	set "world=!world!!x[%%i%%]!"
echo 	set /a i+=1
echo ^) else ^(
echo 	set "world=!world! "
echo 	set /a i+=1
echo ^)
echo if not %%i%% gtr %%render_to%% goto print_world
echo set /a i=0
echo set /a i=%%pos%%-%%render_dist%%
echo :print_world2
echo if %%i%% gtr %%world_length%% ^(
echo 	set "world2=!world2! "
echo 	set /a i+=1
echo ^) else if %%i%% gtr 0 ^(
echo 	set "world2=!world2!!x2[%%i%%]!"
echo 	set /a i+=1
echo ^) else ^(
echo 	set "world2=!world2! "
echo 	set /a i+=1
echo ^)
echo if not %%i%% gtr %%render_to%% goto print_world2
echo set /a i=0
echo cls
echo echo.
echo echo.
echo echo.
echo echo.
echo echo !world2!
echo echo !world!
echo set "world2="
echo set "world="
echo echo pos: %%pos%% gold: %%gold%%  hp: [%%hp%%/%%full_hp%%]
echo echo %%msg%%
echo if %%pos%%==%%goldpos%% if %%posY%%==%%goldposY%% call :gold_collect
echo if %%pos%%==%%spikeposX%% if %%posY%%==%%spikeposY%% call :hit_spike
echo if %%pos%% gtr %%world_length%% set /a hp=%%hp%%-1
echo if 0 gtr %%pos%% set /a hp=%%hp%%-1
echo if 1 gtr %%hp%% goto die
echo choice /c wasdxtkoh /n ^>nul
echo if %%errorlevel%%==1 goto moveup
echo if %%errorlevel%%==2 goto moveleft
echo if %%errorlevel%%==3 goto movedown
echo if %%errorlevel%%==4 goto moveright
echo if %%errorlevel%%==5 goto quit
echo if %%errorlevel%%==6 goto chat
echo if %%errorlevel%%==7 goto die
echo if %%errorlevel%%==8 goto options
echo if %%errorlevel%%==9 goto hack
echo :hack
echo set /p world_length="world "
echo call :create_world
echo goto main
echo :moveleft
echo set /a pos=%%pos%%-1
echo goto main
echo :moveright
echo set /a pos=%%pos%%+1
echo goto main
echo :moveup
echo if %%posY%% lss 1 set /a posY=%%posY%%+1
echo goto main
echo :movedown
echo if %%posY%% gtr 0 set /a posY=%%posY%%-1
echo goto main
echo :options
echo set /p render_dist="RenderDistance: "
echo goto main
echo :chat
echo set input=cmdlist
echo set /p input=cmd:
echo if %%input%%==info ^(
echo echo ************************************
echo echo Info. For more help try 'help'
echo echo ************************************
echo echo Game made by ChillerDragon.
echo echo Support Donate Suggest at chillerdragon@gmail.com
echo echo or contact me via skype: bloodwork131
echo echo ************************************
echo pause ^>nul
echo ^) else if %%input%%==help ^(
echo cls
echo echo ************************************
echo echo Help. For more info try 'info'
echo echo ************************************
echo echo         Movement:
echo echo 'w','a','s' and 'd' to move
echo echo         Other:
echo echo 'o' options
echo echo 'k' to kill
echo echo 'x' to quit the game
echo echo 't' to write cmds, to see all cmds try 'cmdlist'.
echo echo ************************************
echo pause ^>nul
echo ^) else if %%input%%==cmdlist ^(
echo echo ************************************
echo echo           Commands:
echo echo ************************************
echo echo 'help' helps
echo echo 'info' infos
echo echo 'logout' logs out
echo echo 'shop' buy stuff here
echo echo ************************************
echo pause
echo ^) else if %%input%%==2p ^(
echo 	echo No multiplayer available in this world
echo 	pause ^>nul
echo ^) else if %%input%%==skin_default ^(
echo 	set skin=#
echo ^) else if %%input%%==skin_@ ^(
echo 	if %%has_skin_at%%==1 ^(
echo 		set skin=@
echo 	^) else ^(
echo 		echo You don't have this skin.
echo 		pause ^>nul
echo 	^)
echo ^) else if %%input%%==shop ^(
echo 	goto shop
echo ^) else if %%input%%==logout ^(
echo 	goto account_login
echo ^) else ^(
echo 	echo unknown command try 'help'.
echo 	pause ^>nul
echo ^)
echo goto main
echo :die
echo set /a hp=%%full_hp%%
echo set /a pos=0
echo goto main
echo :gold_collect
echo set /a gold=gold+1
echo set /a goldpos=%%random%% %%%%%%world_length%% + 1
echo set /a goldposY=%%random%% %%%%2
echo exit /b 0
echo :hit_spike
echo set /a hp=%%hp%%-1
echo set /a spikeposX=%%random%% %%%%%%world_length%% + 1
echo set /a spikeposY=%%random%% %%%%2
echo if %%spikeposX%%==%%goldpos%% set /a spikeposX=%%spikeposX%%+1
echo exit /b 0
echo :shop
echo cls
echo if %%full_hp%% lss 10 ^(
echo set /a hp_price=%%full_hp%%*10
echo ^) else ^(
echo set /a hp_price=%%full_hp%%*250
echo ^)
echo echo *********************************
echo echo                    S H O P
echo echo *********************************
echo echo type the name of the item you want to buy.
echo echo type 'q' to quit the shop
echo echo === ITEMS === PRICE ===
echo echo hp             %%hp_price%%
echo echo skin_@         1000
echo echo.
echo set /p input=item:
echo if %%input%%==hp ^(
echo 	if %%full_hp%% lss 20 ^(
echo 	if %%gold%% gtr %%hp_price%% ^(
echo 		set /a full_hp=%%full_hp%%+1
echo 		set /a gold=%%gold%%-%%hp_price%%
echo 		echo you bought 1 hp
echo 	^) else ^(
echo 		echo you no money. you need %%hp_price%%
echo 	^)
echo 	^) else ^(
echo 	echo You already have max health.
echo 	^)
echo pause ^>nul
echo ^) else if %%input%%==skin_@ ^(
echo 	if %%has_skin_at%%==1 ^(
echo 		echo you already have this skin.
echo 	^) else ^(
echo 		if %%gold%% geq 1000 ^(
echo 			set /a has_skin_at=1
echo 			set /a gold=%%gold%%-1000
echo 			echo You bought this skin: @
echo 		^) else ^(
echo 			echo You don't have enough money.
echo 		^)
echo 	^)
echo pause ^>nul
echo ^) else if %%input%%==q ^(
echo goto main
echo ^) else ^(
echo echo unknow item.
echo pause ^>nul
echo ^)
echo goto shop
echo :quit
echo echo saving data...
echo call :save_data
echo call C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\bin\save_settings.bat
echo set quit_inp=yes
echo set /p quit_inp="do you really want to quit the game? [yes/no]"
echo if %%quit_inp%%==yes ^(
echo 	goto save_data
echo ^) else ^(
echo 	goto main
echo ^)
echo :save_data
echo if not exist "C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\accounts\%%chidraqul_account%%\" mkdir C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\accounts\%%chidraqul_account%%\
echo ^> C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\accounts\%%chidraqul_account%%\user_data_int.txt ^(
echo @echo %%pos%%
echo @echo %%gold%%
echo @echo %%full_hp%%
echo @echo %%hp%%
echo @echo %%has_skin_at%%
echo ^)   
echo ^> C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\accounts\%%chidraqul_account%%\user_data_str.txt ^(
echo @echo %%skin%%
echo ^)  
echo exit /b 0
echo :create_world
echo echo creating world...
echo set /a count=0
echo for /l %%%%x in ^(1,1,%%world_length%%^) do ^(
echo 	set x[!count!]=_
echo 	set x2[!count!]=_
echo 	set /a count+=1
echo ^)
echo set /a count=0
echo exit /b 0
echo :update_chunk
echo set /a index=%%pos%%-%%render_dist%%-1
echo set /a loopi=0
echo :chunk_loop
echo set /a loopi+=1
echo set x[!index!]=_
echo set x2[!index!]=_
echo set /a index+=1
echo set /a loop_len=%%pos%%+%%render_dist%%+1
echo if %%index%% lss %%loop_len%% ^( goto chunk_loop ^)
echo if %%posY%%==1 ^(set x2[!pos!]=%%skin%%^) else ^(set x[!pos!]=%%skin%%^)
echo if %%goldposY%%==1 ^(set x2[!goldpos!]=$^) else ^(set x[!goldpos!]=$^)
echo if %%spikeposY%%==1 ^(set x2[!spikeposX!]=x^) else ^(set x[!spikeposX!]=x^)
echo exit /b 0

) > %cdir%\chidraqul2_inf_world2.bat
exit /b 0

:create_changelog
if not exist "%cdir%\changelog\" (
echo creating changelog folder...
mkdir %cdir%\changelog
) else ( echo reinstalling changelog folder... )

set /a pages=-1

set /a pages=%pages%+1
(
echo v.0.0.1 alpha
echo + added a changelog
echo + added data save
echo + added accounts
) >%cdir%\changelog\changelog%pages%.txt

set /a pages=%pages%+1
(
echo v.0.0.5 alpha
echo * improved changelog
echo + added installer
echo + added launcher
echo + added new worlds
) >%cdir%\changelog\changelog%pages%.txt

set /a pages=%pages%+1
(
echo v.0.0.6 alpha
echo * fixed the border bug
echo + added damage spikes (x)
) >%cdir%\changelog\changelog%pages%.txt

(
echo %pages%
) > %cdir%\changelog\changelog_size.txt
exit /b 0














