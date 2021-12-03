import 'package:universal_html/html.dart' as html;
import 'package:universal_html/js.dart' as js;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text = '';
  var list = [];
  TextEditingController _textEditingController = TextEditingController();

  Future<void> injectCssAndJSLibraries() async {
    final List<Future<void>> loading = <Future<void>>[];
    final List<html.HtmlElement> tags = <html.HtmlElement>[];

    final html.LinkElement css = html.LinkElement()
      ..attributes = {"rel": "stylesheet"}
      ..href = 'assets/CSS/testForm.css';
    tags.add(css);

    final html.ScriptElement script = html.ScriptElement()
      ..async = true
      // ..defer = true
      ..src = "assets/JS/testForm.js";
    loading.add(script.onLoad.first);
    tags.add(script);

    html.querySelector('body')?.children.addAll(tags);

    await Future.wait(loading);
  }

  @override
  void initState() {
    super.initState();
    injectCssAndJSLibraries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textEditingController,
              onSubmitted: (value) {
                var number = int.parse(value);
                setState(() {
                  list.add(number);
                  _textEditingController.clear();
                });
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            text = js.context.callMethod('getValue', list).toString();
            html.querySelector('body')?.children.insert(
                0,
                html.DivElement()
                  ..innerHtml = text
                  ..id = 'passField');
          });
        },
        tooltip: 'Login',
        child: Icon(Icons.login),
      ),
    );
  }
}
