class WallpaperData {
  final String id;
  final String height;
  final String width;
  final String blur_hash;
  final String download;
  final String image;

  WallpaperData({
    required this.id,
    required this.height,
    required this.width,
    required this.blur_hash,
    required this.download,
    required this.image,
  });

  factory WallpaperData.fromJson(Map<String, dynamic> json) {
    return WallpaperData(
      id: json["id"].toString(),
      height: json["height"].toString(),
      width: json["width"].toString(),
      blur_hash: json["blur_hash"].toString(),
      image: json['urls']['regular'].toString(),
      download: json['links']['download'].toString(),
    );
  }
}
