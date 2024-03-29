import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_to_image/screen/home/controller/home_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFF212121),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Text to Image",
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.openSans().fontFamily),
                ),
                const SizedBox(
                  height: 30,
                ),
                Consumer<HomeProvider>(
                  builder: (context, provider, child) {
                    return provider.searchChanging == true
                        ? Container(
                            height: 320,
                            width: 320,
                            decoration: BoxDecoration(
                              color: const Color(0xFF424242),
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Consumer<HomeProvider>(
                              builder: (context, provider, child) {
                                return Image.memory(provider.imageData!);
                              },
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
                          );
                  },
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
                    controller: homeProvider.textController,
                    maxLines: 5,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: GoogleFonts.openSans().fontFamily),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your prompt here...",
                      contentPadding: EdgeInsets.all(20),
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
                        homeProvider.textToImage();
                        homeProvider.loadingUpdate(true);
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
                          child: Consumer<HomeProvider>(
                            builder: (context, provider, child) {
                              return provider.isLoading == false
                                  ? Text(
                                      "Generate",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: GoogleFonts.openSans()
                                              .fontFamily),
                                    )
                                  : const CircularProgressIndicator(
                                      color: Colors.white,
                                    );
                            },
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        homeProvider.searchUpdate(false);
                        homeProvider.textController.clear();
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
