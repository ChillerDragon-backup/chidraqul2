@echo off

set /a count=0
set render_dist=5
set world_length=20

if not exist C:\Users\%USERNAME%\AppData\Roaming\chidraqul\chidraqul2\settings.cfg goto fail
for /f "tokens=*" %%x in (C:\Users\%USERNAME%\AppData\Roaming\chidraqul\chidraqul2\settings.cfg) do (
	set save_var_int[!count!]=%%x
	set /a count+=1
)
set /a render_dist=%save_var_int[0]%
set /a world_length=%save_var_int[1]%
set /a count=0
goto success

:fail
echo failed to load settings.
exit /b 0

:success
echo successfully loaded settings