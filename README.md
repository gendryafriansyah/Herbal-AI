<div align="center">

# 🌿 HerbalAI - Smart Herbal Leaf Identifier

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![TensorFlow Lite](https://img.shields.io/badge/TensorFlow_Lite-FF6F00?style=for-the-badge&logo=tensorflow&logoColor=white)](https://www.tensorflow.org/lite)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-green?style=for-the-badge)](https://flutter.dev)
[![License](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)](LICENSE)

<p align="center">
  <b>Aplikasi Mobile Berbasis Artificial Intelligence (Deep Learning) untuk Klasifikasi dan Identifikasi Daun Tanaman Obat Herbal Asli Indonesia secara On-Device & Real-Time.</b>
</p>

[Fitur Utama](#-fitur-utama) •
[Daftar Tanaman](#-daftar-tanaman-herbal) •
[Teknologi](#-teknologi--arsitektur) •
[Alur Kerja AI](#-alur-kerja-model-ai) •
[Instalasi](#-panduan-instalasi) •
[Struktur Direktori](#-struktur-proyek)

---

</div>

## 📌 Tentang Project

**HerbalAI** dikembangkan sebagai solusi digital cerdas dalam melestarikan serta mempermudah masyarakat mengenali keanekaragaman tanaman obat keluarga (TOGA). Dengan memanfaatkan teknologi **Computer Vision** dan **Deep Learning Convolutional Neural Network (CNN)** yang dioptimasi ke format **TensorFlow Lite**, aplikasi ini mampu mengklasifikasikan daun herbal secara instan langsung dari ponsel pintar (*edge computing/offline*) tanpa memerlukan koneksi internet.

Selain identifikasi visual, HerbalAI menyediakan ensiklopedia digital yang memuat informasi nama botani (Latin), kandungan metabolit/senyawa aktif, deskripsi morfologi, dan khasiat kesehatan, serta fitur penelusuran tanaman berdasarkan keluhan atau gejala penyakit.

---

## ✨ Fitur Utama

- 📸 **Deteksi & Klasifikasi Instan**: Tangkap foto daun secara langsung menggunakan kamera ponsel atau unggah dari galeri foto.
- ⚡ **On-Device Machine Learning**: Inferensi model dijalankan langsung di perangkat secara lokal menggunakan TensorFlow Lite, menjamin kecepatan respon dan privasi data pengguna tanpa kuota internet.
- 📊 **Confidence Score Meter**: Menampilkan persentase tingkat keyakinan (akurasi) prediksi secara transparan.
- 📖 **Ensiklopedia Tanaman Herbal**: Informasi detail mengenai taksonomi nama Latin, ciri morfologis, serta khasiat farmakologis tradisional.
- 🔍 **Pencarian Berdasarkan Gejala (Symptom-based Search)**: Fitur cerdas untuk mencari rekomendasi daun herbal berdasarkan keluhan kesehatan (contoh: *sariawan, asam lambung, diare, darah tinggi, demam berdarah*).
- 🎨 **Modern & Intuitive UI/UX**: Tampilan elegan, responsif, dan mudah digunakan oleh berbagai kalangan usia.

---

## 🍃 Daftar Tanaman Herbal (11 Kelas)

Model klasifikasi saat ini telah dilatih untuk mengenali 11 jenis daun tanaman obat herbal:

| No | Nama Lokal | Nama Botani (Latin) | Khasiat Utama |
|:--:|:-----------|:--------------------|:--------------|
| 1 | **Daun Belimbing Wuluh** | *Averrhoa bilimbi* | Mengobati sariawan, penurun tekanan darah tinggi, antiinfeksi |
| 2 | **Daun Jambu Biji** | *Psidium guajava* | Mengatasi diare, menaikkan trombosit pada DBD, antibakteri |
| 3 | **Daun Jeruk Nipis** | *Citrus aurantiifolia* | Meredakan batuk, radang gusi, meningkatkan sistem imun |
| 4 | **Daun Kemangi** | *Ocimum basilicum* | Menghilangkan bau mulut, menjaga kesehatan jantung |
| 5 | **Daun Kunyit** | *Curcuma longa* | Menetralkan asam lambung, mengatasi maag, antiinflamasi |
| 6 | **Daun Nangka** | *Artocarpus heterophyllus* | Membantu mengontrol gula darah (diabetes), meredakan radang |
| 7 | **Daun Pandan** | *Pandanus amaryllifolius* | Pereda nyeri sendi, relaksan saraf alami, menurunkan asam urat |
| 8 | **Daun Pepaya** | *Carica papaya* | Menaikkan trombosit darah, melancarkan sistem pencernaan |
| 9 | **Daun Seledri** | *Apium graveolens* | Menurunkan tekanan darah (hipertensi), detoksifikasi ginjal |
| 10 | **Daun Sirih** | *Piper betle* | Antiseptik alami, penyembuh luka, kesehatan organ kewanitaan |
| 11 | **Lidah Buaya** | *Aloe vera* | Meredakan luka bakar, melembapkan kulit, menjaga kesehatan rambut |

---

## 🛠 Teknologi & Arsitektur

- **Framework**: [Flutter](https://flutter.dev) (v3.0.0+)
- **Bahasa Pemrograman**: [Dart](https://dart.dev)
- **Machine Learning Engine**: [TensorFlow Lite Flutter](https://pub.dev/packages/tflite_flutter) (`tflite_flutter: ^0.12.1`)
- **Image Processing**: [Image](https://pub.dev/packages/image) (`image: ^4.9.1`)
- **Hardware Integration**: [Camera](https://pub.dev/packages/camera) & [Image Picker](https://pub.dev/packages/image_picker)

---

## 🧠 Alur Kerja Model AI

```
[ Input Citra Daun ]
        ↓
[ Preprocessing (Resize ke 150x150, Normalisasi RGB [0.0 - 1.0]) ]
        ↓
[ TensorFlow Lite Interpreter (assets/model.tflite) ]
        ↓
[ Softmax Layer Output (11 Kelas Probabilitas) ]
        ↓
[ Ekstraksi Label Tertinggi & Confidence Score ]
        ↓
[ Tampilan Hasil & Rekomendasi Medis Herbal ]
```

- **Ukuran Input Tensor**: `[1, 150, 150, 3]` (Format Float32)
- **Ukuran Output Tensor**: `[1, 11]` (Probabilitas Softmax per kelas)

---

## 📁 Struktur Proyek

```plaintext
leafherb/
├── android/                   # Konfigurasi platform Android & Gradle
├── assets/
│   ├── images/                # Dataset foto referensi tanaman
│   ├── labels.txt             # Daftar 11 label kelas klasifikasi
│   └── model.tflite           # Model Deep Learning TFLite
├── ios/                       # Konfigurasi platform iOS
├── lib/
│   ├── main.dart              # Entry point aplikasi
│   ├── models/
│   │   └── herbal_model.dart  # Data model & knowledge base tanaman
│   ├── screens/
│   │   ├── classification_screen.dart # Kamera & inferensi AI
│   │   ├── home_screen.dart           # Dashboard beranda
│   │   ├── main_scaffold.dart         # Bottom navigation bar
│   │   ├── result_screen.dart         # Tampilan hasil diagnosis
│   │   └── search_screen.dart         # Pencarian gejala penyakit
│   ├── services/
│   │   └── tflite_service.dart        # Engine inferensi TFLite
│   └── theme/
│       └── app_theme.dart             # Styling & tema UI
└── pubspec.yaml               # Dependensi & aset konfigurasi
```

---

## 🚀 Panduan Instalasi

### 1. Prasyarat
Pastikan environment berikut telah terpasang di komputer Anda:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (versi 3.0.0 atau lebih tinggi)
- [Android Studio](https://developer.android.com/studio) dengan Android SDK & Command-line Tools
- Perangkat Android fisik atau Emulator Android (dengan kamera aktif)

### 2. Kloning Repository
```bash
git clone https://github.com/gendryafriansyah/Herbal-AI.git
cd Herbal-AI
```

### 3. Unduh Dependensi
```bash
flutter pub get
```

### 4. Jalankan Aplikasi
Hubungkan perangkat Android Anda via USB Debugging, lalu jalankan:
```bash
flutter run
```

---

## 👨‍💻 Pengembang

**Gendry Afriansyah**  
- GitHub: [@gendryafriansyah](https://github.com/gendryafriansyah)
- Email: gndryafrsyh@gmail.com

---

## 📝 Lisensi

Project ini dilisensikan di bawah lisensi [MIT License](LICENSE). Silakan gunakan dan kembangkan untuk keperluan penelitian akademis, tugas akhir, atau edukasi masyarakat.
