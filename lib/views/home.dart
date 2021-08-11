import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaperhubapp/data/data.dart';
import 'package:wallpaperhubapp/model/categories_model.dart';
import 'package:wallpaperhubapp/model/wallpaper_model.dart';
import 'package:wallpaperhubapp/views/categories.dart';
import 'package:wallpaperhubapp/views/image_view.dart';
import 'package:wallpaperhubapp/widgets/widget.dart';
import 'package:http/http.dart' as http;

import 'search.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoriesModel> categories = [];
  List<WallpaperModel> wallpapers = [];
  TextEditingController searchController = new TextEditingController();

  //异步获取
  getTrendingWallpapers() async {
    var response = await http.get(
      // Uri.parse('https://api.pexels.com/v1/curated?per_page=1'),
      'https://api.pexels.com/v1/curated?per_page=15',
      headers: {'Authorization': apiKey},
    );
    // print(response.body.toString());
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      //
      print("element:" + element.toString());

      WallpaperModel wallpaperModel=new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      //
      print("wallpaperModel:" + wallpaperModel.toString());
      wallpapers.add(wallpaperModel);
    });

    setState(() {});
  }

  @override
  void initState() {
    //初始化
    categories = getCategories();
    getTrendingWallpapers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BrandName(),
        // centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24),
                margin: EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: "search wallpapers",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //search
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Search(
                              searchQuery: searchController.text,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        child: Icon(Icons.search),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 80,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    // wallpapers[index].src.portrait;
                    return CategoriesTile(
                        imgUrl: categories[index].imgUrl,
                        title: categories[index].categoriesName);
                  },
                ),
              ),
              SizedBox(height: 16),
              WallpapersList(wallpapers: wallpapers, context: context),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  CategoriesTile({ this.imgUrl,  this.title});

  final String imgUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //跳转
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Categories(categoriesName: title.toLowerCase())));
      },
      child: Container(
        margin: EdgeInsets.only(right: 4),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imgUrl,
                height: 50,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8),
              ),
              height: 50,
              width: 100,
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
