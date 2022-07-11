## CASHBLOCK
-keep class com.avatye.cashblock.** { *; }
-keep class com.avatye.cashblock.library.** { *; }


## IGAWORKS
-keep class com.igaworks.ssp.** { *; }
-keep class com.igaworks.ssp.R$*
-dontwarn com.igaworks.ssp.**
-keepclassmembers class com.igaworks.ssp.R$*{
    public static <fields>;
}


## UnityAds
-keep class com.unity3d.ads.** { *; }
-keep class com.unity3d.services.** { *; }


## Vungle
-dontwarn com.vungle.warren.downloader.DownloadRequestMediator$Status
-dontwarn com.vungle.warren.error.VungleError$ErrorCode
-dontwarn com.google.android.gms.common.GoogleApiAvailabilityLight
-dontwarn com.google.android.gms.ads.identifier.AdvertisingIdClient
-dontwarn com.google.android.gms.ads.identifier.AdvertisingIdClient$Info
-keep class com.moat.** { *; }
-dontwarn com.moat.**
-keepattributes *Annotation*
-keepattributes Signature
# Prevent R8 from leaving Data object members always null
-keepclassmembers,allowobfuscation class * {
  @com.google.gson.annotations.SerializedName <fields>;
}
-dontwarn javax.annotation.**
-keepnames class okhttp3.internal.publicsuffix.PublicSuffixDatabase
-dontwarn org.codehaus.mojo.animal_sniffer.*
-dontwarn okhttp3.internal.platform.ConscryptPlatform


## Pangle
-keep class com.bytedance.sdk.** { *; }
-keep class com.pgl.sys.ces.* { *; }


## Fan
-keep class com.facebook.ads.** { *; }


## Mobon
-dontwarn com.httpmodule.**
-dontwarn com.imgmodule.**
-keep class com.httpmodule.** { *; }
-keep class com.imgmodule.** { *; }
-keep public class com.mobon.**{
    public *;
}


# Dontwarn
-dontwarn com.adcolony.**
-dontwarn com.bytedance.**
-dontwarn com.mopub.**
-dontwarn com.mintegral.**
-dontwarn com.unity3d.**
-dontwarn com.adobe.**
-dontwarn com.fyber.**
-dontwarn org.chromium.**
-dontwarn com.fsn.cauly.**
-dontwarn com.tapjoy.**