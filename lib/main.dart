import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

final String mediaDownload = "https://icarus-cdn.nyc3.cdn.digitaloceanspaces.com/resources/_6/7b/e2EC/D9C94F85aca9bce1/A75e2CfBd5D7/48B53b83de64/9FB07A4b936a69f4/de6Fab25/e01a1388FC970Ac7";

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
  List<AudioPlayer> probablyPlaying = List<AudioPlayer>();

  Future<void> _playFile(String fromUrl) async
  {
    File f = File((await getApplicationDocumentsDirectory()).path + "/cache/${md5.convert(utf8.encode(fromUrl))}");

    if(!f.existsSync())
    {
      print("Downloading $fromUrl");
      await Dio().download(
        fromUrl,
        f.path,
        deleteOnError: true,
      );
      print("Downloaded $fromUrl");
      print("Saved to ${f.path}");
    }

    else
    {
      print("Using cached copy ${f.path}");
    }

    AudioPlayer p = AudioPlayer();
    probablyPlaying.add(p);
    print("-> Set File Path ${f.path}");
    await p.setFilePath(f.path);
    print("-> load");
    await p.load();
    print("-> play");
    await p.play();
    print("-> stop");
    await p.stop();
    print("-> dispose");
    await p.dispose();
  }

  Future<void> _playURL(String url) async
  {
    AudioPlayer p = AudioPlayer();
    probablyPlaying.add(p);
    print("-> Set URL $url");
    await p.setUrl(url);
    print("-> load");
    await p.load();
    print("-> play");
    await p.play();
    print("-> stop");
    await p.stop();
    print("-> dispose");
    await p.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.stop),
            onPressed: () {
              probablyPlaying.forEach((element) => element.stop().then((value) => element.dispose()));
              probablyPlaying.clear();
            },
          )
        ],
      ),
      body: ListView(
          children: [
            ListTile(
              title: Text("Test URL"),
              subtitle: Text(
              "Test URL will simply tell just_audio to play (stream) from the url",
            ),
              onTap: () => _playURL(mediaDownload),
            ),
            ListTile(
              title: Text("Test File"),
              subtitle: Text(
              "Test File will download the same url to a file, and play the cached file.",
            ),
              onTap: () => _playFile(mediaDownload),
            )
          ],
        ),  
    );
  }
}
