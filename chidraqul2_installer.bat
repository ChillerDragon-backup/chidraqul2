@echo off

::Install telnet client (needed for updates)
::echo Installing TelnetClient...
::pkgmgr /iu:"TelnetClient"


::setting chidraqul2 directory path
set cdir="C:\Users\%USERNAME%\AppData\Roaming\chidraqul\chidraqul2"

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
call :create_world2
call :create_world3
call :create_game
echo chidraqul2 succsessfully installed.
echo =====================================
echo press any key to quit the installer
pause >nul
exit /b 0

:create_game
if not exist "chidraqul2.bat" (
echo creating game file...
) else ( echo reinstalling game file... )
(
echo @echo off
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
echo :main
echo cls
echo if %%select_world%%==2 ^(
echo echo use the keys 'w' and 's' to select
echo echo press 'e' to start
echo echo.
echo echo.
echo echo ^^^>world2^^^<
echo echo  world3
echo ^) else ^(
echo echo use the keys 'w' and 's' to select
echo echo press 'e' to start
echo echo.
echo echo.
echo echo  world2
echo echo ^^^>world3^^^<
echo ^)
echo choice /c wseq /n ^>nul
echo if %%errorlevel%%==1 set select_world=2
echo if %%errorlevel%%==2 set select_world=3
echo if %%errorlevel%%==3 goto start
echo if %%errorlevel%%==4 exit
echo goto main
echo :start
echo if %%select_world%%==2 ^(
echo cls
echo call C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\chidraqul2_world2.bat
echo exit
echo ^) else ^(
echo cls
echo call C:\Users\%%USERNAME%%\AppData\Roaming\chidraqul\chidraqul2\chidraqul2_world3.bat
echo exit
echo ^)
echo :failed
echo echo ################################
echo echo Failed loading chidraqul2.
echo echo Need help? Contact the dev on:
echo echo skype: BloodWork131
echo echo mail: chillerdragon@gmail.com
echo echo ################################
echo pause ^>nul
) >chidraqul2.bat
exit /b 0

:create_world2
echo creating world2 file...
(
echo @echo off
echo setlocal EnableDelayedExpansion
echo color 07
echo set "msg=:"
echo set is_multiplayer=false
echo set world_length=40
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
echo echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo echo          CHIDRAQUL2
echo echo            ADVENTURE
echo echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo echo v. 0.0.1 alpha
echo echo.
echo echo CHANGELOG:
echo echo v.0.0.1 alpha
echo echo + added a changelog
echo echo + added data save
echo echo + added accounts
echo pause ^> NUL
echo cls
echo :account_login
echo set /p chidraqul_account="Account name ^(One word without spaces^): "
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
echo set /a i+=1
echo if not %%i%% gtr %%world_length%% goto create_world
echo set /a i=0
echo set /a count=0
echo :create_world2
echo set "world2=!world2!!x2[%%count%%]!
echo set /a count+=1
echo set /a i+=1
echo if not %%i%% gtr %%world_length%% goto create_world2
echo set /a i=0
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
echo if %%pos%% gtr %%world_length%% set /a hp=%%hp%%-1
echo if 0 gtr %%pos%% set /a hp=%%hp%%-1
echo if %%pos2%% gtr %%world_length%% set /a pos2=0
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
echo creating world3 file...
(
echo @echo off
echo setlocal EnableDelayedExpansion
echo color 07
echo set "msg=:"
echo set is_multiplayer=false
echo set world_length=40
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
echo echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo echo          CHIDRAQUL2
echo echo            ADVENTURE
echo echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo echo v. 0.0.1 alpha
echo echo.
echo echo CHANGELOG:
echo echo v.0.0.1 alpha
echo echo + added a changelog
echo echo + added data save
echo echo + added accounts
echo pause ^> NUL
echo cls
echo :account_login
echo set /p chidraqul_account="Account name ^(One word without spaces^): "
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
echo set /a i+=1
echo if not %%i%% gtr %%world_length%% goto create_world
echo set /a i=0
echo set /a count=0
echo :create_world2
echo set "world2=!world2!!x2[%%count%%]!
echo set /a count+=1
echo set /a i+=1
echo if not %%i%% gtr %%world_length%% goto create_world2
echo set /a i=0
echo set /a count=0
echo :create_world3
echo set "world3=!world3!!x3[%%count%%]!
echo set /a count+=1
echo set /a i+=1
echo if not %%i%% gtr %%world_length%% goto create_world3
echo set /a i=0
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
echo if %%pos%% gtr %%world_length%% set /a hp=%%hp%%-1
echo if 0 gtr %%pos%% set /a hp=%%hp%%-1
echo if %%pos2%% gtr %%world_length%% set /a pos2=0
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
