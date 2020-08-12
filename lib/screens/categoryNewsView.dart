import 'package:flutter/material.dart';

import '../utils/server.dart';
import './widgets/newsTile.dart';
import './widgets/myAppBar.dart';


class CategoryNewsView extends StatefulWidget {

  final String newsCategory;
  CategoryNewsView({this.newsCategory});

  @override
  _CategoryNewsViewState createState() => _CategoryNewsViewState();
}

class _CategoryNewsViewState extends State<CategoryNewsView> {
  var newslist;
  bool _loading = true;

  @override
  void initState() {
    getNews();
    // TODO: implement initState
    super.initState();
  }

  void getNews() async {
    NewsForCategory news = NewsForCategory();
    await news.getNewsForCategory(widget.newsCategory);
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: _loading ? Center(
        child: CircularProgressIndicator(),
      ) : SingleChildScrollView(
        child: Container(
          child: Container(
            margin: EdgeInsets.only(top: 16),
            child: ListView.builder(
                itemCount: newslist.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return NewsTile(
                    imgUrl: newslist[index].urlToImage ?? "",
                    title: newslist[index].title ?? "",
                    description: newslist[index].description ?? "",
                    content: newslist[index].content ?? "",
                    url: newslist[index].articleUrl ?? "",
                  );
                }),
          ),
        ),
      ),
    );
  }
}
