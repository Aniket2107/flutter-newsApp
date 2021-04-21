import 'package:flutter/material.dart';
import 'package:news/helper/news.dart';
import 'package:news/models/articleModel.dart';
import 'package:news/views/home.dart';

class CategoryNews extends StatefulWidget {
  
  final String category;
  CategoryNews({this.category});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {

  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async{
    CategoryNewsClass newClass = CategoryNewsClass();
    await newClass.getCategoryNews(widget.category);
    articles = newClass.news;
    setState(() {
      _loading= false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('360'),
            Text('News', style:TextStyle(
              color:Colors.blue,
            ),)
          ],
        ),
        actions: [
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save),
            ),
          ),
        ],
        elevation: 0.0,
      ),
      body: _loading ? 
        Center(
          child: Container(
            child: CircularProgressIndicator(),
          ), 
        ) : 
        SingleChildScrollView(
         child: Container(
           padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 16),
                  child: ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context,index) {
                    return BlogCard(
                      imageUrl: articles[index].urlToImage,
                      title: articles[index].title,
                      desc: articles[index].description,
                      url: articles[index].url
                    );   
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}