import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeProvider extends ChangeNotifier {
  Uint8List? imageData;
  TextEditingController textController = TextEditingController();

  bool isLoading = false;
  bool searchChanging = false;

  void loadingUpdate(bool val) {
    isLoading = val;
    notifyListeners();
  }

  void searchUpdate(bool val) {
    searchChanging = val;
    notifyListeners();
  }

  Future<void> textToImage() async {
    String engine_id = "stable-diffusion-v1-6";
    String api_host = "https://api.stability.ai";
    String api_key = "sk-5rA7XPq5gGZcsT39renT7LH9Ulh7Town21KmWXBawL6GFXFF";

    final response = await http.post(
        Uri.parse("$api_host/v1/generation/$engine_id/text-to-image"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "image/png",
          "Authorization": "Bearer $api_key"
        },
        body: jsonEncode(
          {
            "text_prompts": [
              {"text": textController, "weight": 1}
            ],
            "cfg_scale": 7,
            "height": 1024,
            "width": 1024,
            "samples": 1,
            "steps": 30,
          },
        ));

    if (response.statusCode == 200) {
      imageData = response.bodyBytes;
      loadingUpdate(false);
      searchUpdate(true);
      notifyListeners();
    } else {
      print(response.statusCode.toString());
    }
  }
}
