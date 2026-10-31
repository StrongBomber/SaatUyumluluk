#!/usr/bin/env bash
# Wear OS saatinde (or. Galaxy Watch 8) Subway Surfers acilirken yasanan
# cokmeyi teshis etmek icin logcat + cihaz/paket bilgisi toplar ve ozet gecerk.
#
# Kullanim:
#   ./scripts/watch-crash-report.sh [saat-ip:port]
#
# Cikti: reports/watch-crash-<tarih>.txt  (bu dosyayi paylas)
set -uo pipefail

TARGET="${1:-}"
PKG="com.kiloo.subwaysurf"
OUT_DIR="reports"
STAMP=$(date +%Y%m%d-%H%M%S)
OUT="$OUT_DIR/watch-crash-$STAMP.txt"

command -v adb >/dev/null || { echo "adb bulunamadi (Android platform-tools kur)." >&2; exit 1; }
mkdir -p "$OUT_DIR"

if [ -n "$TARGET" ]; then
  adb connect "$TARGET" >/dev/null 2>&1 || true
fi

if ! adb get-state >/dev/null 2>&1; then
  echo "HATA: bagli cihaz yok. Once 'adb pair <ip>:<port>' ve 'adb connect <ip>:<port>' calistir." >&2
  adb devices -l
  exit 1
fi

echo "Rapor toplaniyor -> $OUT"

{
  echo "=== Wear OS crash raporu ($STAMP) ==="
  echo
  echo "--- cihaz ---"
  for p in ro.product.model ro.product.manufacturer ro.build.version.release \
           ro.build.version.sdk ro.build.characteristics ro.product.cpu.abi \
           ro.product.cpu.abilist ro.product.cpu.abilist32 ro.product.cpu.abilist64 \
           ro.product.cpu.abilist32 ro.build.fingerprint; do
    printf '%-34s = %s\n' "$p" "$(adb shell getprop "$p" 2>/dev/null | tr -d '\r')"
  done
  echo
  echo "--- sayfa boyutu (16 KB sayfa onemli) ---"
  adb shell getconf PAGESIZE 2>/dev/null | tr -d '\r'
  echo
  echo "--- bellek ---"
  adb shell cat /proc/meminfo 2>/dev/null | head -5 | tr -d '\r'
  echo
  echo "--- paket ---"
  adb shell dumpsys package "$PKG" 2>/dev/null | grep -E "versionCode|versionName|primaryCpuAbi|secondaryCpuAbi|codePath|splits|flags=|minSdk|targetSdk" | head -20 | tr -d '\r'
  echo
  echo "--- kurulu APK yolu ---"
  adb shell pm path "$PKG" 2>/dev/null | tr -d '\r'
} > "$OUT" 2>&1

echo "Logcat temizleniyor ve uygulama baslatiliyor..."
adb logcat -c -b all >/dev/null 2>&1 || true

# Arka planda log topla
adb logcat -b all -v threadtime > "$OUT_DIR/.logcat-$STAMP.raw" 2>&1 &
LOGPID=$!

ACTIVITY=$(adb shell cmd package resolve-activity --brief "$PKG" 2>/dev/null | tr -d '\r' | tail -1)
echo "Aktivite: ${ACTIVITY:-bilinmiyor}"
if [ -n "${ACTIVITY:-}" ] && [ "$ACTIVITY" != "No activity found" ]; then
  adb shell am start -W -n "$ACTIVITY" >/dev/null 2>&1 || \
    adb shell monkey -p "$PKG" -c android.intent.category.LAUNCHER 1 >/dev/null 2>&1
else
  adb shell monkey -p "$PKG" -c android.intent.category.LAUNCHER 1 >/dev/null 2>&1
fi

echo "20 saniye boyunca log toplaniyor..."
sleep 20
kill "$LOGPID" 2>/dev/null
wait "$LOGPID" 2>/dev/null

RAW="$OUT_DIR/.logcat-$STAMP.raw"
{
  echo
  echo "=== OZET: cokme imzalari ==="
  grep -nE "FATAL EXCEPTION|AndroidRuntime.*(Error|Exception)|UnsatisfiedLinkError|dlopen failed|signal (11|6|4|7)|Abort message|Fatal signal|lowmemorykiller|Force finishing|Process .* has died|ANR in|EGL_BAD|GLES|Vulkan|avc: denied|crash_dump|tombstone" "$RAW" \
    | head -80
  echo
  echo "=== Uygulama surecine ait tum satirlar (ilk 200) ==="
  grep -E "$PKG|kiloo|il2cpp|unity|UnityMain|libunity|libil2cpp" "$RAW" | head -200
  echo
  echo "=== Son 200 logcat satiri ==="
  tail -200 "$RAW"
} >> "$OUT" 2>&1

echo
echo "=== HIZLI TESHIS ==="
if grep -q "dlopen failed\|UnsatisfiedLinkError" "$RAW"; then
  echo "- NATIVE KUTUPHANE HATASI: ABI/ELF uyumsuzlugu. Kurulumda '--abi' secimini ve sayfa boyutunu kontrol et."
fi
if grep -qE "Fatal signal (11|6)|SIGSEGV|SIGABRT" "$RAW"; then
  echo "- YEREL COKME (SIGSEGV/SIGABRT): genelde libil2cpp veya GPU surucu kaynakli."
fi
if grep -q "lowmemorykiller\|Killing.*$PKG" "$RAW"; then
  echo "- BELLEK YETERSIZ: isletim sistemi uygulamayi sonlandirdi (2 GB RAM siniri)."
fi
if grep -q "FATAL EXCEPTION" "$RAW"; then
  grep -A3 "FATAL EXCEPTION" "$RAW" | head -8
fi
if grep -qi "avc: denied" "$RAW"; then
  echo "- SELinux reddi var (izin/uyumluluk sorunu olabilir)."
fi
if ! grep -qE "FATAL EXCEPTION|Fatal signal|dlopen failed|lowmemorykiller" "$RAW"; then
  echo "- Belirgin cokme imzasi bulunamadi; tam log dosyasini incele."
fi

rm -f "$RAW"
echo
echo "Rapor hazir: $OUT"
