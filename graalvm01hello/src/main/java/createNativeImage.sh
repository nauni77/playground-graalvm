#!/usr/bin/env bash
# build class file to out/ directory
javac -d out/ HelloGraalVM.java
# create a native image from class
# $ echo $GRAALVM_HOME
# /Users/wagnerol/bin/SDKs/graalVM/current/Contents/Home

#$GRAALVM_HOME/bin/native-image -cp out/ HelloGraalVM

cd out/
$GRAALVM_HOME/bin/native-image HelloGraalVM