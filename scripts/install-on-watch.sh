#!/usr/bin/env bash
# Subway Surfers APK'sini Wear OS saatine (ornek: Galaxy Watch 8) ADB ile kurar.
#
# APK zaten hem 64-bit (arm64-v8a) hem 32-bit (armeabi-v7a) yerel kutuphane
# iceriyor; 32-bit bir saatte Android otomatik olarak armeabi-v7a'yi secer.
# Bu betik yalnizca kurulumu ve dogrulamayi yapar, APK'yi degistirmez.
#
# Kullanim:
#   ./scripts/install-on-watch.sh /yol/Subway+Surfers_3.70.3_APKPure.apk 192.168.1.50:41234
set -euo pipefail

APK="${1:?Kullanim: $0 <apk-dosyasi> [saat-ip:port]}"
TARGET="${2:-}"
PKG="com.kiloo.subwaysurf"

command -v adb >/dev/null || { echo "adb bulunamadi (Android platform-tools kur)." >&2; exit 1; }
[ -f "$APK" ] || { echo "Dosya bulunamadi: $APK" >&2; exit 1; }

if [ -n "$TARGET" ]; then
  adb connect "$TARGET" >/dev/null 2>&1 || true
fi

echo "== Bagli cihazlar =="
adb devices -l

echo
echo "== Saatin ABI listesi =="
ABILIST=$(adb shell getprop ro.product.cpu.abilist | tr -d '\r')
echo "ro.product.cpu.abilist = $ABILIST"
case "$ABILIST" in
  *arm64-v8a*) echo "-> Saat 64-bit calistirabiliyor; APK'daki arm64-v8a kullanilir." ;;
esac
case "$ABILIST" in
  *armeabi-v7a*) echo "-> Saat 32-bit calistirabiliyor; APK'daki armeabi-v7a kullanilir." ;;
esac

echo
echo "== Kurulum (32-bit kutuphaneyi zorlayarak) =="
if ! adb install -r -d --abi armeabi-v7a "$APK"; then
  echo "32-bit zorlamasi basarisiz oldu, normal kurulum deneniyor..."
  adb install -r -d "$APK"
fi

echo
echo "== Dogrulama =="
adb shell pm list packages | grep -q "$PKG" && echo "Kurulu: $PKG" || { echo "Kurulum gorunmuyor!" >&2; exit 1; }
adb shell dumpsys package "$PKG" | grep -E "primaryCpuAbi|versionName" | head -5 || true

echo
echo "Uygulamayi baslatmak icin:"
echo "  adb shell monkey -p $PKG -c android.intent.category.LAUNCHER 1"
echo
echo "Kucuk ekranda arayuz tasarsa yogunlugu dusurebilirsin (deneyerek):"
echo "  adb shell wm density 240     # geri almak icin: adb shell wm density reset"
