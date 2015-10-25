@ ECHO OFF
@ ECHO.
@ ECHO.                     特      别      说       明  
@ ECHO.
@ ECHO.                      (WWW.ANKTY.COM 统一下载)
@ ECHO -------------------------------------------------------------------------------
@ ECHO 关闭所有驱动器的自动播放功能可能会为您的操作带来一些不便,这个程序可以还原XP默认
@ ECHO 的自动播放功能,不过我们提醒您做好病毒的防御工作!
@ ECHO -------------------------------------------------------------------------------
@ ECHO.
echo. & pause
reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoDriveTypeAutoRun /f
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoDriveTypeAutoRun /t REG_DWORD /d 223 /f
cls
echo.
echo.
echo.
echo.
echo                 还原所有驱动器自动播放成功!
echo.
echo                  WWW.ANKTY.COM谢谢您的使用!
echo. & pause


