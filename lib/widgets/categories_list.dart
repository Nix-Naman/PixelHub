import 'package:flutter/material.dart';
import 'package:pixelhub/screens/wall_view.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;
  static const List<String> categoris = [
    "Amoled",
    "Abstract",
    "Cars",
    "Nature",
    "Tech"
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * .18,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WallView(query: categoris[index]),
                )),
                child: Container(
                  height: height * .17,
                  width: height * .17,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/${categoris[index].toLowerCase()}.jpg"),
                        fit: BoxFit.cover),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    categoris[index],
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
          separatorBuilder: (context, index) => SizedBox(width: 10),
          itemCount: categoris.length),
    );
  }
}
