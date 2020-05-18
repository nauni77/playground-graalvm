# Installation of GraalVM

First go to download page of GraalVM.

https://www.graalvm.org/downloads/

Now download the desired version (f.e. Community Edition 20.0.0) for your environment (macOS, Linux, Windows). Install the corresponding OpenJDK - you can find this at download page:

```
The following GraalVM Community Edition builds are available:

GraalVM Community Edition 20.0.0 based on OpenJDK 8u242
GraalVM Community Edition 20.0.0 based on OpenJDK 11.0.6
GraalVM Community Edition 19.3.1 based on OpenJDK 8u242
GraalVM Community Edition 19.3.1 based on OpenJDK 11.0.6
The following Oracle GraalVM Enterprise Edition builds are available:

Oracle GraalVM Enterprise Edition 20.0.1 based on Oracle Java SE 8u251
Oracle GraalVM Enterprise Edition 20.0.1 based on Oracle Java SE 11.0.7
Oracle GraalVM Enterprise Edition 19.3.2 based on Oracle Java SE 8u251
Oracle GraalVM Enterprise Edition 19.3.2 based on Oracle Java SE 11.0.7
```

Extract the GraalVM to your location. Now add the corresponding environment variable.

```
$ echo $GRAALVM_HOME
/Users/wagnerol/bin/SDKs/graalVM/current/Contents/Home
```

Go to directory `$GRAALVM_HOME/bin` and install the native image component with `./gu install native-image`.

Now you can check with submodule `graalvm01hello` if everything is correct installed.



# development and building with QUARKUS

First I used the generation from `https://quarkus.io/`. After extracting the ZIP file everything is in place.

## development

`./gradlew quarkusDev` 

Compiles and start the server. Every change in source will be compiled and redeployed to existing server. This means after save changes the changes will be present at test environment.

`./gradlew testNative`

This will build a native image and run the tests with this newly created image.

## just build the jar to start

`./gradlew quarkusBuild`

At directory `/build/` you can start the application with:

```
$ java -cp lib -jar quarkus01hello-0.0.1-SNAPSHOT-runner.jar
```

This makes it possible to optimize container build. That means at layer X you add all libraries from `/lib` directory. And the last layer X+1 will contain `quarkus01hello-0.0.1-SNAPSHOT-runner.jar`. This means each container is only a little bigger than the last container, because layer X is still the same (until the dependencies change).

## native build

`./gradlew build -Dquarkus.package.type=native`

Build a native executable into the `build/` directory. Can be executed at current system - in my case OS X. You can simply execute `$ ./build/quarkus01hello-0.0.1-SNAPSHOT-runner`.

At directory `/build/quarkus01hello-0.0.1-SNAPSHOT-native-image-source-jar` you find the jar and libs to start with `java -cp lib -jar xyz.jar`.

## vative build with docker (linux)

`./gradlew build -Dquarkus.package.type=native -Dquarkus.native.container-build=true`

The produced executable will be a 64 bit Linux executable, so depending on your operating system it may no longer be runnable. However, it’s not an issue as we are going to copy it to a Docker container. Note that in this case the build itself runs in a Docker container too, **so you don’t need to have GraalVM installed locally**.

Works, `build/quarkus01hello-0.0.1-SNAPSHOT-runner` can be executed at 64-bit linux system. But **not** at macbook pro!