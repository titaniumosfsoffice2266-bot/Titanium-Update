# تغيير رسالة الترحيب في الـ CMD لتأكيد التحديث
New-ItemProperty -Path "HKCU:\Software\Microsoft\Command Processor" -Name "AutoRun" -Value "echo Titanium OS Update v1.1 Applied!" -PropertyType String -Force
Write-Host "Update Applied Successfully!" -ForegroundColor Green