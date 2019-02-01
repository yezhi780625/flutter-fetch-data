import 'package:flutter/material.dart';
import 'fetch.dart';
import 'Post.dart';

//void main() => runApp(MyApp(post: fetchPost()));
void main() => runApp(MaterialApp(home: HomePage()));

class MyApp extends StatelessWidget {
  final Future<Post> post;

  MyApp({Key key, this.post}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Remote Data Demo'),
        ),
        body: Center(
          child: Column(
            children: [
              new Image.network(
                  'https://github.com/nisrulz/flutter-examples/raw/develop/image_from_network/img/flutter_logo.png'),
              // even loads gifs
              // Gif image from Giphy, all copyrights are owned by Giphy
              new Image.network(
                  'https://github.com/nisrulz/flutter-examples/raw/develop/image_from_network/img/loop_anim.gif'),
              FutureBuilder<Post>(
                future: post,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.title);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner
                  return CircularProgressIndicator();
                },
            ),
            ]
          )
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  String title;
  void getData() async {
    Post post = await fetchPost();
    print(post);
    setState(() {
      title = post.title;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(onPressed: () {
              getData();
            }, child: Text('Get Data'),),
            Text('$title')
          ],
        )

      ),
    );
  }
}
