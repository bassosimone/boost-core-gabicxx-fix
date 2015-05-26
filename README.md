# Fix boost/core to compile with gabi++

To start off, you need to recursively clone this repository:

    git clone --recursive https://github.com/bassosimone/boost-core-gabicxx-fix

Minimal test case for testing my fix to allow [boost/core](https://github.com/boostorg/core) to compile with [gabi++](https://android.googlesource.com/platform/ndk/+/master/sources/cxx-stl/gabi++/).

To compile, you need to [install Android NDK first](https://developer.android.com/tools/sdk/ndk/index.html). This bug and the related fix was tested using both version 10d and version 10e of the Android NDK. To install the latest NDK as of this writing (i.e., 10e), you can do the following:

    $ cd $HOME
    $ mkdir Android
    $ cd Android
    $ wget https://dl.google.com/android/ndk/android-ndk-r10e-linux-x86_64.bin
       ... check the checksum ...
    $ chmod +x android-ndk-r10e-linux-x86_64.bin
    $ ./android-ndk-r10e-linux-x86_64.bin

Then, to check that everything works you just need to invoke `ndk-build`. In fact, the version of `boost/core` included as a submodule points to the [fix/demangle-with-gabicxx](https://github.com/bassosimone/libight-boost-core/tree/fix/demangle-with-gabicxx) branch that contains [the fix](https://github.com/bassosimone/libight-boost-core/commit/574d96f61af1c06dd087340c256c74fc2899ce88). This is what I get on my Ubuntu 15.04 machine with NDK v10e:

    $ rm -rf obj/*  # Start over
    $ ~/Android/android-ndk-r10e/ndk-build -k
    [arm64-v8a] Compile++      : main <= main.cpp
    [arm64-v8a] StaticLibrary  : libmain.a
    [x86_64] Compile++      : main <= main.cpp
    [x86_64] StaticLibrary  : libmain.a
    [mips64] Compile++      : main <= main.cpp
    [mips64] StaticLibrary  : libmain.a
    [armeabi-v7a] Compile++ thumb: main <= main.cpp
    [armeabi-v7a] StaticLibrary  : libmain.a
    [armeabi] Compile++ thumb: main <= main.cpp
    [armeabi] StaticLibrary  : libmain.a
    [x86] Compile++      : main <= main.cpp
    [x86] StaticLibrary  : libmain.a
    [mips] Compile++      : main <= main.cpp
    [mips] StaticLibrary  : libmain.a

To compile against the original master branch of boost/core, instead, it suffices to enter into the `boost_core` directory and to checkout the master branch

    $ rm -rf obj/*
    $ cd boost_core/
    $ git checkout master
    $ cd ..
    $ ~/Android/android-ndk-r10e/ndk-build -k

The output should be something like this:
    
    [arm64-v8a] Compile++      : main <= main.cpp
    [arm64-v8a] StaticLibrary  : libmain.a
    [x86_64] Compile++      : main <= main.cpp
    In file included from jni/main.cpp:1:
    boost_core/include/boost/core/demangle.hpp:75:17: error: no member named '__cxa_demangle' in namespace '__cxxabiv1'
        return abi::__cxa_demangle( name, NULL, &size, &status );
               ~~~~~^
    1 error generated.
    make: *** [obj/local/x86_64/objs/main/main.o] Error 1
    [mips64] Compile++      : main <= main.cpp
    In file included from jni/main.cpp:1:
    boost_core/include/boost/core/demangle.hpp:75:17: error: no member named '__cxa_demangle' in namespace '__cxxabiv1'
        return abi::__cxa_demangle( name, NULL, &size, &status );
               ~~~~~^
    1 error generated.
    make: *** [obj/local/mips64/objs/main/main.o] Error 1
    [armeabi-v7a] Compile++ thumb: main <= main.cpp
    [armeabi-v7a] StaticLibrary  : libmain.a
    [armeabi] Compile++ thumb: main <= main.cpp
    [armeabi] StaticLibrary  : libmain.a
    [x86] Compile++      : main <= main.cpp
    In file included from jni/main.cpp:1:
    boost_core/include/boost/core/demangle.hpp:75:17: error: no member named '__cxa_demangle' in namespace '__cxxabiv1'
        return abi::__cxa_demangle( name, NULL, &size, &status );
               ~~~~~^
    1 error generated.
    make: *** [obj/local/x86/objs/main/main.o] Error 1
    [mips] Compile++      : main <= main.cpp
    In file included from jni/main.cpp:1:
    boost_core/include/boost/core/demangle.hpp:75:17: error: no member named '__cxa_demangle' in namespace '__cxxabiv1'
        return abi::__cxa_demangle( name, NULL, &size, &status );
               ~~~~~^
    1 error generated.
    make: *** [obj/local/mips/objs/main/main.o] Error 1
    make: Target `all' not remade because of errors.
