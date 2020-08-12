import 'package:flutter/material.dart';

import '../newsView.dart';

class NewsTile extends StatelessWidget {
  final String imgUrl, title, description, content, url;

  NewsTile({this.imgUrl, this.description, this.title, this.content, @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => NewsView(url: url,)
        ));
      },
      child: Container(
          margin: EdgeInsets.only(top: 25,bottom: 25),
          width: MediaQuery.of(context).size.width,
          child: Container(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(6),bottomLeft:  Radius.circular(6))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        imgUrl,
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      )),

                  SizedBox(height: 15,),

                  Text(
                    title,
                    //maxLines: 2,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),

                  SizedBox(height: 5,),

                  Text(
                    description,
                    maxLines: 2,
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  )
                ],
              ),
            ),
          )),
    );
  }
}