@echo off
title Titanium OS - Office Universal Fix
color 0B
echo ====================================================
echo    Titanium OS - Repairing Office Applications
echo ====================================================

:: تحديد مسار الأوفيس الافتراضي (Office16 تشمل 2016 و 2019 و 2021)
set "OFFICE_PATH=C:\Program Files\Microsoft Office\root\Office16"

echo [+] Fixing Registry Paths...

:: مصفوفة التطبيقات (Word, Excel, PowerPoint, Outlook, Access, Publisher)
for %%app in (WINWORD.EXE EXCEL.EXE POWERPNT.EXE OUTLOOK.EXE MSACCESS.EXE MSPUB.EXE) do (
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\%%app" /ve /t REG_SZ /d "%OFFICE_PATH%\%%app" /f >nul
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\%%app" /v "Path" /t REG_SZ /d "%OFFICE_PATH%\" /f >nul
)

echo [+] Starting Required Services...
:: تشغيل خدمة ClickToRun الضرورية لتشغيل تطبيقات الأوفيس الحديثة
sc config ClickToRunSvc start= auto >nul
net start ClickToRunSvc >nul

echo [+] Resetting Permissions...
:: محاولة إعادة ضبط الترخيص بشكل سريع (صامت)
if exist "%OFFICE_PATH%\ospp.vbs" (
    cscript "%OFFICE_PATH%\ospp.vbs" /act >nul
)

echo ====================================================
echo    Fix Applied! Try opening any Office App now.
echo ====================================================
pause