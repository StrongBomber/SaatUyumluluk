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

### Yeni bir APK nasıl eklenir?

İki yol var:

1. **Actions (önerilen):** dosya Drive'da "bağlantıya sahip olan herkes" ile
   paylaşılmış olmalı, sonra `.github/workflows/drive-apk-to-release.yml`
   iş akışı çalıştırılır (dosya kimliği ve etiket parametre olarak verilir).
   Aynı iş akışı `.github/apk-import-trigger` dosyasına yapılan push ile de
   tetiklenir.
2. **Yerel makineden:** `scripts/upload-apk-release.sh /yol/dosya.apk apk-v3.70.3`
   — SHA256 hesaplar, taslak release'e asset'i yükler.
