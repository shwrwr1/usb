@echo off

rem set "dir=C:\path\to\your\directory"
 set "dir=./"
set "output_file=file_listing.html"

(
echo ^<html^>
echo   ^<head^>
echo     ^<title^>Directory Listing for %dir%^</title^>
echo   ^</head^>
echo   ^<body^>
echo     ^<h1^>Directory: %dir%^</h1^>
echo     ^<hr^>

for /d %%a in ("%dir%\*") do (
  echo     ^<h3^>Directory: %%a^</h3^>
  echo     ^<ul^>
  for /r "%%a" %%f in (*) do (
    echo       ^<li^><a href="%%f"^>%%f^</a^></li^>
  )
  echo     ^</ul^>
)

echo     ^<hr^>
echo   ^</body^>
echo ^</html^>
) > %output_file%

echo HTML file generated: %output_file%

pause
