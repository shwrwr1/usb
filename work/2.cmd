@echo off

:: Get the current directory of the script
set "dir=%CD%"
set "output_file=file_listing.html"
set "script_file=expand-collapse.js"

(
echo ^<html^>
echo   ^<head^>
echo     ^<title^>Directory Listing for %dir%^</title^>
echo     ^<script src="%script_file%"^></script^>
echo   ^</head^>
echo   ^<body^>
echo     ^<h1^>Directory: %dir%^</h1^>
echo     ^<hr^>

call :PrintTree "%dir%"

echo     ^<hr^>
echo   ^</body^>
echo ^</html^>
) > %output_file%

echo HTML file generated: %output_file%

pause
exit /b

:PrintTree
setlocal
set "indent="
for /L %%i in (1,1,%1) do (
  set "indent=!indent!  "
)

echo %indent%^<h3^><a href="#" onclick="toggle('dir_%1')"^>Directory: %1^</a^></h3^>
echo %indent%^<ul id="dir_%1" style="display:none"^>

for /r %1 %%f in (*) do (
  set "relPath=%%~pf"
  set "relPath=!relPath:%dir%=!"
  set "relPath=!relPath:\=!"
  set "relPath=!relPath: =!\\!"
  echo %indent%^  ^<li^><a href="%%f"^>%relPath%%%~nxf^</a^></li^>
)

for /d %%b in ("%1\*") do (
  call :PrintTree "%%b"
)

echo %indent%^</ul^>
endlocal
exit /b
