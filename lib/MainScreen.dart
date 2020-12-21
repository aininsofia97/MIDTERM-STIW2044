import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:midterm_hackathon/book.dart';
import 'package:midterm_hackathon/DetailScreen.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Books',
      theme: new ThemeData(
        fontFamily: 'RobotoMono',
        primaryColor: Colors.blue[250],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('List of Books'),
        ),
        body: Container(
          child: MainScreen(),
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  final Book book;

  const MainScreen({Key key, this.book}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List bookList;
  double screenHeight, screenWidth;
  String titlecenter = "Loading Books...";
  int starCount = 5;
  double rating = 0.00;

  @override
  void initState() {
    super.initState();
    _loadBook();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          bookList == null
              ? Flexible(
                  child: Container(
                      child: Center(
                          child: Text(
                  titlecenter,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ))))
                
              : Flexible(
                  child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: (screenWidth / screenHeight) /0.5,
                  children: List.generate(bookList.length, (index) {
                    return Padding(
                        padding: EdgeInsets.all(3),
                        child: Card(
                          child: InkWell(
                            onTap: () => _loadBookDetail(index),
                            child: Row(
                              children: [
                                Container(
                                    height: screenHeight / 0.2,
                                    width: screenWidth / 4.5,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "http://slumberjer.com/bookdepo/bookcover/${bookList[index]['cover']}.jpg",
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          new CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          new Icon(
                                        Icons.broken_image,
                                        size: screenWidth / 3,
                                      ),
                                    )),
                                //SizedBox(height: 5),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                      child:Text(
                                        bookList[index]['booktitle'],
                                        style: TextStyle(
                                          fontFamily: "Times New Roman",
                                          fontSize:12,
                                          fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                        ],
                                       ),
                                      Text(
                                        "Rating: " + bookList[index]['rating'],
                                        style: TextStyle(
                                          fontSize: 12,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Author : " + bookList[index]['author'],
                                        style: TextStyle(
                                          fontSize: 12,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "RM " + bookList[index]['price'],
                                        style: TextStyle(
                                          fontSize: 12,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ));
                  }),
                ))
        ],
      ),
    );
  }

  void _loadBook() {
    http.post("http://slumberjer.com/bookdepo/php/load_books.php", body: {
      // "location": "Changlun",
    }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        bookList = null;
        setState(() {
          titlecenter = "No Book Found";
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          bookList = jsondata["books"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  _loadBookDetail(int index) {
    print(bookList[index]['booktitle']);
    Book book = new Book(
        bookid: bookList[index]['bookid'],
        booktitle: bookList[index]['booktitle'],
        author: bookList[index]['author'],
        price: bookList[index]['price'],
        description: bookList[index]['description'],
        rating: bookList[index]['rating'],
        publisher: bookList[index]['publisher'],
        isbn: bookList[index]['isbn'],
        cover: bookList[index]['cover']);

    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => DetailsScreen(book: book,)
        ));
  }
}