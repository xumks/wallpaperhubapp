import 'package:flutter/material.dart';
import 'package:wallpaperhubapp/model/wallpaper_model.dart';
import 'package:wallpaperhubapp/views/image_view.dart';

Widget BrandName() {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      children: [
        TextSpan(
          text: "Wallpaper ",
          style: TextStyle(color: Colors.black87),
        ),
        TextSpan(
          text: "Hub",
          style: TextStyle(color: Colors.blue),
        ),
      ],
    ),
  );
}

Widget WallpapersList({List<WallpaperModel> wallpapers, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper) {
        print("wallpaper.src.portrait" + wallpaper.src.portrait.toString());
        return GridTile(
            child: GestureDetector(
          onTap: () {
            //跳转
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ImageView(imgUrl: wallpaper.src.portrait)));
          },
          child: Hero(
            tag: wallpaper.src.portrait,
            child: Container(
              // decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  wallpaper.src.portrait,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ));
      }).toList(),
    ),
  );
}
