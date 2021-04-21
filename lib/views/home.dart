import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/models/category.dart';
import 'package:news/models/articleModel.dart';
import 'package:news/helper/data.dart';
import 'package:news/helper/news.dart';
import 'package:news/views/article.dart';
import 'package:news/views/categoryNews.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


 List<CategorieModel> categories = List<CategorieModel>();
 List<ArticleModel> articles = List<ArticleModel>();

 bool _loading = true;

 @override
  void initState() {
    super.initState();

    categories = getCategories();
    getNews();
  }

  getNews() async{
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading=false;
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
        elevation: 0.0,
      ),
      body:_loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ) : SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[

                  //...
                  //Categories
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 70,
                    child: ListView.builder(
                      itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        return CategoryCard(
                          imageUrl: categories[index].imageAssetUrl,
                          categoryName: categories[index].categorieName,
                        );
                      },
                    ),
                  ),

                  //...
                  //News Articles
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

class CategoryCard extends StatelessWidget {
  
  final String imageUrl, categoryName;
  CategoryCard({this.imageUrl,this.categoryName}); 

  @override
  Widget build(BuildContext context) { 
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => CategoryNews(
            category: categoryName.toLowerCase(),
          ),  
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6), 
              child: CachedNetworkImage(imageUrl: imageUrl, width: 120,height: 60,)
            ),
            Container(
              alignment: Alignment.center,
              width: 120,height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(categoryName, style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),),
            ),
          ],
        ),
      ),
    );
  }
}


class BlogCard extends StatelessWidget {

  final String imageUrl,title,desc,url;
  BlogCard({@required this.imageUrl,@required this.title,@required this.desc, @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => Article(
              blogUrl: url 
            )));
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 16),
          child: Column(
            children : <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl)),
              SizedBox(height: 8),
              Text(title, style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),),
              SizedBox(height: 8),
              Text(desc, style: TextStyle(color: Colors.black54),)
            ],
          ),
        ),
    );
  }
}