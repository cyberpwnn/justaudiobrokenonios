import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JustAudio Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'JustAudio Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _play() {
    AudioPlayer p = AudioPlayer();
    p.setUrl("https://icarus-cdn.nyc3.cdn.digitaloceanspaces.com/resources/_6/7b/e2EC/D9C94F85aca9bce1/A75e2CfBd5D7/48B53b83de64/9FB07A4b936a69f4/de6Fab25/e01a1388FC970Ac7").then((value) =>
     p.load().then((value) => 
     p.play().then((value) =>
     p.stop().then((value) => 
     p.dispose()))));
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _play,
        tooltip: 'Play',
        child: Icon(Icons.play_arrow),
      ), 
    );
  }
}
