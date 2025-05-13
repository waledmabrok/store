// تعريف buildscript لاحتواء التبعيات الخاصة بـ Gradle
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:7.4.0")  // التبعية الخاصة بـ Android Gradle Plugin
        classpath("com.google.gms:google-services:4.4.2")   // التبعية الخاصة بـ Google Services
    }
}

// هنا يتم تحديد خصائص المشاريع الفرعية
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
