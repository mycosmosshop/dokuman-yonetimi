@echo off
chcp 65001 >nul
title Dokuman Yonetimi - "Ac" kurulumu
echo.
echo  Dokuman Yonetimi web uygulamasindaki "Ac" dugmesinin agdaki
echo  dosyalari (Excel/Word/PDF) TEK TIKLA acmasi icin "leandoc" protokolu
echo  bu kullanici icin kuruluyor. (Yonetici GEREKMEZ. Her PC'de bir kez.)
echo.
set "DEST=%LOCALAPPDATA%\leandoc"
set "PS1=%DEST%\open_leandoc.ps1"
if not exist "%DEST%" mkdir "%DEST%"
> "%PS1%" echo param([string]$u)
>> "%PS1%" echo if ($u.StartsWith('leandoc:')) { $u = $u.Substring(8) }
>> "%PS1%" echo $u = $u.TrimStart('/')
>> "%PS1%" echo $u = $u.TrimEnd('/')
>> "%PS1%" echo $p = [System.Uri]::UnescapeDataString($u)
>> "%PS1%" echo $p = $p.Replace('/', '\')
>> "%PS1%" echo if (-not $p.StartsWith('\\')) { $p = '\\' + $p }
>> "%PS1%" echo Start-Process -FilePath $p
reg add "HKCU\Software\Classes\leandoc" /ve /d "URL:LeanSys Dokuman" /f >nul
reg add "HKCU\Software\Classes\leandoc" /v "URL Protocol" /t REG_SZ /d "" /f >nul
reg add "HKCU\Software\Classes\leandoc\shell\open\command" /ve /d "powershell.exe -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File \"%PS1%\" \"%%1\"" /f >nul
if errorlevel 1 echo  HATA: kayit yazilamadi.
if not errorlevel 1 echo  TAMAM. Artik web uygulamasindaki "Ac" dugmesi dosyalari direkt acar (bu PC icin bir kez yeterli).
echo.
pause
