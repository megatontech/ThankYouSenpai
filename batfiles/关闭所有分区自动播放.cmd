@ ECHO OFF
@ ECHO.
@ ECHO.                     特      别      说       明  
@ ECHO.
@ ECHO.                      (WWW.ANKTY.COM 统一下载)
@ ECHO -------------------------------------------------------------------------------
@ ECHO 如今有很多种病毒都依靠优盘自动播放功能肆意传播,有时候另我们防不胜防,伤透脑筋,比
@ ECHO 如说时下最流行的威金变种!此项操作将彻底关闭所有驱动器的自动播放功能,请谨慎使用!
@ ECHO -------------------------------------------------------------------------------
@ ECHO.
echo. & pause
reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoDriveTypeAutoRun /f
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoDriveTypeAutoRun /t REG_DWORD /d 255 /f
cls
echo.
echo.
echo.
echo.
echo                 关闭所有驱动器自动播放成功!
echo.
echo                  WWW.ANKTY.COM谢谢您的使用!
echo. & pause


