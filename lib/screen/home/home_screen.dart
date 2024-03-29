import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_to_image/screen/home/controller/home_provider.dart';

// ignore: must_be_immutable
class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fWatch = ref.watch(homeProvider);
    final fRead = ref.read(homeProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF212121),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "Text to Image",
          style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.openSans().fontFamily),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                fWatch.isLoading == true
                    ? Container(
                        height: 320,
                        width: 320,
                        decoration: BoxDecoration(
                          color: const Color(0xFF424242),
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(
                            fWatch.imageData!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(
                        height: 320,
                        width: 320,
                        decoration: BoxDecoration(
                          color: const Color(0xFF424242),
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_outlined,
                              color: Colors.grey[400],
                              size: 50,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "No Image is generated yet.",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontFamily:
                                      GoogleFonts.openSans().fontFamily),
                            ),
                          ],
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF424242),
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: textController,
                    maxLines: 5,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: GoogleFonts.openSans().fontFamily),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your prompt here...",
                      contentPadding: const EdgeInsets.all(20),
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w400,
                          fontFamily: GoogleFonts.openSans().fontFamily),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        fRead.textToImage(textController.text, context);
                        fRead.searchUpdate(true);
                      },
                      child: Container(
                          height: 60,
                          width: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue,
                                  Colors.blue[200]!,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )),
                          child: fWatch.isSearching == false
                              ? Text(
                                  "Generate",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily:
                                          GoogleFonts.openSans().fontFamily),
                                )
                              : const CircularProgressIndicator(
                                  color: Colors.white,
                                )),
                    ),
                    GestureDetector(
                      onTap: () {
                        fRead.loadingUpdate(false);
                        textController.clear();
                      },
                      child: Container(
                        height: 60,
                        width: 150,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                              colors: [
                                Colors.red,
                                Colors.redAccent[400]!,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )),
                        child: Text(
                          "Clear",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.openSans().fontFamily),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
