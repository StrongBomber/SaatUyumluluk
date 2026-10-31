# APK denetim raporu

- APK: `Subway+Surfers_3.70.3_APKPure.apk`
- Boyut: 269958630 bayt
- Calistirilan etiket: apk-v3.70.3

## lib/ altindaki ABI klasorleri
```
     22 arm64-v8a
     22 armeabi-v7a
```

## ABI basina toplam boyut
```
arm64-v8a: 109613976 bayt (104 MiB)
armeabi-v7a: 92159884 bayt (87 MiB)
```

## Iki ABI arasinda kutuphane esligi (parity)
```
arm64-v8a: 22 dosya, armeabi-v7a: 22 dosya
--- yalnizca 64-bit ---
--- yalnizca 32-bit ---
```

## Yerel kutuphanelerin APK icinde saklanma bicimi
```
81111792  Defl:N 22261454  73% 1981-01-01 01:01 9af30419  lib/arm64-v8a/libil2cpp.so
19189240  Defl:N  8274395  57% 1981-01-01 01:01 54af1ba5  lib/arm64-v8a/libunity.so
69990004  Defl:N 22303101  68% 1981-01-01 01:01 092130a7  lib/armeabi-v7a/libil2cpp.so
14388344  Defl:N  7669475  47% 1981-01-01 01:01 00d6e03f  lib/armeabi-v7a/libunity.so
```

## ELF sayfa hizasi (16 KB sayfa destegi icin kritik)
```
-- arm64-v8a/libil2cpp.so
0x4000 
-- arm64-v8a/libunity.so
0x4000 
-- armeabi-v7a/libil2cpp.so
0x4000 
-- armeabi-v7a/libunity.so
0x4000 
```

## aapt badging
```
package: name='com.kiloo.subwaysurf' versionCode='96919' versionName='3.70.3' platformBuildVersionName='16' platformBuildVersionCode='36' compileSdkVersion='36' compileSdkVersionCodename='16'
targetSdkVersion:'36'
launchable-activity: name='com.sybogames.chili.multidex.ChiliMultidexSupportActivity'  label='Subway Surf' icon=''
  uses-feature-not-required: name='android.hardware.gamepad'
  uses-feature-not-required: name='android.hardware.touchscreen'
  uses-feature-not-required: name='android.hardware.touchscreen.multitouch'
  uses-feature-not-required: name='android.hardware.touchscreen.multitouch.distinct'
  uses-feature-not-required: name='android.hardware.vulkan.version'
  uses-feature: name='android.hardware.screen.portrait'
densities: '120' '160' '240' '320' '480' '640' '65534' '65535'
native-code: 'arm64-v8a' 'armeabi-v7a'
```

## Manifest ozeti (ilk bolum)
```
N: android=http://schemas.android.com/apk/res/android (line=2)
  E: manifest (line=2)
    A: http://schemas.android.com/apk/res/android:versionCode(0x0101021b)=96919
    A: http://schemas.android.com/apk/res/android:versionName(0x0101021c)="3.70.3" (Raw: "3.70.3")
    A: http://schemas.android.com/apk/res/android:installLocation(0x010102b7)=1
    A: http://schemas.android.com/apk/res/android:compileSdkVersion(0x01010572)=36
    A: http://schemas.android.com/apk/res/android:compileSdkVersionCodename(0x01010573)="16" (Raw: "16")
    A: package="com.kiloo.subwaysurf" (Raw: "com.kiloo.subwaysurf")
    A: platformBuildVersionCode=36
    A: platformBuildVersionName=16
      E: uses-sdk (line=8)
        A: http://schemas.android.com/apk/res/android:minSdkVersion(0x0101020c)=24
        A: http://schemas.android.com/apk/res/android:targetSdkVersion(0x01010270)=36
      E: supports-screens (line=12)
        A: http://schemas.android.com/apk/res/android:anyDensity(0x0101026c)=true
        A: http://schemas.android.com/apk/res/android:smallScreens(0x01010284)=true
        A: http://schemas.android.com/apk/res/android:normalScreens(0x01010285)=true
        A: http://schemas.android.com/apk/res/android:largeScreens(0x01010286)=true
        A: http://schemas.android.com/apk/res/android:xlargeScreens(0x010102bf)=true
      E: uses-permission (line=19)
        A: http://schemas.android.com/apk/res/android:name(0x01010003)="android.permission.WAKE_LOCK" (Raw: "android.permission.WAKE_LOCK")
      E: uses-permission (line=20)
        A: http://schemas.android.com/apk/res/android:name(0x01010003)="android.permission.VIBRATE" (Raw: "android.permission.VIBRATE")
      E: uses-permission (line=21)
        A: http://schemas.android.com/apk/res/android:name(0x01010003)="android.permission.INTERNET" (Raw: "android.permission.INTERNET")
      E: uses-permission (line=22)
        A: http://schemas.android.com/apk/res/android:name(0x01010003)="android.permission.ACCESS_NETWORK_STATE" (Raw: "android.permission.ACCESS_NETWORK_STATE")
      E: uses-feature (line=24)
        A: http://schemas.android.com/apk/res/android:name(0x01010003)="android.hardware.gamepad" (Raw: "android.hardware.gamepad")
        A: http://schemas.android.com/apk/res/android:required(0x0101028e)=false
      E: uses-feature (line=27)
        A: http://schemas.android.com/apk/res/android:glEsVersion(0x01010281)=0x00020000
      E: uses-feature (line=28)
        A: http://schemas.android.com/apk/res/android:name(0x01010003)="android.hardware.vulkan.version" (Raw: "android.hardware.vulkan.version")
        A: http://schemas.android.com/apk/res/android:required(0x0101028e)=false
      E: uses-feature (line=31)
        A: http://schemas.android.com/apk/res/android:name(0x01010003)="android.hardware.touchscreen" (Raw: "android.hardware.touchscreen")
        A: http://schemas.android.com/apk/res/android:required(0x0101028e)=false
      E: uses-feature (line=34)
        A: http://schemas.android.com/apk/res/android:name(0x01010003)="android.hardware.touchscreen.multitouch" (Raw: "android.hardware.touchscreen.multitouch")
        A: http://schemas.android.com/apk/res/android:required(0x0101028e)=false
      E: uses-feature (line=37)
        A: http://schemas.android.com/apk/res/android:name(0x01010003)="android.hardware.touchscreen.multitouch.distinct" (Raw: "android.hardware.touchscreen.multitouch.distinct")
        A: http://schemas.android.com/apk/res/android:required(0x0101028e)=false
      E: uses-permission (line=41)
        A: http://schemas.android.com/apk/res/android:name(0x01010003)="BIND_GET_INSTALL_REFERRER_SERVICE" (Raw: "BIND_GET_INSTALL_REFERRER_SERVICE")
      E: uses-permission (line=42)
        A: http://schemas.android.com/apk/res/android:name(0x01010003)="com.android.vending.CHECK_LICENSE" (Raw: "com.android.vending.CHECK_LICENSE")
      E: uses-permission (line=43)
        A: http://schemas.android.com/apk/res/android:name(0x01010003)="com.google.android.gms.permission.AD_ID" (Raw: "com.google.android.gms.permission.AD_ID")
      E: queries (line=45)
          E: package (line=46)
            A: http://schemas.android.com/apk/res/android:name(0x01010003)="com.facebook.katana" (Raw: "com.facebook.katana")
          E: package (line=47)
            A: http://schemas.android.com/apk/res/android:name(0x01010003)="com.google.android.gms" (Raw: "com.google.android.gms")
          E: package (line=48)
            A: http://schemas.android.com/apk/res/android:name(0x01010003)="com.android.vending" (Raw: "com.android.vending")
          E: intent (line=50)
              E: action (line=51)
                A: http://schemas.android.com/apk/res/android:name(0x01010003)="com.android.vending.billing.InAppBillingService.BIND" (Raw: "com.android.vending.billing.InAppBillingService.BIND")
          E: intent (line=53)
              E: action (line=54)
                A: http://schemas.android.com/apk/res/android:name(0x01010003)="com.google.android.apps.play.billingtestcompanion.BillingOverrideService.BIND" (Raw: "com.google.android.apps.play.billingtestcompanion.BillingOverrideService.BIND")
          E: intent (line=56)
              E: action (line=57)
                A: http://schemas.android.com/apk/res/android:name(0x01010003)="com.singular.preinstall.READ_PERMISSION_SINGULAR" (Raw: "com.singular.preinstall.READ_PERMISSION_SINGULAR")
          E: package (line=60)
            A: http://schemas.android.com/apk/res/android:name(0x01010003)="com.instagram.android" (Raw: "com.instagram.android")
          E: intent (line=62)
              E: action (line=63)
                A: http://schemas.android.com/apk/res/android:name(0x01010003)="android.support.customtabs.action.CustomTabsService" (Raw: "android.support.customtabs.action.CustomTabsService")
          E: intent (line=65)
              E: action (line=66)
                A: http://schemas.android.com/apk/res/android:name(0x01010003)="androidx.browser.customtabs.CustomTabsService" (Raw: "androidx.browser.customtabs.CustomTabsService")
          E: intent (line=68)
              E: action (line=69)
                A: http://schemas.android.com/apk/res/android:name(0x01010003)="android.intent.action.VIEW" (Raw: "android.intent.action.VIEW")
              E: category (line=71)
                A: http://schemas.android.com/apk/res/android:name(0x01010003)="android.intent.category.BROWSABLE" (Raw: "android.intent.category.BROWSABLE")
              E: data (line=73)
                A: http://schemas.android.com/apk/res/android:scheme(0x01010027)="https" (Raw: "https")
          E: intent (line=75)
              E: action (line=76)
                A: http://schemas.android.com/apk/res/android:name(0x01010003)="android.intent.action.VIEW" (Raw: "android.intent.action.VIEW")
              E: category (line=78)
                A: http://schemas.android.com/apk/res/android:name(0x01010003)="android.intent.category.BROWSABLE" (Raw: "android.intent.category.BROWSABLE")
              E: data (line=80)
                A: http://schemas.android.com/apk/res/android:scheme(0x01010027)="http" (Raw: "http")
          E: intent (line=82)
              E: action (line=83)
                A: http://schemas.android.com/apk/res/android:name(0x01010003)="android.intent.action.VIEW" (Raw: "android.intent.action.VIEW")
              E: data (line=85)
                A: http://schemas.android.com/apk/res/android:scheme(0x01010027)="market" (Raw: "market")
          E: intent (line=87)
              E: action (line=88)
                A: http://schemas.android.com/apk/res/android:name(0x01010003)="com.attribution.REFERRAL_PROVIDER" (Raw: "com.attribution.REFERRAL_PROVIDER")
          E: intent (line=91)
              E: action (line=92)
                A: http://schemas.android.com/apk/res/android:name(0x01010003)="android.intent.action.INSERT" (Raw: "android.intent.action.INSERT")
              E: data (line=94)
                A: http://schemas.android.com/apk/res/android:mimeType(0x01010026)="vnd.android.cursor.dir/event" (Raw: "vnd.android.cursor.dir/event")
          E: intent (line=96)
              E: action (line=97)
                A: http://schemas.android.com/apk/res/android:name(0x01010003)="android.intent.action.VIEW" (Raw: "android.intent.action.VIEW")
              E: data (line=99)
                A: http://schemas.android.com/apk/res/android:scheme(0x01010027)="sms" (Raw: "sms")
          E: intent (line=101)
              E: action (line=102)
                A: http://schemas.android.com/apk/res/android:name(0x01010003)="android.intent.action.DIAL" (Raw: "android.intent.action.DIAL")
              E: data (line=104)
                A: http://schemas.android.com/apk/res/android:path(0x0101002a)="tel:" (Raw: "tel:")
          E: package (line=107)
            A: http://schemas.android.com/apk/res/android:name(0x01010003)="com.android.chrome" (Raw: "com.android.chrome")
          E: package (line=108)
            A: http://schemas.android.com/apk/res/android:name(0x01010003)="com.google.android.webview" (Raw: "com.google.android.webview")
          E: package (line=109)
            A: http://schemas.android.com/apk/res/android:name(0x01010003)="com.android.webview" (Raw: "com.android.webview")
          E: intent (line=111)
              E: action (line=112)
                A: http://schemas.android.com/apk/res/android:name(0x01010003)="com.digitalturbine.ignite.cl.IgniteRemoteService" (Raw: "com.digitalturbine.ignite.cl.IgniteRemoteService")
```

## Manifestte dikkat ceken anahtarlar
```
      E: uses-sdk (line=8)
        A: http://schemas.android.com/apk/res/android:minSdkVersion(0x0101020c)=24
        A: http://schemas.android.com/apk/res/android:targetSdkVersion(0x01010270)=36
        A: http://schemas.android.com/apk/res/android:extractNativeLibs(0x010104ea)=true
        A: http://schemas.android.com/apk/res/android:usesCleartextTraffic(0x010104ec)=true
        A: http://schemas.android.com/apk/res/android:resizeableActivity(0x010104f6)=true
            A: http://schemas.android.com/apk/res/android:resizeableActivity(0x010104f6)=false
```
