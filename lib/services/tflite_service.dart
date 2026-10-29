import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class TFLiteService {
  static final TFLiteService _instance = TFLiteService._internal();
  factory TFLiteService() => _instance;
  TFLiteService._internal();

  Interpreter? _interpreter;
  List<String>? _labels;
  bool _isInitialized = false;

  final int _inputSize = 150; // User specified 150x150

  Future<void> initialize() async {
    if (_isInitialized) return;
    try {
      _interpreter = await Interpreter.fromAsset('assets/model.tflite');
      final labelData = await rootBundle.loadString('assets/labels.txt');
      _labels = labelData.split('\n').where((e) => e.trim().isNotEmpty).toList();
      _isInitialized = true;
    } catch (e) {
      print('Error initializing TFLite: $e');
      // Graceful fallback for mock
    }
  }

  Future<Map<String, dynamic>?> recognizeImage(File imageFile) async {
    if (!_isInitialized) {
      await initialize();
    }

    if (_interpreter == null || _labels == null || _labels!.isEmpty) {
      return null;
    }

    try {
      // 1. Read and decode image
      final imageBytes = await imageFile.readAsBytes();
      img.Image? decodedImage = img.decodeImage(imageBytes);
      if (decodedImage == null) return null;

      // 2. Resize image
      img.Image resizedImage = img.copyResize(decodedImage, width: _inputSize, height: _inputSize);

      // 3. Convert image to input tensor [1, 150, 150, 3] Float32
      var input = List.generate(
        1,
        (i) => List.generate(
          _inputSize,
          (y) => List.generate(
            _inputSize,
            (x) => List.generate(3, (c) => 0.0),
          ),
        ),
      );

      for (int y = 0; y < _inputSize; y++) {
        for (int x = 0; x < _inputSize; x++) {
          final pixel = resizedImage.getPixel(x, y);
          // Assuming the model expects RGB values normalized between 0 and 1
          input[0][y][x][0] = pixel.r / 255.0; // Red
          input[0][y][x][1] = pixel.g / 255.0; // Green
          input[0][y][x][2] = pixel.b / 255.0; // Blue
        }
      }

      // 4. Output tensor setup (assuming single class classification with N classes)
      var output = List.filled(1, List.filled(_labels!.length, 0.0));

      // 5. Run inference
      _interpreter!.run(input, output);

      // 6. Find max confidence
      final results = output[0];
      double maxConfidence = 0.0;
      int maxIndex = -1;

      for (int i = 0; i < results.length; i++) {
        if (results[i] > maxConfidence) {
          maxConfidence = results[i];
          maxIndex = i;
        }
      }

      if (maxIndex != -1) {
        return {
          'label': _labels![maxIndex],
          'confidence': maxConfidence,
        };
      }
      return null;
    } catch (e) {
      print('Error running inference: $e');
      return null;
    }
  }
}
