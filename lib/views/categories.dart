import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaperhubapp/data/data.dart';
import 'package:wallpaperhubapp/model/wallpaper_model.dart';
import 'package:wallpaperhubapp/widgets/widget.dart';
import 'package:http/http.dart' as http;

class Categories extends StatefulWidget {
  final String categoriesName;

  const Categories({Key key,  this.categoriesName}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<WallpaperModel> wallpapers = [];

  //异步获取
  getSearchWallpapers(String query) async {
    var response = await http.get(
      // Uri.parse('https://api.pexels.com/v1/curated?per_page=1'),
      'https://api.pexels.com/v1/search?query=$query&per_page=15&page=1',
      headers: {'Authorization': apiKey},
    );
    // print(response.body.toString());
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      //
      print("element:" + element.toString());
      WallpaperModel wallpaperModel
      = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {});
  }

  @override
  void initState() {
    getSearchWallpapers(widget.categoriesName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BrandName(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            WallpapersList(wallpapers: wallpapers, context: context),
          ],
        ),
      ),
    );
  }
}
