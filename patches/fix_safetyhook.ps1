# patches/fix_safetyhook.ps1
$file = "CMakeLists.txt"
$content = Get-Content $file -Raw

# The exact block to find (Matches the formatting in your provided file)
$oldBlock = @"
if(SAFETYHOOK_FETCH_ZYDIS) # fetch-zydis
	option(ZYDIS_BUILD_EXAMPLES "" OFF)
	option(ZYDIS_BUILD_TOOLS "" OFF)
	option(ZYDIS_BUILD_DOXYGEN "" OFF)

	message(STATUS "Fetching Zydis (v4.1.0)...")
	FetchContent_Declare(Zydis
		GIT_REPOSITORY
			"https://github.com/zyantific/zydis.git"
		GIT_TAG
			v4.1.0
		GIT_SHALLOW
			ON
		EXCLUDE_FROM_ALL
			ON
	)
	FetchContent_MakeAvailable(Zydis)

endif()
"@

# The new block to inject
$newBlock = @"
if(SAFETYHOOK_FETCH_ZYDIS) # fetch-zydis
	option(ZYDIS_BUILD_EXAMPLES "" OFF)
	option(ZYDIS_BUILD_TOOLS "" OFF)
	option(ZYDIS_BUILD_DOXYGEN "" OFF)

	message(STATUS "Fetching Zydis (v4.1.1)...")
	FetchContent_Declare(Zydis
		GIT_REPOSITORY "https://github.com/zyantific/zydis.git"
		GIT_TAG "9bfadd6a55fc92dbd37fa3ba089bf8b36622df4f"
		GIT_SHALLOW	ON
		EXCLUDE_FROM_ALL ON
	)
	FetchContent_MakeAvailable(Zydis)

endif()
"@

# Check for the old block and replace it
if ($content -match [regex]::Escape($oldBlock)) {
    $content = $content -replace [regex]::Escape($oldBlock), $newBlock
    $content | Set-Content $file -NoNewline
    Write-Output "Successfully updated Zydis FetchContent block to v4.1.1 hash."
} else {
    Write-Output "Zydis block not found or already updated."
}