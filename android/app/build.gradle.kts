android {
    namespace = "com.example.agoravaicronometro"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        coreLibraryDesugaringEnabled true

    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.agoravaicronometro"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

// O dependencies deve ficar fora do bloco android
dependencies {
    coreLibraryDesugaring "com.android.tools:desugar_jdk_libs:2.0.3"
    // outras dependências já existentes
}

flutter {
    source = "../.."
}
