import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pixelhub/model/wall_model.dart';
import 'package:pixelhub/screens/download_screen.dart';
import 'package:provider/provider.dart';

class WallView extends StatelessWidget {
  final String query;

  const WallView({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            query.toUpperCase(),
          ),
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color:
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
            ),
          ),
        ),
        body: Consumer<WallpaperModel>(builder: (context, value, child) {
          value.counter = 0;
          return FutureBuilder(
            future: value.getDataBySearch(query),
            builder: (context, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : MasonryGridView.builder(
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    gridDelegate:
                        SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: value.wallList.length,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => WallDownload(
                              image: value.wallList[index].image,
                              url: value.wallList[index].download,
                              id: value.wallList[index].id,
                              blurHash: value.wallList[index].blur_hash,
                            ),
                          ),
                        ),
                        child: Container(
                          child: AspectRatio(
                            aspectRatio:
                                double.parse(value.wallList[index].height) /
                                    double.parse(value.wallList[index].width),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: BlurHash(
                                hash: value.wallList[index].blur_hash,
                                image: value.wallList[index].image,
                                imageFit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
          );
        }),
      ),
    );
  }
}
