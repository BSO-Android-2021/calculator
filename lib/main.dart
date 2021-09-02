import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final List<String> buttons = [
    'AC',
    'delete',
    '%',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '',
    '0',
    '.',
    '=',
  ];

  String display = '0';

  void operasi(String karakter) {
    // 1. pecah string menjadi array => (split)
    // 2. sum (total) nilai di array => fold/reduce
    // 3. ubah hasil sum menjadi string

    setState(() {
      switch (karakter) {
        case '=':
          if (display.contains('+')) {
            List<String> nilai = display.split('+');
            print(nilai.toString());
            int hasil = nilai.fold(0, (prev, next) => prev + int.parse(next));
            display = hasil.toString();
          } else if (display.contains('-')) {
            List<String> nilai = display.split('-');
            int hasil = int.parse(nilai[0]) - int.parse(nilai[1]);
            display = hasil.toString();
          } else if (display.contains('*')) {
            List<String> nilai = display.split('*');
            int hasil = int.parse(nilai[0]) * int.parse(nilai[1]);
            display = hasil.toString();
          } else if (display.contains('/')) {
            List<String> nilai = display.split('/');
            double hasil = int.parse(nilai[0]) / int.parse(nilai[1]);
            display = hasil.toString();
          }
          break;
        case 'AC':
          display = '0';
          break;
        case 'delete':
          if (display.length > 1) {
            display = display.substring(0, display.length - 1);
          } else {
            display = '0';
          }
          break;
        default:
          display += karakter;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    display,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.grey[200],
                child: GridView.count(
                  crossAxisCount: 4,
                  children: [
                    for (String button in buttons)
                      if (button == 'delete')
                        IconButton(
                          onPressed: () {
                            operasi(button);
                          },
                          icon: Icon(Icons.backspace),
                        )
                      else if (button == '')
                        Container()
                      else
                        TextButton(
                          onPressed: () {
                            setState(() {
                              // display = button;
                              if (display == '0') {
                                display = button;
                              } else {
                                operasi(button);
                              }
                            });
                          },
                          child: Text(
                            button,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
