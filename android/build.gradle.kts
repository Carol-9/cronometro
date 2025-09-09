pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        file("local.properties").inputStream().use { properties.load(it) }
        val flutterSdkPath = properties.getProperty("flutter.sdk")
        require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
        flutterSdkPath
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.7.0" apply false   // Alinhado com a versão no classpath
    id("org.jetbrains.kotlin.android") version "2.0.20" apply false  // Alinhado com Kotlin já no classpath
}

<<<<<<< HEAD
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
=======
include(":app")
>>>>>>> 7ff3e7fb17173a01e3a961452eca0c2634537888
