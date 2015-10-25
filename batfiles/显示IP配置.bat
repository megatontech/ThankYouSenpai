@echo off
::调用格式：
call :select "ip address" "ip"
call :select "Physical Address" "mac"
call :select "Default Gateway" "gateway"
call :select "DNS Servers" "dns"
call :select "Description" "netcard"

:: 演示效果
echo IP地址:%ip%
echo MAC地址:%mac%
echo DNS服务器:%dns%
echo 网关:%gateway%
echo NETCARD:%netcard%
pause>nul
goto :eof

::**************************************************************
::              解析ipconfig命令输出通用函数
::**************************************************************
:select
    for /f "tokens=2 delims=:" %%i in ('ipconfig /all ^| findstr /i /c:%1') do if not "!%~2!" == "" set "%~2=%%i"
goto :eof