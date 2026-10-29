class HerbalModel {
  final String name;
  final String latinName;
  final String imageUrl;
  final String description;
  final List<String> benefits;
  final List<String> relatedSymptoms;
  final String accuracy; // for mock classification results

  const HerbalModel({
    required this.name,
    required this.latinName,
    required this.imageUrl,
    required this.description,
    required this.benefits,
    required this.relatedSymptoms,
    required this.accuracy,
  });

  // Database of all 11 labels
  static List<HerbalModel> get dummyData {
    return [
      const HerbalModel(
        name: "Daun Belimbing Wuluh",
        latinName: "Averrhoa bilimbi",
        imageUrl: "assets/images/daun belimbing wuluh.jpg",
        description:
            "Tanaman tropis bersusunan majemuk menyirip yang kaya akan senyawa metabolit sekunder.",
        benefits: [
          "Mengobati sariawan",
          "Penurun darah tinggi",
          "Antiinfeksi",
        ],
        relatedSymptoms: ["sariawan", "darah tinggi", "infeksi"],
        accuracy: "98%",
      ),
      const HerbalModel(
        name: "Daun Jambu Biji",
        latinName: "Psidium guajava",
        imageUrl: "assets/images/daun jambu biji.jpg",
        description:
            "Daun bertekstur kasar dengan susunan tulang menyirip yang menyimpan konsentrasi tinggi polifenol.",
        benefits: [
          "Mengatasi diare",
          "Meningkatkan trombosit",
        ],
        relatedSymptoms: ["diare", "trombosit turun", "demam berdarah"],
        accuracy: "97%",
      ),
      const HerbalModel(
        name: "Daun Jeruk Nipis",
        latinName: "Citrus aurantiifolia",
        imageUrl: "assets/images/daun jeruk nipis.webp",
        description:
            "Kelompok daun bersirip yang memiliki aroma minyak atsiri khas dan alkaloid.",
        benefits: [
          "Obat kumur radang gusi",
          "Peningkat imunitas",
        ],
        relatedSymptoms: ["radang gusi", "sakit gigi", "imunitas"],
        accuracy: "95%",
      ),
      const HerbalModel(
        name: "Daun Kemangi",
        latinName: "Ocimum basilicum",
        imageUrl: "assets/images/daun kemangi.jpeg",
        description:
            "Tanaman perdu dengan aroma kuat berkat tingginya konsentrasi minyak esensial.",
        benefits: [
          "Menghilangkan bau mulut",
          "Menjaga kesehatan jantung",
        ],
        relatedSymptoms: ["bau mulut", "jantung"],
        accuracy: "96%",
      ),
      const HerbalModel(
        name: "Daun Kunyit",
        latinName: "Curcuma longa",
        imageUrl: "assets/images/daun kunyit.webp",
        description:
            "Daun yang turut mensintesis senyawa kurkuminoid, monoterpen, dan minyak atsiri.",
        benefits: [
          "Menetralkan asam lambung",
          "Mengatasi maag",
        ],
        relatedSymptoms: ["asam lambung", "maag", "nyeri perut"],
        accuracy: "97%",
      ),
      const HerbalModel(
        name: "Daun Nangka",
        latinName: "Artocarpus heterophyllus",
        imageUrl: "assets/images/daun nangka.jpeg",
        description:
            "Daun berbentuk oval, bertekstur kaku, dan memuat senyawa bioaktif dominan.",
        benefits: [
          "Penurun gula darah (diabetes)",
          "Pereda radang",
        ],
        relatedSymptoms: ["diabetes", "gula darah tinggi", "radang"],
        accuracy: "93%",
      ),
      const HerbalModel(
        name: "Daun Pandan",
        latinName: "Pandanus amaryllifolius",
        imageUrl: "assets/images/daun pandan.jpg",
        description:
            "Tanaman monokotil bertulang daun sejajar dengan aroma khas alkaloid.",
        benefits: [
          "Pereda nyeri sendi",
          "Relaksan saraf alami",
        ],
        relatedSymptoms: ["nyeri sendi", "stres", "otot tegang"],
        accuracy: "98%",
      ),
      const HerbalModel(
        name: "Daun Pepaya",
        latinName: "Carica papaya",
        imageUrl: "assets/images/daun pepaya.jpg",
        description:
            "Profil daun menjari dengan cita rasa pahit dari senyawa alkaloid karpain.",
        benefits: [
          "Meningkatkan trombosit",
          "Melancarkan pencernaan",
        ],
        relatedSymptoms: ["pencernaan", "sembelit", "trombosit turun"],
        accuracy: "99%",
      ),
      const HerbalModel(
        name: "Daun Seledri",
        latinName: "Apium graveolens",
        imageUrl: "assets/images/daun seledri.webp",
        description:
            "Morfologi daun menyirip ganjil berpigmen hijau terang yang memuat rasio kalium ideal.",
        benefits: [
          "Penurun tekanan darah tinggi",
          "Pemeliharaan ginjal",
        ],
        relatedSymptoms: ["darah tinggi", "hipertensi", "masalah ginjal"],
        accuracy: "97%",
      ),
      const HerbalModel(
        name: "Daun Sirih",
        latinName: "Piper betle",
        imageUrl: "assets/images/daun sirih.jpg",
        description:
            "Daun dari famili Piperaceae yang kaya nutrisi dan minyak atsiri.",
        benefits: [
          "Meredakan nyeri",
          "Penyembuh luka",
          "Antimikroba",
        ],
        relatedSymptoms: ["nyeri", "luka", "bau mulut"],
        accuracy: "99%",
      ),
      const HerbalModel(
        name: "Lidah Buaya",
        latinName: "Aloe vera",
        imageUrl: "assets/images/lidah buaya.webp",
        description:
            "Morfologi sukulen berdaging tebal berlapis kutikula dengan tepi berduri.",
        benefits: [
          "Menyembuhkan luka bakar",
          "Melembapkan kulit",
        ],
        relatedSymptoms: ["luka bakar", "kulit kering", "iritasi"],
        accuracy: "99%",
      ),
    ];
  }
}
