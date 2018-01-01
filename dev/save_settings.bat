@echo off

if not exist "C:\Users\%USERNAME%\AppData\Roaming\chidraqul\chidraqul2\" mkdir C:\Users\%USERNAME%\AppData\Roaming\chidraqul\chidraqul2\
> C:\Users\%USERNAME%\AppData\Roaming\chidraqul\chidraqul2\settings.cfg (
@echo %render_dist%
@echo %world_length%
)  