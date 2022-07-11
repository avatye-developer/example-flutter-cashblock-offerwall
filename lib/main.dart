import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const IntroAuthenticatePage());
  }
}

class IntroAuthenticatePage extends StatefulWidget {
  const IntroAuthenticatePage({Key? key}) : super(key: key);

  @override
  State<IntroAuthenticatePage> createState() => _IntroAuthenticatePage();
}

class _IntroAuthenticatePage extends State<IntroAuthenticatePage> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }


  void _landingHomePage(BuildContext context) {
    String sendUserName = _textController.text;
    if (sendUserName.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MyHomePage(
                    title: '캐시블록-오퍼월 Sample',
                    userName: sendUserName,
                  )));
    } else {
      Fluttertoast.showToast(msg: "아이디를 입력하세요.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0x00564BDE),
          centerTitle: false,
          title: const Text('캐시블록'),
        ),
        body: Container(
          margin: const EdgeInsets.all(30),
          child: _authenticated(),
        ),
        bottomSheet: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                child: const Text('인증하기'),
                onPressed: () {
                  _landingHomePage(context);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _authenticated() {
    String userName = "";

    return Column(
      children: [
        Row(
          children: <Widget>[
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('인증하기', style: TextStyle(fontSize: 18)),
                    const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
                    const Text('사용할 아이디(메일주소)를 입력하세요.', style: TextStyle(fontSize: 14)),
                    const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 15)),
                    TextField(
                      controller: _textController,
                      decoration: const InputDecoration(hintText: 'example@example.com', labelText: '아이디(메일주소)', border: OutlineInputBorder()),
                      onChanged: (text) {
                        setState(() {
                          userName = text;
                        });
                      },
                    ),
                  ],
                )),
          ],
        )
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {


  const MyHomePage({Key? key, required this.title, required this.userName}) : super(key: key);

  final String title;
  final String userName;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('avatye.cashblock.offerwall/sample');


  @override
  void initState() {
    Fluttertoast.showToast(msg: '로그인 성공');
    _initCashBlock();
    super.initState();
  }

  Future<void> _initCashBlock() async {
    try {
      await platform.invokeMethod('cashBlock_init', widget.userName);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('_MyHomePageState -> _initCashBlock() --> error ${e.message}');
      }
    }
  }


  Future<void> _startCashBlock() async {
    try {
      await platform.invokeMethod('cashBlock_start');
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('_MyHomePageState -> _initCashBlock() --> error ${e.message}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          backgroundColor: const Color(0xff8c9eff),
          body: ListView(
            children: <Widget>[
              titleSection(),
            ],
          ),
        ));
  }

  titleSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Image(image: AssetImage('images/avatye_flutter_title_image.png')),
                const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                Container(
                  height: 0.5,
                  width: 500.0,
                  color: Colors.white,
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 5)),
                const Text(
                  "인증정보",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:  <Widget> [
                      const Text(
                        "ID: ",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                      Text(
                        widget.userName,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget> [
                      const Text(
                        "오퍼월 실행",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                      IconButton(
                          onPressed: _startCashBlock,
                          icon: Image.asset('images/avatye_offerwall_button.png'),
                          iconSize: 100,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
