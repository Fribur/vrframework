# patches/fix_minhook.ps1
$file = "CMakeLists.txt"
$content = Get-Content $file -Raw

# These are treated as literal strings, no regex needed
$old = "VERSION 3.0...3.5"
$new = "VERSION 3.10...3.27"

if ($content.Contains($old)) {
    $content = $content.Replace($old, $new)
    $content | Set-Content $file -NoNewline
    Write-Output "Successfully patched minhook."
} else {
    Write-Output "Patch already applied to minhook"
}