@echo off
setlocal EnableDelayedExpansion

:: Set the current directory of the script
set "scriptDir=%~dp0"
cd /d "%scriptDir%"

:: Set the output file and script file names
set "output_file=file_listing.html"
set "script_file=expand-collapse.js"

(
  echo ^<html^>
  echo ^<head^>
    echo ^<title^>Directory Listing for %scriptDir%^</title^>
    echo ^<script src="%script_file%"^></script^>
  echo ^</head^>
  echo ^<body^>
    echo ^<h1^>Directory: %scriptDir%^</h1^>
    echo ^<hr^>

    call :PrintTree "%scriptDir%"

    echo ^<hr^>
  echo ^</body^>
echo ^</html^>
) > %output_file%

echo HTML file generated: %output_file%

pause
exit /b

:PrintTree
set "indent="
for /L %%i in (1,1,%1) do (
  set "indent=!indent!  "
)

:: Remove quotes from the directory path
set "currentDir=%~1"
set "currentDir=!currentDir:"=!"

if exist "!currentDir!\*.*" (
  echo %indent%^<h3^><a href="#" onclick="toggle('dir_!currentDir!')"^>Directory: !currentDir!^</a^></h3^>
  echo %indent%^<ul id="dir_!currentDir!" style="display:none"^>

  for /r "!currentDir!" %%f in (*) do (
    set "relPath=%%~pf"
    set "relPath=!relPath:%scriptDir%=!"
    set "relPath=!relPath:&=^&!"
    set "relPath=!relPath:|=^|!"
    set "relPath=!relPath:<=^<!"
    set "relPath=!relPath:>=^>!"
    set "relPath=!relPath:"=^"!"
    set "relPath=!relPath:\=\\!"
    set "relPath=!relPath: =%%20!"
    echo %indent%^ ^<li^><a href="!relPath!%%~nxf"^>!relPath!%%~nxf^</a^></li^>
  )

  for /d %%b in ("!currentDir!\*") do (
    call :PrintTree "%%b"
  )

  echo %indent%^</ul^>
)

exit /b
