@Echo Off
color 2f
title  Autorun 病毒清除工具-By Phexon
Rem 杀进程
taskkill /F /IM SocksA.exe /IM SVOHOST.exe /IM AdobeR.exe /IM ravmone.exe /IM wincfgs.exe /IM doc.exe /IM rose.exe /IM sxs.exe /IM autorun.exe /IM KB20060111.exe /IM tel.xls.exe>nul 2>nul


:clearauto
cls
Echo.
Echo				Autorun 病毒清除工具
Echo.
Echo.				
Echo.
Echo			       制作：Phexon
Echo.
Echo		本程序运行后自动清除每个盘符下面的Autorun病毒
Echo		本程序原理是基于读取每个盘符下的Autorun.inf相关字段
Echo.
Echo		[1] 仅仅删除所有盘符下的 Autorun 病毒
Echo		[2] 删除所有盘符下的 Autorun 病毒并且建立同名免疫目录(推荐!)
Echo		[3] 禁用系统的 Autorun 机制以避免 Autorun 病毒的再次感染
Echo		[4] 取消所有盘符的 Autorun 病毒免疫
Echo		[5] 删除并免疫指定盘符的 Autorun 病毒
Echo		[6] 取消免疫指定盘符
Echo		[7] 恢复相关注册表项默认值
Echo		[0] 退出
Echo.
Set /p clearslt=	请输入您的选择(1/2/3/4/5/6/7/0):
If "%clearslt%"=="" Goto clearauto
If "%clearslt%"=="1" Goto clearauto1
If "%clearslt%"=="2" Goto clearauto2
If "%clearslt%"=="3" Goto clearauto3
If "%clearslt%"=="4" Goto clearauto4
If "%clearslt%"=="5" Goto clearauto5
If "%clearslt%"=="6" Goto clearauto6
If "%clearslt%"=="7" Goto clearauto7
If "%clearslt%"=="0" Exit


:clearauto1
taskkill /F /IM SocksA.exe /IM SVOHOST.exe /IM AdobeR.exe /IM ravmone.exe /IM wincfgs.exe /IM doc.exe /IM rose.exe /IM sxs.exe /IM autorun.exe /IM KB20060111.exe /IM tel.xls.exe>nul 2>nul
For %%a In (C D E F G H I J K L M N O P Q R S T U V W X Y Z) Do (
	fsutil fsinfo drivetype %%a: |find /i "固定驱动器" && (
		For /f "tokens=2 delims==" %%b In (%%a:\autorun.inf) Do Del /a /f /q "%%a:\%%b" >nul 2>nul
		Del /a /f /q %%a:\autorun.inf >nul 2>nul
		) >nul 2>nul
	fsutil fsinfo drivetype %%a: |find /i "可移动驱动器" && (
		For /f "tokens=2 delims==" %%b In (%%a:\autorun.inf) Do Del /a /f /q "%%a:\%%b" >nul 2>nul
		Del /a /f /q %%a:\autorun.inf >nul 2>nul
		) >nul 2>nul
	)
cls
Echo		Autorun 病毒清除完毕，任意键返回……
pause>nul
Goto clearauto


:clearauto2
taskkill /F /IM SocksA.exe /IM SVOHOST.exe /IM AdobeR.exe /IM ravmone.exe /IM wincfgs.exe /IM doc.exe /IM rose.exe /IM sxs.exe /IM autorun.exe /IM KB20060111.exe /IM tel.xls.exe>nul 2>nul
For %%a In (C D E F G H I J K L M N O P Q R S T U V W X Y Z) Do (
	fsutil fsinfo drivetype %%a: |find /i "固定驱动器" && (
		For /f "tokens=2 delims==" %%b In (%%a:\autorun.inf) Do Del /a /f /q "%%a:\%%b" & md "%%a:\%%b\免疫目录不要删除!...\" & attrib +s +h +r "%%a:\%%b" & Echo Y|cacls "%%a:\%%b" /T /C /P everyone:N >nul 2>nul
		Del /a /f /q %%a:\autorun.inf & md "%%a:\autorun.inf\免疫目录不要删除!...\" & attrib +s +h +r %%a:\autorun.inf & Echo Y|cacls "%%a:\autorun.inf" /T /C /P everyone:N >nul 2>nul
		) >nul 2>nul
	fsutil fsinfo drivetype %%a: |find /i "可移动驱动器" && (
		For /f "tokens=2 delims==" %%b In (%%a:\autorun.inf) Do Del /a /f /q "%%a:\%%b" & md "%%a:\%%b\免疫目录不要删除!...\" & attrib +s +h +r "%%a:\%%b" & Echo Y|cacls "%%a:\%%b" /T /C /P everyone:N >nul 2>nul
		Del /a /f /q %%a:\autorun.inf & md "%%a:\autorun.inf\免疫目录不要删除!...\" & attrib +s +h +r %%a:\autorun.inf & Echo Y|cacls "%%a:\autorun.inf" /T /C /P everyone:N >nul 2>nul
		) >nul 2>nul
	)
cls
Echo		Autorun 病毒清除并免疫完毕，任意键返回……
pause>nul
Goto clearauto


:clearauto3
cls
Echo.
Echo		正在停止相关服务……
Echo.
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 0x000000ff /f >nul 2>nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 0x000000ff /f >nul 2>nul
net stop ShellHWDetection >nul 2>nul
sc config ShellHWDetection start= disabled >nul 2>nul
Rem 添加防止从回收站或仿回收站的目录中直接运行可执行文件的策略
Set REGPATH=HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\0\Paths
Set SFLAG=/v SaferFlags /t REG_DWORD /d 0x00000000 /f
Set IDATA=/f /v ItemData /d "?:\Recyc?
reg add %REGPATH%\{00ffa5bf-abe7-4901-aacf-4f58aa31217a} %SFLAG%>nul
reg add %REGPATH%\{00ffa5bf-abe7-4901-aacf-4f58aa31217a} %IDATA%\*\*\*\*.*">nul

reg add %REGPATH%\{41fe7eed-c47a-46f6-840a-240796fd03cf} %SFLAG%>nul
reg add %REGPATH%\{41fe7eed-c47a-46f6-840a-240796fd03cf} %IDATA%\*\*\*.*">nul

reg add %REGPATH%\{4e93c91c-a40e-462e-9b89-3b0832d222d9} %SFLAG%>nul
reg add %REGPATH%\{4e93c91c-a40e-462e-9b89-3b0832d222d9} %IDATA%\*.*">nul

reg add %REGPATH%\{5bfc100b-d3fb-450e-88ec-6819ab56a9ff} %SFLAG%>nul
reg add %REGPATH%\{5bfc100b-d3fb-450e-88ec-6819ab56a9ff} %IDATA%\*\*\*\*.*">nul

reg add %REGPATH%\{5c5e2bcd-7057-43f4-830c-e4361d2afadd} %SFLAG%>nul
reg add %REGPATH%\{5c5e2bcd-7057-43f4-830c-e4361d2afadd} %IDATA%\*.*">nul

reg add %REGPATH%\{5f8ff865-0638-4c6e-98de-923e7bc6b330} %SFLAG%>nul
reg add %REGPATH%\{5f8ff865-0638-4c6e-98de-923e7bc6b330} %IDATA%\*\*\*.*">nul

reg add %REGPATH%\{649c1429-0e79-453c-abe9-b5682e035ae7} %SFLAG%>nul
reg add %REGPATH%\{649c1429-0e79-453c-abe9-b5682e035ae7} %IDATA%\*\*.*">nul

reg add %REGPATH%\{718f54b2-c669-4d7b-aeff-18d69f100034} %SFLAG%>nul
reg add %REGPATH%\{718f54b2-c669-4d7b-aeff-18d69f100034} %IDATA%\*\*.*">nul

reg add %REGPATH%\{8385d9d2-80c9-4ac1-a100-ed3e62863d97} %SFLAG%>nul
reg add %REGPATH%\{8385d9d2-80c9-4ac1-a100-ed3e62863d97} %IDATA%\*.*">nul

reg add %REGPATH%\{af2a4fcf-441c-421e-9663-52cd3502cfd7} %SFLAG%>nul
reg add %REGPATH%\{af2a4fcf-441c-421e-9663-52cd3502cfd7} %IDATA%\*\*\*.*">nul

reg add %REGPATH%\{b997f4b2-c037-4e97-b051-31f5d86df802} %SFLAG%>nul
reg add %REGPATH%\{b997f4b2-c037-4e97-b051-31f5d86df802} %IDATA%\*\*.*">nul

reg add %REGPATH%\{d4e7b6ff-d76f-407f-b8bb-ea0835f5babc} %SFLAG%>nul
reg add %REGPATH%\{d4e7b6ff-d76f-407f-b8bb-ea0835f5babc} /f /v ItemData /d "RECYC*.*">nul

Rem 清除喜欢利用回收站的移动磁盘自动运行病毒
For %%a In (c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z) Do (
	For %%b In (exe pif com) Do (
		Echo Y|cacls "%%a:\Recycler\*.%%b" /C /T /P everyone:F>nul 2>nul&Echo Y|cacls "%%a:\Recycled\*.%%b" /C /T /P everyone:F>nul 2>nul&Echo Y|cacls "%%a:\Recycled\Recycled\*.%%b" /C /T /P everyone:F>nul 2>nul
		Del /A /F /S /Q "%%a:\Recycler\*.%%b">nul 2>nul&Del /A /F /S /Q "%%a:\Recycled\*.%%b">nul 2>nul&Del /A /F /S /Q "%%a:\Recycled\Recycled\*.%%b">nul 2>nul
		)
	)>nul 2>nul
Echo.
Echo		相关服务已停止并禁用，任意键返回……
pause >nul
Goto clearauto


:clearauto4
For %%a In (C D E F G H I J K L M N O P Q R S T U V W X Y Z) Do (
	fsutil fsinfo drivetype %%a: |find /i "固定驱动器" && (
		cacls "%%a:\autorun.inf" /T /C /P everyone:F&Del /a /f /q "%%a:\autorun.inf" & rd /s /q "%%a:\autorun.inf">nul 2>nul
		)>nul 2>nul
	fsutil fsinfo drivetype %%a: |find /i "可移动驱动器" && (
		cacls "%%a:\autorun.inf" /T /C /P everyone:F&Del /a /f /q "%%a:\autorun.inf" & rd /s /q "%%a:\autorun.inf">nul 2>nul
		)>nul 2>nul
	)
cls
Echo.
Echo		已经解除全部盘符的免疫，任意键返回……
pause>nul
Goto clearauto



:clearauto5
cls
Echo.
Set /p pf=		请输入盘符，如"F:"(不包括引号)
Echo 		即将免疫%pf%盘……|find /i ":"||Set pf=%pf%:&&Echo 		即将免疫%pf%盘……
taskkill /F /IM SocksA.exe /IM SVOHOST.exe /IM AdobeR.exe /IM ravmone.exe /IM wincfgs.exe /IM doc.exe /IM rose.exe /IM sxs.exe /IM autorun.exe /IM KB20060111.exe /IM tel.xls.exe>nul 2>nul
fsutil fsinfo drivetype %pf% |find /i "固定驱动器" && (
	For /f "tokens=2 delims==" %%a In (%pf%\autorun.inf) Do Del /a /f /q "%pf%\%%a" & md "%pf%\%%a\免疫目录不要删除!...\" & attrib +s +h +r "%pf%\%%a" & Echo Y|cacls "%pf%\%%a" /T /C /P everyone:N >nul 2>nul
	Del /a /f /q %pf%\autorun.inf & md "%pf%\autorun.inf\免疫目录不要删除!...\" & attrib +s +h +r %pf%\autorun.inf & Echo Y|cacls "%pf%\autorun.inf" /T /C /P everyone:N >nul 2>nul
	Goto DoneclearAuto
	) >nul 2>nul
fsutil fsinfo drivetype %pf% |find /i "可移动驱动器" && (
	For /f "tokens=2 delims==" %%a In (%pf%\autorun.inf) Do Del /a /f /q "%pf%\%%a" & md "%pf%\%%a\免疫目录不要删除!...\" & attrib +s +h +r "%pf%\%%a" & Echo Y|cacls "%pf%\%%a" /T /C /P everyone:N >nul 2>nul
	Del /a /f /q %pf%\autorun.inf & md "%pf%\autorun.inf\免疫目录不要删除!...\" & attrib +s +h +r %pf%\autorun.inf & Echo Y|cacls "%pf%\autorun.inf" /T /C /P everyone:N >nul 2>nul
	Goto DoneclearAuto
	) >nul 2>nul
Echo.
Echo		您所输入的盘符不存在或者是只读设备，
Echo		请重新输入
Goto clearauto5

:DoneclearAuto
cls
Echo.
Echo		指定的磁盘 %pf% 已经成功进行了 Autorun 病毒的清除及免疫
Echo.
Echo		[1] 继续免疫其他磁盘
Echo		[0] 返回主菜单
Set /p choice=		请输入您的选择(1/0):
If %choice%="" Goto DoneclearAuto
If %choice%="1" Goto clearauto5
If %choice%="0" Goto clearauto



:clearauto6
cls
Echo.
Set /p pf=		请输入盘符，如"F:"(不包括引号)
Echo 		即将取消免疫%pf%盘……|find /i ":"||Set pf=%pf%:&&Echo 		即将取消免疫%pf%盘……
fsutil fsinfo drivetype %pf% |find /i "固定驱动器" && (
	cacls "%pf%\autorun.inf" /T /C /P everyone:F&Del /a /f /q "%pf%\autorun.inf" & rd /s /q "%pf%\autorun.inf">nul 2>nul
	Goto DoneUnauto
	)>nul 2>nul
fsutil fsinfo drivetype %pf% |find /i "可移动驱动器" && (
	cacls "%pf%\autorun.inf" /T /C /P everyone:F&Del /a /f /q "%pf%\autorun.inf" & rd /s /q "%pf%\autorun.inf">nul 2>nul
	Goto DoneUnauto
	)>nul 2>nul
Echo.
Echo		您所输入的盘符不存在或者是只读设备，
Echo		请重新输入
Goto clearauto6

:DoneUnauto
cls
Echo.
Echo		指定的磁盘 %pf% 已经成功解除了 Autorun 病毒免疫
Echo.
Echo		[1] 继续解除免疫其他磁盘
Echo		[0] 返回主菜单
Set choice=
Set /p choice=		请输入您的选择(1/0):
If %choice%="" Goto DoneUnauto
If %choice%="1" Goto clearauto6
If %choice%="0" Goto clearauto



:clearauto7
cls
Rem 防止在资源管理器中彻底隐藏文件、禁止文件等
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Folder\Hidden\SHOWALL" /v CheckedValue /t REG_DWORD /d 0x00000001 /f>nul 2>nul
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2" /f>nul 2>nul
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" /f>nul 2>nul
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v DisallowRun /f>nul 2>nul
Rem 防止转移启动组位置
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v Startup /d "%USERPROFILE%\「开始」菜单\程序\启动" /f>nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Common Startup" /d "%ALLUSERSPROFILE%\「开始」菜单\程序\启动" /f>nul 2>nul
Echo.
Echo		相关注册表恢复完毕，任意键返回……
pause>nul
Goto clearauto