import 'dart:io';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/herbal_model.dart';

class ResultScreen extends StatelessWidget {
  final File? imageFile;
  final String? predictedLabel;
  final double? confidence;

  const ResultScreen({
    super.key,
    this.imageFile,
    this.predictedLabel,
    this.confidence,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    final isLowConfidence = confidence != null && confidence! < 0.75;

    // Find herb info based on predicted label
    final herbalInfo = isLowConfidence 
      ? HerbalModel(
          name: "Tidak Diketahui",
          latinName: "Spesies tidak teridentifikasi",
          imageUrl: "",
          description: "Maaf, model AI belum mengenali daun ini atau tingkat akurasi terlalu rendah.",
          benefits: ["-"],
          relatedSymptoms: [],
          accuracy: "0%",
        )
      : HerbalModel.dummyData.firstWhere(
          (herb) => herb.name.toLowerCase() == (predictedLabel?.toLowerCase() ?? ''),
          orElse: () => HerbalModel(
            name: predictedLabel ?? "Tidak Diketahui",
            latinName: "Spesies tidak teridentifikasi",
            imageUrl: "",
            description: "Maaf, model AI belum mengenali daun ini atau tingkat akurasi terlalu rendah.",
            benefits: ["-"],
            relatedSymptoms: [],
            accuracy: "0%",
          ),
        );

    // Format confidence to percentage string
    final accuracyString = confidence != null 
      ? "${(confidence! * 100).toStringAsFixed(1)}%" 
      : "N/A";

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Image Background
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppTheme.primary,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.9),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_rounded, color: AppTheme.textDark),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Dynamic image rendering
                  if (imageFile != null)
                    Image.file(
                      imageFile!,
                      fit: BoxFit.cover,
                    )
                  else if (herbalInfo.imageUrl.isNotEmpty)
                    Image.network(
                      herbalInfo.imageUrl,
                      fit: BoxFit.cover,
                    )
                  else
                    Container(
                      color: AppTheme.primaryDark,
                      child: const Icon(Icons.eco, size: 80, color: Colors.white24),
                    ),
                  
                  // Gradient Overlay for better text readability (if needed)
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.transparent,
                          Colors.black.withOpacity(0.5),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Main Content Area
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -30),
              child: Container(
                decoration: const BoxDecoration(
                  color: AppTheme.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Accuracy Badge
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppTheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppTheme.primary.withOpacity(0.3)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.check_circle, color: AppTheme.primary, size: 18),
                              const SizedBox(width: 8),
                              Text(
                                'Akurasi: $accuracyString',
                                style: const TextStyle(
                                  color: AppTheme.primaryDark,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Title & Latin Name
                      Text(
                        herbalInfo.name,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: AppTheme.textDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        herbalInfo.latinName,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: AppTheme.textLight,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Action Button (Klasifikasi Ulang)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.refresh_rounded, color: AppTheme.primaryDark),
                          label: const Text(
                            'Klasifikasi Ulang',
                            style: TextStyle(
                              color: AppTheme.primaryDark,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryLight,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Information Section
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.info_outline, color: Colors.blue),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Informasi Daun',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.textDark,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  herbalInfo.description,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.textLight,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Divider(color: AppTheme.border),
                      const SizedBox(height: 24),

                      // Benefits Section
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.medical_services_outlined, color: Colors.orange),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Khasiat & Manfaat',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.textDark,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                ...herbalInfo.benefits.map((benefit) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(top: 6.0, right: 8.0),
                                        child: CircleAvatar(
                                          radius: 3,
                                          backgroundColor: AppTheme.primary,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          benefit,
                                          style: const TextStyle(
                                            color: AppTheme.textDark,
                                            height: 1.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )).toList(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      
                      // Disclaimer
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.border.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.warning_amber_rounded, size: 20, color: AppTheme.textLight),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Aplikasi ini hanya sebagai alat bantu identifikasi. Selalu konsultasikan dengan ahli herbal atau tenaga medis sebelum menggunakan tanaman untuk pengobatan.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.textLight,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
