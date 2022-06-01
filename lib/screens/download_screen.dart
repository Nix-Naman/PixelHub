import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pixelhub/model/wall_model.dart';
import 'package:provider/provider.dart';
import 'dart:io' as io;

class WallDownload extends StatelessWidget {
  final String url;
  final String image;
  final String id;
  final String blurHash;

  const WallDownload(
      {super.key,
      required this.image,
      required this.url,
      required this.id,
      required this.blurHash});

  @override
  Widget build(BuildContext context) {
    var providerInstance = Provider.of<WallpaperModel>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              child: BlurHash(
                hash: blurHash,
                image: image,
                imageFit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.3)),
                  child: Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: DownloadButton(
                  providerInstance: providerInstance, url: url, id: id),
            )
          ],
        ),
      ),
    );
  }
}

class DownloadButton extends StatefulWidget {
  final WallpaperModel providerInstance;
  final String url;
  final String id;

  const DownloadButton(
      {super.key,
      required this.providerInstance,
      required this.url,
      required this.id});

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  Dio dio = Dio();
  double progress = 0.0;
  bool isDownloading = false;
  bool downCmp = false;
  Future<void> download(String url) async {
    var dir = await getExternalStorageDirectory();
    print(dir.toString());
    print(url);
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    } else {
      isDownloading = true;
      if (await io.File(
              "/storage/emulated/0/Download/PixelHub/${widget.id}.jpg")
          .exists()) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Image already exist in Download/PixelHub.")));
      } else {
        dio.download(
          url,
          "/storage/emulated/0/Download/PixelHub/${widget.id}.jpg",
          onReceiveProgress: (count, total) {
            setState(() {
              progress = count / total;
              if (progress == 1.0) {
                downCmp = true;
              }
            });
          },
          deleteOnError: true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        download(widget.url);
      },
      child: Container(
        height: 45,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(30)),
        child: isDownloading
            ? ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    LinearProgressIndicator(
                      color: Colors.greenAccent,
                      backgroundColor: Colors.grey.withOpacity(0.3),
                      minHeight: 45,
                      value: progress,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            downCmp
                                ? Icons.download_done_rounded
                                : Icons.download_rounded,
                            size: 30,
                            color: Colors.white,
                          ),
                          Text(
                            downCmp
                                ? "Completed"
                                : "${(progress * 100).toStringAsFixed(2)} %",
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ))
            : Text(
                "Download",
                style: TextStyle(color: Colors.white),
              ),
      ),
    );
  }
}
