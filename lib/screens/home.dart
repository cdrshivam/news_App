import 'package:flutter/material.dart';

import './widgets/newsTile.dart';
import '../model/categoryModel.dart';
import '../utils/server.dart';
import '../utils/catergory.dart';
import './categoryNewsView.dart';
import './widgets/myAppBar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool _loading;
  var newsList;

  List<CategoryModel> categories = List<CategoryModel>();

  void getNews() async {
    NewsServer news = NewsServer();
    await news.getNews();
    newsList = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loading = true;
    // TODO: implement initState
    super.initState();

    categories = getCategories();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SafeArea(
        child: _loading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20,bottom: 15),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 70,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return CategoryCard(
                          imageUrl: categories[index].imageUrl,
                          categoryName: categories[index].categoryName,
                        );
                      }),
                ),

                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: ListView.separated(
                      itemCount: newsList.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.white,
                        indent: 25,
                        endIndent: 25,
                        thickness: 1,
                      ),
                      itemBuilder: (context, index) {
                        return NewsTile(
                          imgUrl: newsList[index].urlToImage ?? "",
                          title: newsList[index].title ?? "",
                          description: newsList[index].description ?? "",
                          content: newsList[index].content ?? "",
                          url: newsList[index].articleUrl ?? "",
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imageUrl, categoryName;

  CategoryCard({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => CategoryNewsView(
              newsCategory: categoryName.toLowerCase(),
            )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 14),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image(
                image: NetworkImage(imageUrl),
                height: 60,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black26,
              ),
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
