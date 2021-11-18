import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String tentangKami = """
BSO Android 2021:
1. Akhdan Musyaffa Firdaus
2. Faizal Ramadhan
3. Farhan Rizky Fauzi
4. Fawzan Ibnu
5. Naufal Berlian
6. Shinta Sirnawati
7. Zulfa Dwi Audina
""";

  bool darkMode = false;
  final List<String> buttons = [
    'C',
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
    '00',
    '0',
    '.',
    '=',
  ];

  String display = '0';
  String expression = "";

  void buttonOnClick(String tombol) {
    switch (tombol) {
      case "C":
        clearAll();
        break;
      case "delete":
        delete();
        break;
      case "=":
        calculate();
        break;
      default:
        assign(tombol);
        break;
    }
  }

  void assign(String tombol) {
    if (display != "0") {
      display = display + tombol;
    } else {
      display = tombol;
    }
  }

  void calculate() {
    expression = display;
    display = "=" + display.interpret().toString();
  }

  void delete() {
    if (display.length > 1) {
      display = display.substring(0, display.length - 1);
    } else {
      display = "0";
    }
  }

  void clearAll() {
    expression = "";
    display = "0";
  }

  String getButtonText(String tombol) {
    if (tombol == "delete") {
      return "⌫";
    } else if (tombol == "/") {
      return "÷";
    } else if (tombol == "*") {
      return "x";
    } else {
      return tombol;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: darkMode ? Brightness.dark : Brightness.light,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Calculator App")),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: Text("Dark Mode"),
                trailing: Switch(
                  value: darkMode,
                  onChanged: (val) {
                    setState(() {
                      darkMode = val;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text("Tentang Kami"),
                trailing: Builder(builder: (context) {
                  return IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Tentang Kami"),
                              content: Text(tentangKami),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Ok"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.info));
                }),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: SelectableText(
                          expression,
                          style: TextStyle(fontSize: 38),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: SelectableText(
                          display,
                          style: TextStyle(fontSize: 38),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  // color: Colors.grey[200],
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 3 / 2.25,
                      // crossAxisSpacing: 16,
                      // mainAxisSpacing: 16,
                    ),
                    itemCount: buttons.length,
                    itemBuilder: (context, index) {
                      return TextButton(
                        onPressed: () {
                          try {
                            setState(() {
                              buttonOnClick(buttons[index]);
                            });
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                  "Operasi tidak valid",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          }
                        },
                        child: Text(
                          getButtonText(buttons[index]),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
