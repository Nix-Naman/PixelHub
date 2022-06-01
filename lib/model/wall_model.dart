import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:pixelhub/model/wallpaper.dart';

class WallpaperModel extends ChangeNotifier {
  static const String _key = "0bwvCIUq5IL6Yr2hzXw4fCMm8xhyZd9NQDKwhdzFDX8";
  Dio dio = Dio();
  final List<WallpaperData> wallList = [];
  final List<WallpaperData> trending = [];
  int counter = 0;
  Future<void> getTrending() async {
    try {
      var response = await dio.get("https://api.unsplash.com/photos",
          queryParameters: {"client_id": _key, "per_page": 30});
      List data = response.data;

      data.forEach((element) {
        WallpaperData wallpaper = WallpaperData.fromJson(element);
        trending.add(wallpaper);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getDataBySearch(String query) async {
    if (counter == 0) {
      wallList.clear();
    }
    try {
      var response = await dio
          .get("https://api.unsplash.com/search/photos", queryParameters: {
        "client_id": _key,
        "query": query,
        "per_page": "30",
        "page": counter + 1,
      });
      List data = response.data['results'];
      data.forEach((element) {
        WallpaperData wallpaper = WallpaperData.fromJson(element);
        wallList.add(wallpaper);
      });
      while (counter != 30) {
        counter++;
        await getDataBySearch(query);
      }
    } catch (e) {
      print(e);
    }
  }
}
