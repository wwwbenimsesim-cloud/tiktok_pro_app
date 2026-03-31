#!/bin/bash
echo "--- [1/5] RAM/Swap Alanı Hazırlanıyor... ---"
# Eğer swap yoksa 2GB swap oluşturur (AAPT2 için kritik)
dd if=/dev/zero of=/swapfile bs=1M count=2048
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile || echo "Swap zaten aktif veya yetki yok, devam ediliyor..."

echo "--- [2/5] Flutter ve Gradle Temizliği ---"
cd ~/tiktok_pro_app
flutter clean
rm -rf android/.gradle
rm -rf build

echo "--- [3/5] Root Yetki Ayarları Yapılıyor ---"
# Flutter'ın root uyarısını susturmak ve izinleri düzeltmek için
export CHOWN_HOME_DIR=true
git config --global --add safe.directory /opt/flutter

echo "--- [4/5] Gradle RAM Ayarları Yapılandırılıyor ---"
mkdir -p android
cat <<EOT > android/gradle.properties
org.gradle.jvmargs=-Xmx1536M -Dkotlin.daemon.jvm.options="-Xmx1536M"
android.useAndroidX=true
android.enableJetifier=true
android.skipAndroidXCosmeticCheck=true
EOT

echo "--- [5/5] Derleme Başlatılıyor (TikTok Pro APK) ---"
# NO_TREE_SHAKE_ICONS: Bellek kullanımını azaltır
flutter build apk --debug --no-tree-shake-icons
