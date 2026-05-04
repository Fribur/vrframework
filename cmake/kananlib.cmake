include(FetchContent)
message("Fetching bddisasm (v1.37.0)...")
FetchContent_Declare(bddisasm
        GIT_REPOSITORY "https://github.com/bitdefender/bddisasm"
        #GIT_TAG "v3.0.1"
        GIT_TAG v1.37.0
)
FetchContent_MakeAvailable(bddisasm)

# kananlib
FetchContent_Declare(
        kananlib
        GIT_REPOSITORY "https://github.com/cursey/kananlib.git"
        GIT_TAG 8c27b656734355db0f2893581fd62e838fa130ad
        #GIT_TAG 05fe2456b58fa423531d036d9343ae46866d7ffd
)

message("Fetching kananlib")
FetchContent_MakeAvailable(kananlib)
target_compile_definitions(kananlib
        PRIVATE
        $<$<CXX_COMPILER_ID:Clang>:_ThrowInfo=ThrowInfo>
        $<$<CXX_COMPILER_ID:Clang>:NTSTATUS=LONG>
)