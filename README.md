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

### Yeni bir APK nasıl eklenir?

İki yol var:

1. **Actions (önerilen):** dosya Drive'da "bağlantıya sahip olan herkes" ile
   paylaşılmış olmalı, sonra `.github/workflows/drive-apk-to-release.yml`
   iş akışı çalıştırılır (dosya kimliği ve etiket parametre olarak verilir).
   Aynı iş akışı `.github/apk-import-trigger` dosyasına yapılan push ile de
   tetiklenir.
2. **Yerel makineden:** `scripts/upload-apk-release.sh /yol/dosya.apk apk-v3.70.3`
   — SHA256 hesaplar, taslak release'e asset'i yükler.
