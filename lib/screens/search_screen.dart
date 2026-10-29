import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/herbal_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<HerbalModel> _allHerbs = HerbalModel.dummyData;
  List<HerbalModel> _filteredHerbs = [];
  String _selectedChip = '';

  final List<String> _filterChips = [
    'Sariawan',
    'Darah Tinggi',
    'Diare',
    'Bau Mulut',
    'Asam Lambung',
    'Nyeri Sendi',
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      setState(() {
        _filteredHerbs = [];
        _selectedChip = '';
      });
      return;
    }

    // Filter logic
    final results = _allHerbs.where((herb) {
      final symptomsMatches = herb.relatedSymptoms.any((symptom) => symptom.toLowerCase().contains(query));
      final benefitsMatches = herb.benefits.any((benefit) => benefit.toLowerCase().contains(query));
      return symptomsMatches || benefitsMatches;
    }).toList();

    setState(() {
      _filteredHerbs = results;
      
      // Update selected chip visual if typed query matches one of our chips
      final matchedChip = _filterChips.firstWhere(
        (chip) => chip.toLowerCase() == query,
        orElse: () => '',
      );
      _selectedChip = matchedChip;
    });
  }

  void _toggleChip(String chipLabel) {
    setState(() {
      if (_selectedChip == chipLabel) {
        _selectedChip = '';
        _searchController.clear();
      } else {
        _selectedChip = chipLabel;
        _searchController.text = chipLabel;
        // Move cursor to end of text
        _searchController.selection = TextSelection.fromPosition(
          TextPosition(offset: _searchController.text.length),
        );
      }
    });
  }

  // Show detailed bottom sheet for the selected herb dynamically
  void _showHerbDetailSheet(BuildContext context, HerbalModel herb) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (BuildContext context) {
        final theme = Theme.of(context);
        return DraggableScrollableSheet(
          initialChildSize: 0.8,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (_, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Drag bar
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: AppTheme.border,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      herb.imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          color: AppTheme.primaryDark,
                          child: const Icon(Icons.eco_rounded, color: Colors.white, size: 48),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Title & Latin Name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              herb.name,
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textDark,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              herb.latinName,
                              style: const TextStyle(
                                color: AppTheme.textLight,
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(height: 20),

                  // Description Section
                  const Text(
                    'Informasi Daun',
                    style: TextStyle(
                      color: AppTheme.textDark,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    herb.description,
                    style: const TextStyle(
                      color: AppTheme.textLight,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Benefits Section
                  const Text(
                    'Khasiat & Manfaat',
                    style: TextStyle(
                      color: AppTheme.textDark,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...herb.benefits.map((benefit) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.check_circle_rounded,
                              color: AppTheme.primary,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                benefit,
                                style: const TextStyle(
                                  color: AppTheme.textLight,
                                  fontSize: 14,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 24),

                  // Disclaimer
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.warningBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.warningBorder, width: 1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.warning_amber_rounded,
                          color: AppTheme.warningText,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Perhatian: Informasi herbal ini hanya panduan umum. Konsultasikan dengan dokter untuk diagnosis dan penanganan medis lebih lanjut.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppTheme.warningText,
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppTheme.primaryLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.search_rounded,
                color: AppTheme.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Pencarian Keluhan',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Search Box & Filter Chips Section
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Search TextField
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Cari keluhan ringan... (contoh: Batuk)',
                    hintStyle: const TextStyle(color: AppTheme.textLight, fontSize: 14),
                    prefixIcon: const Icon(Icons.search_rounded, color: AppTheme.textLight),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded, color: AppTheme.textLight),
                            onPressed: () => _searchController.clear(),
                          )
                        : null,
                    filled: true,
                    fillColor: const Color(0xFFF1F5F9), // Light background field
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: AppTheme.primary, width: 1.5),
                    ),
                  ),
                  style: const TextStyle(color: AppTheme.textDark, fontSize: 15),
                ),
                const SizedBox(height: 14),

                // Filter Chips Row
                SizedBox(
                  height: 38,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _filterChips.length,
                    itemBuilder: (context, index) {
                      final chipLabel = _filterChips[index];
                      final isSelected = _selectedChip == chipLabel;

                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FilterChip(
                          label: Text(chipLabel),
                          selected: isSelected,
                          onSelected: (_) => _toggleChip(chipLabel),
                          showCheckmark: false,
                          backgroundColor: Colors.white,
                          selectedColor: AppTheme.primaryLight,
                          labelStyle: TextStyle(
                            color: isSelected ? AppTheme.primary : AppTheme.textDark,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            fontSize: 13,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: isSelected ? AppTheme.primary : AppTheme.border,
                              width: 1,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // 2. Results List or Empty State
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: _searchController.text.isEmpty
                  ? _buildEmptyState(theme)
                  : _buildResultsList(theme),
            ),
          ),
        ],
      ),
    );
  }

  // Widget for Empty State (No search input)
  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      key: const ValueKey('empty_state'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_rounded,
                color: AppTheme.textLight.withOpacity(0.5),
                size: 56,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Cari Solusi Herbal',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Ketik keluhan ringan Anda di kolom pencarian di atas untuk mendapatkan rekomendasi.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textLight,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for Results List
  Widget _buildResultsList(ThemeData theme) {
    if (_filteredHerbs.isEmpty) {
      return Center(
        key: const ValueKey('no_results'),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.search_off_rounded,
                color: Colors.redAccent,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'Tidak Ada Hasil',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Coba gunakan kata kunci atau keluhan ringan yang berbeda.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppTheme.textLight, height: 1.4),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      key: const ValueKey('results_list'),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      itemCount: _filteredHerbs.length,
      itemBuilder: (context, index) {
        final herb = _filteredHerbs[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 14),
          child: InkWell(
            onTap: () => _showHerbDetailSheet(context, herb),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  // Herb Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      herb.imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 80,
                          height: 80,
                          color: AppTheme.primaryLight,
                          child: const Icon(Icons.eco_rounded, color: AppTheme.primary),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Herb Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          herb.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textDark,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          herb.latinName,
                          style: const TextStyle(
                            color: AppTheme.textLight,
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Display some related symptoms as small tags
                        Wrap(
                          spacing: 4,
                          children: herb.relatedSymptoms.take(2).map((symptom) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppTheme.background,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppTheme.border, width: 0.8),
                              ),
                              child: Text(
                                symptom,
                                style: const TextStyle(
                                  color: AppTheme.textLight,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  
                  // Go to Detail Arrow
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppTheme.textLight,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
