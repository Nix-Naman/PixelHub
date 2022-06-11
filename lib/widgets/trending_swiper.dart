import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:pixelhub/model/wall_model.dart';
import 'package:provider/provider.dart';

import '../screens/download_screen.dart';

class TrendingSwiper extends StatefulWidget {
  const TrendingSwiper({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  State<TrendingSwiper> createState() => _TrendingSwiperState();
}

class _TrendingSwiperState extends State<TrendingSwiper> {
  @override
  void initState() {
    Provider.of<WallpaperModel>(context, listen: false).getTrending();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var providerInstance = Provider.of<WallpaperModel>(context);
    return SizedBox(
      height: widget.height * 0.55,
      child: providerInstance.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Swiper(
              scale: 0.93,
              viewportFraction: 0.8,
              itemCount: providerInstance.trending.length,
              autoplay: true,
              autoplayDelay: 5000,
              itemBuilder: (context, index) => Container(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => WallDownload(
                        url: providerInstance.trending[index].download,
                        id: providerInstance.trending[index].id,
                        blurHash: providerInstance.trending[index].blur_hash,
                        image: providerInstance.trending[index].image,
                      ),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BlurHash(
                      hash: providerInstance.trending[index].blur_hash,
                      image: providerInstance.trending[index].image,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
