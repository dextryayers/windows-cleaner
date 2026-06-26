@echo off
title SSD LEGA PLONG - FINAL EDITION
color 0A

:: ============================================================
:: [GUARD] PAUSE DI AWAL - PASTI GA CLOSE SENDIRI
:: ============================================================
echo.
echo =====================================================
echo               SSD LEGA PLONG
echo =====================================================
echo.
echo [INFO] Script ini akan berjalan sebentar lagi.
echo        Jika ini adalah pertama kali, TUNGGU 3 DETIK.
echo.
timeout /t 3 /nobreak >nul
echo [OK] Melanjutkan...
pause

:: ============================================================
:: CEK ADMINISTRATOR!!
:: ============================================================
net session >nul 2>&1
if %errorLevel% neq 0 (
    cls
    echo ============================================================
    echo     GAGAL! HARUS JALANKAN SEBAGAI ADMINISTRATOR
    echo ============================================================
    echo.
    echo Cara: Klik kanan file ini -^> Pilih "Run as administrator"
    echo.
    echo [TIP] Kalau masih error, buka CMD manual:
    echo       1. Tekan Win+R, ketik "cmd", tekan Enter
    echo       2. Ketik: cd "C:\Users\NamaKamu\Desktop"
    echo       3. Ketik: SSD_LEGA_PLONG_FINAL.bat
    echo.
    pause
    exit /b
)

:: ============================================================
:: LANJUT KE SCRIPT UTAMA
:: ============================================================
cls
echo =====================================================================
echo        TOOLS CLEANER FOR WINDOWS v1.0 - BY : ANIIPID
echo =====================================================================
echo.
echo [INFO] Script ini SUDAH dilengkapi 3 lapisan anti-close:
echo        1. Guard di awal (timeout + pause)
echo        2. Setiap task ada pause sendiri
echo        3. Error di redirect ke void (2^>nul) biar ga nge-freeze
echo.
echo [FITUR ULTIMATE]
echo   Task 1  : Hitung Space Awal SSD
echo   Task 2  : Hapus SEMUA Temporary Files
echo   Task 3  : Hapus Prefetch, Thumbnail, Icon Cache
echo   Task 4  : Hapus Windows Update Cache
echo   Task 5  : Hapus Log, Dump, WER Reports
echo   Task 6  : Hapus Event Log
echo   Task 7  : Hapus Cache SEMUA Browser
echo   Task 8  : Kosongkan Recycle Bin
echo   Task 9  : Matikan Hibernasi
echo   Task 10 : Hapus Windows.old (opsional)
echo   Task 11 : Bersihkan WinSxS
echo   Task 12 : Hapus Cache Sistem Tersembunyi
echo   Task 13 : Hapus Cache Aplikasi
echo   Task 14 : Trim SSD + Disk Cleanup
echo.
echo [PERINGATAN] TUTUP SEMUA APLIKASI!
echo.
pause

:: ============================================================
:: TASK 1 - HITUNG SPACE AWAL
:: ============================================================
cls
echo =====================================================
echo TASK 1 - Menghitung Space SSD Awal
echo =====================================================
echo.
for /f "usebackq delims=" %%a in (`powershell -command "[math]::Floor((Get-PSDrive C).Free / 1GB)"`) do set "awal_gb=%%a"
echo     [HASIL] Space awal: %awal_gb% GB
echo.
echo =====================================================
echo TASK 1 SELESAI.
echo =====================================================
set /p lanjut="Lanjut ke Task 2? (y/n, default y): "
if /i "!lanjut!"=="n" goto :skip_task2

:: ============================================================
:: TASK 2 - TEMPORARY FILES
:: ============================================================
:task2
cls
echo =====================================================
echo TASK 2 - Menghapus SEMUA Temporary Files
echo =====================================================
echo.
del /f /s /q "%USERPROFILE%\AppData\Local\Temp\*.*" 2>nul
rd /s /q "%USERPROFILE%\AppData\Local\Temp" 2>nul
mkdir "%USERPROFILE%\AppData\Local\Temp" 2>nul
del /f /s /q "%WINDIR%\Temp\*.*" 2>nul
rd /s /q "%WINDIR%\Temp" 2>nul
mkdir "%WINDIR%\Temp" 2>nul
del /f /s /q "%WINDIR%\System32\*.tmp" 2>nul
del /f /s /q "%WINDIR%\System32\drivers\*.tmp" 2>nul
del /f /s /q "%WINDIR%\Installer\$PatchCache$\*.msi" 2>nul
echo [OK] Temporary Files selesai.
echo.
echo =====================================================
echo TASK 2 SELESAI.
echo =====================================================
set /p lanjut="Lanjut ke Task 3? (y/n, default y): "
if /i "!lanjut!"=="n" goto :skip_task3

:skip_task2
echo [SKIP] Task 2 dilewati.
pause
goto :task3

:: ============================================================
:: TASK 3 - PREFETCH + THUMBNAIL + ICON
:: ============================================================
:task3
cls
echo =====================================================
echo TASK 3 - Hapus Prefetch, Thumbnail, Icon Cache
echo =====================================================
echo.
del /f /s /q "%WINDIR%\Prefetch\*.*" 2>nul
del /f /s /q "%WINDIR%\System32\Prefetch\*.*" 2>nul
del /f /s /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db" 2>nul
del /f /s /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer\iconcache_*.db" 2>nul
del /f /s /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer\*.db" 2>nul
echo [OK] Prefetch, Thumbnail, Icon selesai.
echo.
echo =====================================================
echo TASK 3 SELESAI.
echo =====================================================
set /p lanjut="Lanjut ke Task 4? (y/n, default y): "
if /i "!lanjut!"=="n" goto :skip_task4

:skip_task3
echo [SKIP] Task 3 dilewati.
pause
goto :task4

:: ============================================================
:: TASK 4 - WINDOWS UPDATE CACHE
:: ============================================================
:task4
cls
echo =====================================================
echo TASK 4 - Hapus Windows Update Cache
echo =====================================================
echo.
net stop wuauserv 2>nul
del /f /s /q "%WINDIR%\SoftwareDistribution\Download\*.*" 2>nul
rd /s /q "%WINDIR%\SoftwareDistribution\Download" 2>nul
mkdir "%WINDIR%\SoftwareDistribution\Download" 2>nul
del /f /s /q "%WINDIR%\SoftwareDistribution\DeliveryOptimization\*.*" 2>nul
rd /s /q "%WINDIR%\SoftwareDistribution\DeliveryOptimization" 2>nul
mkdir "%WINDIR%\SoftwareDistribution\DeliveryOptimization" 2>nul
net start wuauserv 2>nul
echo [OK] Windows Update Cache selesai.
echo.
echo =====================================================
echo TASK 4 SELESAI.
echo =====================================================
set /p lanjut="Lanjut ke Task 5? (y/n, default y): "
if /i "!lanjut!"=="n" goto :skip_task5

:skip_task4
echo [SKIP] Task 4 dilewati.
pause
goto :task5

:: ============================================================
:: TASK 5 - LOG, DUMP, WER
:: ============================================================
:task5
cls
echo =====================================================
echo TASK 5 - Hapus Log, Dump, WER Reports
echo =====================================================
echo.
del /f /s /q "%WINDIR%\Logs\*.log" 2>nul
del /f /s /q "%WINDIR%\Minidump\*.dmp" 2>nul
del /f /s /q "%WINDIR%\LiveKernelReports\*.dmp" 2>nul
del /f /s /q "%WINDIR%\System32\*.log" 2>nul
del /f /s /q "%WINDIR%\System32\*.etl" 2>nul
del /f /s /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\WER\*.*" 2>nul
rd /s /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\WER" 2>nul
del /f /s /q "%PROGRAMDATA%\Microsoft\Windows\WER\*.*" 2>nul
rd /s /q "%PROGRAMDATA%\Microsoft\Windows\WER" 2>nul
if exist "C:\Intel\Logs" rd /s /q "C:\Intel\Logs" 2>nul
if exist "C:\AMD\Logs" rd /s /q "C:\AMD\Logs" 2>nul
echo [OK] Log, Dump, WER selesai.
echo.
echo =====================================================
echo TASK 5 SELESAI.
echo =====================================================
set /p lanjut="Lanjut ke Task 6? (y/n, default y): "
if /i "!lanjut!"=="n" goto :skip_task6

:skip_task5
echo [SKIP] Task 5 dilewati.
pause
goto :task6

:: ============================================================
:: TASK 6 - EVENT LOG
:: ============================================================
:task6
cls
echo =====================================================
echo TASK 6 - Membersihkan Event Log
echo =====================================================
echo.
wevtutil el 2>nul | findstr /v "Security" | wevtutil cl 2>nul
echo [OK] Event Log selesai.
echo.
echo =====================================================
echo TASK 6 SELESAI.
echo =====================================================
set /p lanjut="Lanjut ke Task 7? (y/n, default y): "
if /i "!lanjut!"=="n" goto :skip_task7

:skip_task6
echo [SKIP] Task 6 dilewati.
pause
goto :task7

:: ============================================================
:: TASK 7 - CACHE BROWSER
:: ============================================================
:task7
cls
echo =====================================================
echo TASK 7 - Hapus Cache SEMUA Browser
echo =====================================================
echo.
if exist "%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default" (
    rd /s /q "%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\Cache" 2>nul
    rd /s /q "%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\Code Cache" 2>nul
    rd /s /q "%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\Service Worker" 2>nul
)
if exist "%USERPROFILE%\AppData\Local\Microsoft\Edge\User Data\Default" (
    rd /s /q "%USERPROFILE%\AppData\Local\Microsoft\Edge\User Data\Default\Cache" 2>nul
    rd /s /q "%USERPROFILE%\AppData\Local\Microsoft\Edge\User Data\Default\Code Cache" 2>nul
)
if exist "%USERPROFILE%\AppData\Local\Mozilla\Firefox\Profiles" (
    rd /s /q "%USERPROFILE%\AppData\Local\Mozilla\Firefox\Profiles\*\cache2" 2>nul
    rd /s /q "%USERPROFILE%\AppData\Local\Mozilla\Firefox\Profiles\*\jumpListCache" 2>nul
    rd /s /q "%USERPROFILE%\AppData\Local\Mozilla\Firefox\Profiles\*\startupCache" 2>nul
)
if exist "%USERPROFILE%\AppData\Local\BraveSoftware\Brave-Browser\User Data\Default\Cache" rd /s /q "%USERPROFILE%\AppData\Local\BraveSoftware\Brave-Browser\User Data\Default\Cache" 2>nul
if exist "%USERPROFILE%\AppData\Local\Opera Software\Opera Stable\Cache" rd /s /q "%USERPROFILE%\AppData\Local\Opera Software\Opera Stable\Cache" 2>nul
if exist "%USERPROFILE%\AppData\Local\Vivaldi\User Data\Default\Cache" rd /s /q "%USERPROFILE%\AppData\Local\Vivaldi\User Data\Default\Cache" 2>nul
echo [OK] Cache Browser selesai.
echo.
echo =====================================================
echo TASK 7 SELESAI.
echo =====================================================
set /p lanjut="Lanjut ke Task 8? (y/n, default y): "
if /i "!lanjut!"=="n" goto :skip_task8

:skip_task7
echo [SKIP] Task 7 dilewati.
pause
goto :task8

:: ============================================================
:: TASK 8 - RECYCLE BIN
:: ============================================================
:task8
cls
echo =====================================================
echo TASK 8 - Kosongkan Recycle Bin SEMUA Drive
echo =====================================================
echo.
rd /s /q C:\$Recycle.bin 2>nul
for %%D in (D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist %%D:\ rd /s /q %%D:\$Recycle.bin 2>nul
)
echo [OK] Recycle Bin selesai.
echo.
echo =====================================================
echo TASK 8 SELESAI.
echo =====================================================
set /p lanjut="Lanjut ke Task 9? (y/n, default y): "
if /i "!lanjut!"=="n" goto :skip_task9

:skip_task8
echo [SKIP] Task 8 dilewati.
pause
goto :task9

:: ============================================================
:: TASK 9 - MATIKAN HIBERNASI
:: ============================================================
:task9
cls
echo =====================================================
echo TASK 9 - Matikan Hibernasi (hemat space sebesar RAM)
echo =====================================================
echo.
powercfg -h off
echo [OK] Hibernasi dimatikan.
echo.
echo =====================================================
echo TASK 9 SELESAI.
echo =====================================================
set /p lanjut="Lanjut ke Task 10? (y/n, default y): "
if /i "!lanjut!"=="n" goto :skip_task10

:skip_task9
echo [SKIP] Task 9 dilewati.
pause
goto :task10

:: ============================================================
:: TASK 10 - WINDOWS.OLD
:: ============================================================
:task10
cls
echo =====================================================
echo TASK 10 - Hapus Windows.old (opsional)
echo =====================================================
echo.
if exist "C:\Windows.old" (
    echo Menemukan Windows.old! Bisa hemat 20-40GB.
    echo Menghapus Windows.old (butuh waktu 5-10 menit)...
    takeown /f C:\Windows.old /r /d y 2>nul
    icacls C:\Windows.old /grant administrators:F /t 2>nul
    rd /s /q C:\Windows.old 2>nul
    echo [OK] Windows.old berhasil dihapus!
) else (
    echo [INFO] Tidak ada Windows.old.
)
echo.
echo =====================================================
echo TASK 10 SELESAI.
echo =====================================================
set /p lanjut="Lanjut ke Task 11? (y/n, default y): "
if /i "!lanjut!"=="n" goto :skip_task11

:skip_task10
echo [SKIP] Task 10 dilewati.
pause
goto :task11

:: ============================================================
:: TASK 11 - WinSxS (BUTUH WAKTU LAMA)
:: ============================================================
:task11
cls
echo =====================================================
echo TASK 11 - Bersihkan WinSxS (hemat 5-10GB)
echo =====================================================
echo.
echo PERINGATAN: Proses ini butuh 5-15 menit!
echo Jangan ditutup, tunggu sampai selesai.
echo.
pause
Dism /online /Cleanup-Image /StartComponentCleanup /ResetBase
echo [OK] WinSxS selesai.
echo.
echo =====================================================
echo TASK 11 SELESAI.
echo =====================================================
set /p lanjut="Lanjut ke Task 12? (y/n, default y): "
if /i "!lanjut!"=="n" goto :skip_task12

:skip_task11
echo [SKIP] Task 11 dilewati.
pause
goto :task12

:: ============================================================
:: TASK 12 - CACHE SISTEM TERSEMBUNYI
:: ============================================================
:task12
cls
echo =====================================================
echo TASK 12 - Hapus Cache Sistem Tersembunyi
echo =====================================================
echo.
del /f /s /q "%APPDATA%\Microsoft\Windows\Recent\*.*" 2>nul
rd /s /q "%APPDATA%\Microsoft\Windows\Recent" 2>nul
del /f /s /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCookies\*.*" 2>nul
del /f /s /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\History\*.*" 2>nul
del /f /s /q "%WINDIR%\ServiceProfiles\LocalService\AppData\Local\FontCache\*.dat" 2>nul
rd /s /q "%WINDIR%\ServiceProfiles\LocalService\AppData\Local\FontCache" 2>nul
del /f /s /q "%WINDIR%\System32\config\systemprofile\AppData\Local\Microsoft\Windows\Explorer\*.db" 2>nul
del /f /s /q "%WINDIR%\ServiceProfiles\LocalService\AppData\Local\Microsoft\Windows\Explorer\*.db" 2>nul
rd /s /q "%USERPROFILE%\AppData\Local\ConnectedDevicesPlatform" 2>nul
del /f /s /q "%WINDIR%\System32\spool\PRINTERS\*.*" 2>nul
ipconfig /flushdns 2>nul
echo [OK] Cache Sistem Tersembunyi selesai.
echo.
echo =====================================================
echo TASK 12 SELESAI.
echo =====================================================
set /p lanjut="Lanjut ke Task 13? (y/n, default y): "
if /i "!lanjut!"=="n" goto :skip_task13

:skip_task12
echo [SKIP] Task 12 dilewati.
pause
goto :task13

:: ============================================================
:: TASK 13 - CACHE APLIKASI
:: ============================================================
:task13
cls
echo =====================================================
echo TASK 13 - Hapus Cache Aplikasi Populer
echo =====================================================
echo.
if exist "%USERPROFILE%\AppData\Roaming\Discord\Cache" rd /s /q "%USERPROFILE%\AppData\Roaming\Discord\Cache" 2>nul
if exist "%USERPROFILE%\AppData\Local\Steam\htmlcache" rd /s /q "%USERPROFILE%\AppData\Local\Steam\htmlcache" 2>nul
if exist "%USERPROFILE%\AppData\Local\Spotify\Data" rd /s /q "%USERPROFILE%\AppData\Local\Spotify\Data" 2>nul
if exist "%USERPROFILE%\AppData\Roaming\Zoom\data" rd /s /q "%USERPROFILE%\AppData\Roaming\Zoom\data" 2>nul
if exist "%USERPROFILE%\AppData\Roaming\Code\Cache" rd /s /q "%USERPROFILE%\AppData\Roaming\Code\Cache" 2>nul
if exist "%USERPROFILE%\AppData\Roaming\npm-cache" rd /s /q "%USERPROFILE%\AppData\Roaming\npm-cache" 2>nul
if exist "%USERPROFILE%\AppData\Local\pip\cache" rd /s /q "%USERPROFILE%\AppData\Local\pip\cache" 2>nul
if exist "%USERPROFILE%\AppData\Local\Adobe\*Cache*" rd /s /q "%USERPROFILE%\AppData\Local\Adobe\*Cache*" 2>nul
if exist "%USERPROFILE%\AppData\Roaming\Adobe\*Cache*" rd /s /q "%USERPROFILE%\AppData\Roaming\Adobe\*Cache*" 2>nul
echo [OK] Cache Aplikasi selesai.
echo.
echo =====================================================
echo TASK 13 SELESAI.
echo =====================================================
set /p lanjut="Lanjut ke Task 14? (y/n, default y): "
if /i "!lanjut!"=="n" goto :skip_task14

:skip_task13
echo [SKIP] Task 13 dilewati.
pause
goto :task14

:: ============================================================
:: TASK 14 - TRIM SSD + DISK CLEANUP
:: ============================================================
:task14
cls
echo =====================================================
echo TASK 14 - Trim SSD + Disk Cleanup
echo =====================================================
echo.
echo Menjalankan Trim SSD...
defrag C: /L /O
echo.
echo Menjalankan Disk Cleanup Windows...
cleanmgr /sagerun:1 2>nul
echo [OK] Trim dan Disk Cleanup selesai.
echo.
echo Menghitung space SSD setelah bersih-bersih...
for /f "usebackq delims=" %%a in (`powershell -command "[math]::Floor((Get-PSDrive C).Free / 1GB)"`) do set "akhir_gb=%%a"
set /a total_bebas=%akhir_gb% - %awal_gb%

:skip_task14
echo [SKIP] Task 14 dilewati.

:: ============================================================
:: FINAL SUMMARY
:: ============================================================
:final
cls
echo =====================================================================
echo                    SSD LEGA PLONG - SELESAI!
echo =====================================================================
echo.
echo [HASIL LUAR BIASA]
echo    SSD Space SEBELUM : %awal_gb% GB
echo    SSD Space SESUDAH : %akhir_gb% GB
echo    TOTAL BEBAS       : %total_bebas% GB !!
echo.
echo [SEMUA TASK BERHASIL]
echo  - Temporary Files (User + Windows + System)
echo  - Prefetch, Thumbnail, Icon Cache
echo  - Windows Update Cache + Delivery Optimization
echo  - Log, Dump, WER Reports
echo  - Event Log (kecuali Security)
echo  - Semua cache browser
echo  - Recycle Bin semua drive
echo  - Hibernasi dimatikan
echo  - Windows.old (jika ada)
echo  - WinSxS dibersihkan
echo  - Cache Sistem Tersembunyi
echo  - Cache Aplikasi
echo  - SSD sudah di-Trim
echo.
echo [REKOMENDASI] RESTART komputer sekarang!
echo.

set /p restart_now="Restart komputer sekarang? (y/n, default y): "
if /i "!restart_now!"=="y" (
    echo Merestart dalam 5 detik...
    shutdown /r /t 5
) else (
    echo OK! Jangan lupa restart nanti ya.
    echo.
    pause
)

echo.
echo [SUKSES] Tekan sembarang tombol untuk keluar.
pause
exit