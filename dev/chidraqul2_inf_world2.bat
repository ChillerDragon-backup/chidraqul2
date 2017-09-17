@echo off
setlocal EnableDelayedExpansion
color 07
set "msg=:"
set is_multiplayer=false
set world_length=20
set count=0
set pos=0
set posY=0
set pos2=0
set full_hp=1
set hp=1
set hp2=1
set skin=#
set skin2=O
set gold=0
set i=0
set hp_price=10
set has_skin_at=0
set render_dist=5
set /a goldpos=%random% %%10 + 1
set /a goldposY=%random% %%2
:account_login
cls
set /p chidraqul_account=Account name (One word without spaces): 
if not exist C:\Users\%USERNAME%\AppData\Roaming\chidraqul\chidraqul2\accounts\%chidraqul_account%\user_data_int.txt goto no_saves_int
for /f "tokens=*" %%x in (C:\Users\%USERNAME%\AppData\Roaming\chidraqul\chidraqul2\accounts\%chidraqul_account%\user_data_int.txt) do (
	set save_var_int[!count!]=%%x
	set /a count+=1
)
set /a pos=%save_var_int[0]%
set /a gold=%save_var_int[1]%
set /a full_hp=%save_var_int[2]%
set /a hp=%save_var_int[3]%
set /a has_skin_at=%save_var_int[4]%
set /a count=0
:no_saves_int
if not exist C:\Users\%USERNAME%\AppData\Roaming\chidraqul\chidraqul2\accounts\%chidraqul_account%\user_data_str.txt goto no_saves_str
for /f "tokens=*" %%x in (C:\Users\%USERNAME%\AppData\Roaming\chidraqul\chidraqul2\accounts\%chidraqul_account%\user_data_str.txt) do (
	set save_var_str[!count!]=%%x
	set /a count+=1
)
set "skin=%save_var_str[0]%"
:no_saves_str
cls
echo move with 'a' and 'd' save and exit with 'x'.
echo use 't' to write commands.
echo for more info use the 'info' command.
pause > NUL
:main
call :save_data
call :update_chunk
set /a render_to=%pos%+%render_dist%-1
set /a i=%pos%-%render_dist%
:print_world
if %i% gtr %world_length% (
	set "world=!world! "
	set /a i+=1
) else if %i% gtr 0 (
	set "world=!world!!x[%i%]!"
	set /a i+=1
) else (
	set "world=!world! "
	set /a i+=1
)
if not %i% gtr %render_to% goto print_world
set /a i=0
set /a i=%pos%-%render_dist%
:print_world2
if %i% gtr %world_length% (
	set "world2=!world2! "
	set /a i+=1
) else if %i% gtr 0 (
	set "world2=!world2!!x2[%i%]!"
	set /a i+=1
) else (
	set "world2=!world2! "
	set /a i+=1
)
if not %i% gtr %render_to% goto print_world2
set /a i=0
cls
echo.
echo.
echo.
echo.
echo !world2!
echo !world!
set "world2="
set "world="
echo pos: %pos% gold: %gold%  hp: [%hp%/%full_hp%]
echo %msg%
if %pos%==%goldpos% if %posY%==%goldposY% goto gold_collect
if %pos% gtr %world_length% set /a hp=%hp%-1
if 0 gtr %pos% set /a hp=%hp%-1
if 1 gtr %hp% goto die
choice /c wasdxtkoh /n >nul
if %errorlevel%==1 goto moveup
if %errorlevel%==2 goto moveleft
if %errorlevel%==3 goto movedown
if %errorlevel%==4 goto moveright
if %errorlevel%==5 goto quit
if %errorlevel%==6 goto chat
if %errorlevel%==7 goto die
if %errorlevel%==8 goto options
if %errorlevel%==9 goto hack
:hack
set /p world_length="world "
call :create_world
goto main
:moveleft
set /a pos=%pos%-1
goto main
:moveright
set /a pos=%pos%+1
goto main
:moveup
if %posY% lss 1 set /a posY=%posY%+1
goto main
:movedown
if %posY% gtr 0 set /a posY=%posY%-1
goto main
:options
set /p render_dist="RenderDistance: "
goto main
:chat
set input=cmdlist
set /p input=cmd:
if %input%==info (
echo ************************************
echo Info. For more help try 'help'
echo ************************************
echo Game made by ChillerDragon.
echo Support Donate Suggest at chillerdragon@gmail.com
echo or contact me via skype: bloodwork131
echo ************************************
pause >nul
) else if %input%==help (
cls
echo ************************************
echo Help. For more info try 'info'
echo ************************************
echo         Movement:
echo 'w','a','s' and 'd' to move
echo         Other:
echo 'o' options
echo 'k' to kill
echo 'x' to quit the game
echo 't' to write cmds, to see all cmds try 'cmdlist'.
echo ************************************
pause >nul
) else if %input%==cmdlist (
echo ************************************
echo           Commands:
echo ************************************
echo 'help' helps
echo 'info' infos
echo 'logout' logs out
echo 'shop' buy stuff here
echo ************************************
pause
) else if %input%==2p (
	echo No multiplayer available in this world
	pause >nul
) else if %input%==skin_default (
	set skin=#
) else if %input%==skin_@ (
	if %has_skin_at%==1 (
		set skin=@
	) else (
		echo You don't have this skin.
		pause >nul
	)
) else if %input%==shop (
	goto shop
) else if %input%==logout (
	goto account_login
) else (
	echo unknown command try 'help'.
	pause >nul
)
goto main
:die
set /a hp=%full_hp%
set /a pos=0
goto main
:gold_collect
set /a gold=gold+1
set /a goldpos=%random% %%%world_length% + 1
set /a goldposY=%random% %%2
goto main
:shop
cls
if %full_hp% lss 10 (
set /a hp_price=%full_hp%*10
) else (
set /a hp_price=%full_hp%*250
)
echo *********************************
echo                    S H O P
echo *********************************
echo type the name of the item you want to buy.
echo type 'q' to quit the shop
echo === ITEMS === PRICE ===
echo hp             %hp_price%
echo skin_@         1000
echo.
set /p input=item:
if %input%==hp (
	if %full_hp% lss 20 (
	if %gold% gtr %hp_price% (
		set /a full_hp=%full_hp%+1
		set /a gold=%gold%-%hp_price%
		echo you bought 1 hp
	) else (
		echo you no money. you need %hp_price%
	)
	) else (
	echo You already have max health.
	)
pause >nul
) else if %input%==skin_@ (
	if %has_skin_at%==1 (
		echo you already have this skin.
	) else (
		if %gold% geq 1000 (
			set /a has_skin_at=1
			set /a gold=%gold%-1000
			echo You bought this skin: @
		) else (
			echo You don't have enough money.
		)
	)
pause >nul
) else if %input%==q (
goto main
) else (
echo unknow item.
pause >nul
)
goto shop
:quit
call :save_data
echo saving data...
set quit_inp=yes
set /p quit_inp="do you really want to quit the game? [yes/no]"
if %quit_inp%==yes (
	goto save_data
) else (
	goto main
)
:save_data
if not exist "C:\Users\%USERNAME%\AppData\Roaming\chidraqul\chidraqul2\accounts\%chidraqul_account%\" mkdir C:\Users\%USERNAME%\AppData\Roaming\chidraqul\chidraqul2\accounts\%chidraqul_account%\
> C:\Users\%USERNAME%\AppData\Roaming\chidraqul\chidraqul2\accounts\%chidraqul_account%\user_data_int.txt (
@echo %pos%
@echo %gold%
@echo %full_hp%
@echo %hp%
@echo %has_skin_at%
)   
> C:\Users\%USERNAME%\AppData\Roaming\chidraqul\chidraqul2\accounts\%chidraqul_account%\user_data_str.txt (
@echo %skin%
)  
exit /b 0
:create_world
echo creating world...
set /a count=0
for /l %%x in (1,1,%world_length%) do (
	set x[!count!]=_
	set x2[!count!]=_
	set /a count+=1
)
set /a count=0
exit /b 0
:update_chunk
set /a index=%pos%-%render_dist%-1
set /a loopi=0
:chunk_loop
set /a loopi+=1
set x[!index!]=_
set x2[!index!]=_
set /a index+=1
set /a loop_len=%pos%+%render_dist%+1
if %index% lss %loop_len% ( goto chunk_loop )
if %posY%==1 (set x2[!pos!]=%skin%) else (set x[!pos!]=%skin%)
if %goldposY%==1 (set x2[!goldpos!]=$) else (set x[!goldpos!]=$)
exit /b 0
