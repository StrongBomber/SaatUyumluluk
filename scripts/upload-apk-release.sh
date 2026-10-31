#!/usr/bin/env bash
# APK dosyasini GitHub Release asset'i olarak yukler.
#
# Neden release?
#   GitHub normal git dosyalari icin 100 MB (push) siniri koyar. APK gibi buyuk
#   ikili dosyalar depoya commit edilmemeli; release asset siniri 2 GB'dir.
#
# Kullanim:
#   ./scripts/upload-apk-release.sh /yol/Subway+Surfers_3.70.3_APKPure.apk v3.70.3
#
set -euo pipefail

APK_PATH="${1:?Kullanim: $0 <apk-dosyasi> [etiket]}"
TAG="${2:-apk-v3.70.3}"

[ -f "$APK_PATH" ] || { echo "Dosya bulunamadi: $APK_PATH" >&2; exit 1; }

SIZE=$(stat -c %s "$APK_PATH" 2>/dev/null || stat -f %z "$APK_PATH")
SHA=$(sha256sum "$APK_PATH" | cut -d' ' -f1)
NAME=$(basename "$APK_PATH")

echo "Dosya : $NAME"
echo "Boyut : $SIZE bayt"
echo "SHA256: $SHA"

# 2 GB release asset siniri
if [ "$SIZE" -gt 2147483648 ]; then
  echo "HATA: Dosya 2 GB release asset sinirindan buyuk." >&2
  exit 1
fi

# Release yoksa olustur (draft olarak, kontrol edip yayinlayabilmen icin)
if ! gh release view "$TAG" >/dev/null 2>&1; then
  gh release create "$TAG" \
    --draft \
    --title "APK $TAG" \
    --notes "APK ikili dosyasi.

- Dosya: \`$NAME\`
- Boyut: $SIZE bayt"
fi

gh release upload "$TAG" "$APK_PATH" --clobber

gh release edit "$TAG" --notes "APK ikili dosyasi.

- Dosya: \`$NAME\`
- Boyut: $SIZE bayt
- SHA256: \`$SHA\`

Indirme: \`gh release download $TAG\` veya release sayfasindaki asset baglantisi."

echo
echo "Tamam. Asset yuklendi: $TAG / $NAME"
echo "Yayinlamak icin: gh release edit $TAG --draft=false"
