import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaperhubapp/data/data.dart';
import 'package:wallpaperhubapp/model/wallpaper_model.dart';
import 'package:wallpaperhubapp/widgets/widget.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  final String searchQuery;

  const Search({Key key, this.searchQuery}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<WallpaperModel> wallpapers = [];
  TextEditingController searchController = new TextEditingController();

  // widget.searchQuery.toString()
  //异步获取
  getSearchWallpapers(String query) async {
    var response = await http.get(
      // Uri.parse('https://api.pexels.com/v1/curated?per_page=1'),
      'https://api.pexels.com/v1/search?query=${query}&per_page=15&page=1',
      headers: {'Authorization': apiKey},
    );
    // print(response.body.toString());
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      //
      print("element:" + element.toString());
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getSearchWallpapers(widget.searchQuery.toString());
    super.initState();
    searchController.text = widget.searchQuery.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BrandName(),
        elevation: 0,
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
                        getSearchWallpapers(searchController.text.toString());
                      },
                      child: Container(
                        child: Icon(Icons.search),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // Container(
              //   height: 80,
              //   child: ListView.builder(
              //     padding: EdgeInsets.symmetric(horizontal: 24),
              //     itemCount: categories.length,
              //     shrinkWrap: true,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (context, index) {
              //       // wallpapers[index].src.portrait;
              //       return CategoriesTile(
              //           imgUrl: categories[index].imgUrl,
              //           title: categories[index].categoriesName);
              //     },
              //   ),
              // ),
              SizedBox(height: 16),
              WallpapersList(wallpapers: wallpapers, context: context),
            ],
          ),
        ),
      ),
    );
  }
}
