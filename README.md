# SaatUyumluluk

## APK sürümü (Subway Surfers 3.70.3 / APKPure)

APK, git deposuna commit edilmez — tek dosya 100 MB push sınırını aştığı için
**GitHub Release asset** olarak yayınlanır.

- Release: [apk-v3.70.3](https://github.com/StrongBomber/SaatUyumluluk/releases/tag/apk-v3.70.3)
- Dosya: `Subway+Surfers_3.70.3_APKPure.apk`
- Boyut: 269.958.630 bayt (~257 MiB)
- SHA256: release notlarında
- Kaynak: Google Drive dosya kimliği `1D1cF_iFldnM1tYCkH1LvlmcRjCQSa82A`

İndirme:

```bash
gh release download apk-v3.70.3 --pattern "*.apk"
```

### Saatte (Galaxy Watch 8 / Wear OS) çalıştırma

APK **hem 64-bit hem 32-bit** yerel kütüphane içeriyor; dönüştürme gerekmiyor.
Denetim raporu: [`reports/apk-inspect.md`](reports/apk-inspect.md)

| Özellik | Değer |
| --- | --- |
| ABI | `arm64-v8a` (104 MiB) + `armeabi-v7a` (87 MiB), her biri 22 `.so` |
| Motor | Unity + IL2CPP (`libil2cpp.so`, `libunity.so`), Firebase, AppLovin |
| minSdk | 24 (Android 7.0) — Wear OS 6 (Android 16) uyumlu |
| targetSdk | 36 |
| GL gereksinimi | OpenGL ES 2.0 (zorunlu değil), Vulkan `not-required` |
| Dokunmatik | `touchscreen`, `multitouch` → `required=false` |
| Yönelim | `screen.portrait` zorunlu |

Wear OS 6, 32-bit (`armeabi-v7a`) kullanıcı alanıyla gelir; APK'da bu mimari
bulunduğu için Android kurulum sırasında otomatik olarak 32-bit kütüphaneleri
seçer. Yani APK'yı yeniden paketlemeye, yeniden imzalamaya veya 32-bit'e
"dönüştürmeye" gerek yok.

Kurulum:

```bash
# 1) Saatte: Ayarlar > Saat hakkinda > Yazilim bilgisi > Yazilim sürümü (7 kez)
#    Gelistirici secenekleri > ADB hata ayiklama + Kablosuz hata ayiklama ac.
# 2) Telefon/PC ayni Wi-Fi'da:
adb pair <saat-ip>:<eslesme-portu>     # saatteki 6 haneli kod
./scripts/install-on-watch.sh Subway+Surfers_3.70.3_APKPure.apk <saat-ip>:<port>
```

Beklenen sınırlar: 480×480 yuvarlak/kare ekran, dokunmatik şerit kontrolü ve
Mali-G68 GPU nedeniyle oyun açılsa bile oynanabilirlik ve akıcılık sınırlı olur;
ayrıca APK'da `android.hardware.type.watch` bildirilmediği için Google Play
üzerinden kurulamaz, yalnızca ADB ile yüklenebilir.

### Wear OS varyantları (çökme için hazırlanan düzeltmeli APK'lar)

Galaxy Watch 8 yalnızca `armeabi-v7a`/`armeabi` çalıştırır (32-bit) ve Wear OS'ta
bilinen iki sorun vardır: **arm64 içeren "universal" paketlerin çökmesi** ve
**sağa kaydırma jestinin uygulamayı kapatması** (oyunda şerit değiştirme hareketi).

Release: [wear-v3.70.3](https://github.com/StrongBomber/SaatUyumluluk/releases/tag/wear-v3.70.3)

| Varyant | İçerik | Boyut |
| --- | --- | --- |
| `wear-ready` (önerilen) | yalnızca `armeabi-v7a` + `windowSwipeToDismiss=false` + `largeHeap=true` + watch feature | 237.366.524 bayt |
| `wear-v7a` | yalnızca `armeabi-v7a` kütüphaneleri | 237.373.315 bayt |

Kurulum (tek komut):

```bash
./scripts/install-wear-apk.sh ready <saat-ip>:<port>   # veya: v7a
```

Bu varyantlar **yerel test anahtarıyla** yeniden imzalanmıştır: Play Store
güncellemesi ve Play Games imzası çalışmaz, kurulumdan önce eski paket
kaldırılır (`adb uninstall`).

### Saatte çökme (crash) teşhisi

Statik olarak elenenler (bkz. `reports/apk-inspect.md`): ABI eşliği tam (22/22
`.so`, iki mimaride de aynı), ELF sayfa hizası `0x4000` (16 KB sayfa uyumlu),
`extractNativeLibs=true` (sıkıştırılmış kütüphaneler kurulumda açılır),
`minSdk 24` / `targetSdk 36`, `resizeableActivity=true`.

Yani crash ABI/kurulum kaynaklı değil; runtime kaynaklı. Kanıt için logcat gerekir:

```bash
./scripts/watch-crash-report.sh <saat-ip>:<port>
# -> reports/watch-crash-<tarih>.txt  (dosyayı paylaş)
```

PC yoksa telefondan: **Bugjaeger** (ADB over Wi-Fi) veya **Wear Installer 2**
ile `logcat` sekmesinden aynı kayıt alınabilir.

Sık görülen nedenler ve hızlı testler:

| Belirti (logcat) | Neden | Hızlı test |
| --- | --- | --- |
| `lowmemorykiller`, `Killing ... (xxxMB)` | 2 GB RAM'de Unity + büyük sahneler | Arka plan uygulamalarını kapat, saati yeniden başlat, tekrar dene |
| `FATAL EXCEPTION` + AdMob/Firebase/Play Games | Saatte olmayan GMS modülü / reklam SDK'sı | `adb shell svc wifi disable` ile çevrimdışı başlat |
| `Fatal signal 11 (SIGSEGV)` / `SIGABRT` | GPU sürücüsü, EGL/GLES yapılandırması, il2cpp | `adb shell wm density 240` ve `wm size 480x480` ile dene |
| `dlopen failed` / `UnsatisfiedLinkError` | Yanlış ABI seçimi | `adb install -r --abi arm64-v8a ...` (abilist'te varsa) |
| `ANR in com.kiloo.subwaysurf` | Aşırı yavaş ilk yükleme | Bekle, önbellek ısınsın; tekrar dene |

### Yeni bir APK nasıl eklenir?

İki yol var:

1. **Actions (önerilen):** dosya Drive'da "bağlantıya sahip olan herkes" ile
   paylaşılmış olmalı, sonra `.github/workflows/drive-apk-to-release.yml`
   iş akışı çalıştırılır (dosya kimliği ve etiket parametre olarak verilir).
   Aynı iş akışı `.github/apk-import-trigger` dosyasına yapılan push ile de
   tetiklenir.
2. **Yerel makineden:** `scripts/upload-apk-release.sh /yol/dosya.apk apk-v3.70.3`
   — SHA256 hesaplar, taslak release'e asset'i yükler.
