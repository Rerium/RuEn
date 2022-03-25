import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Ru<->En';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
        shadowColor: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: true,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  bool flag = true;
  String reversString = '';
  String lable = "Русский";
  var ruSimbols = ["ё", "й", "ц", "у", "к", "е", "н", "г", "ш", "щ",
                   "з", "х", "ъ", "ф", "ы", "в", "а", "п", "р", "о",
                   "л", "д", "ж", "э", "я", "ч", "с", "м", "и", "т",
                   "ь", "б", "ю", ".", "Ё", "Й", "Ц", "У", "К", "Е", 
                   "Н", "Г", "Ш", "Щ", "З", "Х", "Ъ", "Ф", "Ы", "В",
                   "А", "П", "Р", "О", "Л", "Д", "Ж", "Э", "Я", "Ч",
                   "С", "М", "И", "Т", "Ь", "Б", "Ю,"];
  var enSimbols = ["`", "q", "w", "e", "r", "t", "y", "u", "i", "o",
                     "p", "[", "]", "a", "s", "d", "f", "g", "h", "j",
                     "k", "l", ";", "'", "z", "x", "c", "v", "b", "n",
                     "m", ",", ".", "/", "~", "Q", "W", "E", "R", "T",
                     "Y", "U", "I", "O", "P", "{", "}", "A", "S", "D",
                     "F", "G", "H", "J", "K", "L", ":", "\"", "Z", "X",
                     "C", "V", "B", "N", "M", "<", ">", "?"];
  
  void reversText(String initialText ){
    if (initialText.isNotEmpty){
      if(flag){
        for(int i=0; i < ruSimbols.length; i++){
          final letter=ruSimbols[i];
          final newLetter=enSimbols[i];
          initialText = initialText.replaceAll("$letter", "$newLetter");
        }
      }else{
        for(int i=0; i < ruSimbols.length; i++){
          final letter=enSimbols[i];
          final newLetter=ruSimbols[i];
          initialText = initialText.replaceAll("$letter", "$newLetter");
        }
      }
      setState(() {
        reversString = initialText;
        Clipboard.setData(ClipboardData(text: initialText));
      });
    }
  }
  void switchLable(){
    if(flag){
      lable = "русский";
    }else {
      lable = "английский";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Введите $lable текст'),
            TextField(
              controller: _controller,
              style: const TextStyle(
                fontSize: 22
                ),
                maxLines: 1,
               decoration: const InputDecoration(
                 labelText: "Исходный текст",
                 border: OutlineInputBorder(),
               ),
              onSubmitted: (String value) async {
                reversText(value);
              },
            ),
           
            Text(
                '$reversString',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 22),
                
              ),
              TextButton(onPressed: () => {Clipboard.setData(ClipboardData(text: reversString))}, child: Text("Копировать")),
              FlutterSwitch(
                height: 40.0,
                width: 100.0,
                padding: 5.0,
                toggleSize: 40.0,
                borderRadius: 30.0,
                value: flag,
                onToggle: (fl) {
                  setState(() {
                    flag = fl;
                    switchLable();
                  });
                }
              ),
          ],
        ),
      ),
    );
  }
}
