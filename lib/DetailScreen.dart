import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'book.dart';

class DetailsScreen extends StatefulWidget {
  final Book book;

  const DetailsScreen({Key key, this.book}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.booktitle),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    height: screenHeight / 0.5,
                    width: screenWidth / 0.5,
                    child: SingleChildScrollView(
                      child: CachedNetworkImage(
                        imageUrl:
                            "http://slumberjer.com/bookdepo/bookcover/${widget.book.cover}.jpg",
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            new CircularProgressIndicator(),
                        errorWidget: (context, url, error) => new Icon(
                          Icons.broken_image,
                          size: screenWidth / 2,
                        ),
                      ),
                    )),
                Divider(color: Colors.black),
                Text('Description',
                textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 6),
                Text(widget.book.description),
                Divider(color: Colors.black),
                Container(
                  child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Type',
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Details',
                        ),
                      ),
                    ],
                    rows: <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text("Title")),
                          DataCell(Text(widget.book.booktitle)),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text("Rating")),
                          DataCell(Text(widget.book.rating)),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text("Author")),
                          DataCell(Text(widget.book.author)),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text("Price")),
                          DataCell(Text("RM " + widget.book.price)),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text("ISBN")),
                          DataCell(Text(widget.book.isbn)),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text("Publisher")),
                          DataCell(Text(widget.book.publisher)),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }
}