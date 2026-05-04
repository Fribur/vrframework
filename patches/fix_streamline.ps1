# patches/fix_streamline.ps1
$file = "CMakeLists.txt"
$content = Get-Content $file -Raw
$content = "cmake_policy(SET CMP0175 OLD)`r`n" + $content
$content | Set-Content $file -NoNewline