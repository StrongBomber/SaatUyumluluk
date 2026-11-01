#!/usr/bin/env bash
# Wear OS varyantlarini (wear-v3.70.3 release) indirip saate kurar.
#
# Kullanim:
#   ./scripts/install-wear-apk.sh ready   # windowSwipeToDismiss duzeltmeli (onerilen)
#   ./scripts/install-wear-apk.sh v7a     # sadece 32-bit kutuphaneler
#   ./scripts/install-wear-apk.sh ready 192.168.1.50:41234
#
# Not: varyantlar yerel bir test anahtariyla imzalandigi icin once mevcut
# kurulum kaldirilir (imza uyusmazligi). Ilk denemede oyun ici ilerleme
# kaybolabilir; ilerleme Play Games'e bagliysa geri gelir.
set -euo pipefail

KIND="${1:?Kullanim: $0 <ready|v7a> [saat-ip:port]}"
TARGET="${2:-}"
TAG="wear-v3.70.3"
PKG="com.kiloo.subwaysurf"
REPO="StrongBomber/SaatUyumluluk"

case "$KIND" in
  ready) PATTERN="*wear-ready.apk" ;;
  v7a)   PATTERN="*wear-v7a.apk" ;;
  *) echo "Gecersiz secim: $KIND (ready|v7a)" >&2; exit 1 ;;
esac

command -v adb >/dev/null || { echo "adb bulunamadi." >&2; exit 1; }
command -v gh  >/dev/null || { echo "gh bulunamadi." >&2; exit 1; }

[ -n "$TARGET" ] && { adb connect "$TARGET" >/dev/null 2>&1 || true; }
adb get-state >/dev/null 2>&1 || { echo "Saat bagli degil (adb pair/connect gerekli)." >&2; adb devices -l; exit 1; }

mkdir -p dist
gh release download "$TAG" --repo "$REPO" --pattern "$PATTERN" --dir dist --clobber
APK=$(ls dist/$PATTERN | head -1)
echo "APK: $APK ($(stat -c %s "$APK") bayt)"

echo "== Saatin ABI listesi =="
adb shell getprop ro.product.cpu.abilist | tr -d '\r'

echo "== Eski kurulum kaldiriliyor (imza degisikligi) =="
adb uninstall "$PKG" >/dev/null 2>&1 || true

echo "== Kurulum =="
adb install -r --abi armeabi-v7a "$APK"

echo "== Dogrulama =="
adb shell dumpsys package "$PKG" | grep -E "primaryCpuAbi|versionName" | head -4 | tr -d '\r'

echo
echo "Baslatmak icin: adb shell monkey -p $PKG -c android.intent.category.LAUNCHER 1"
echo "Kucuk ekranda sigmazsa: adb shell wm density 240   (geri al: wm density reset)"
