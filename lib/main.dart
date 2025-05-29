import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:number_text_input_formatter/number_text_input_formatter.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import 'calculate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double a_rate = 0.0;
  int a_period = 0;
  double b_rate = 0.0;
  int b_period = 0;
  double c_rate = 0.0;
  int c_period = 0;
  double a_payoff = 0.0;
  double a_total = 0.0;
  double b_payoff = 0.0;
  double b_total = 0.0;
  double c_payoff = 0.0;
  double c_total = 0.0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'محاسبه مبلغ کل',
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.w800),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        textDirection: TextDirection.rtl,
                                        keyboardType: TextInputType.number,
                                        onChanged: (str) {
                                          setState(() {
                                            a_rate = double.parse(str);
                                          });
                                        },
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: const InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'درصد',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        onChanged: (str) {
                                          setState(() {
                                            a_period = int.parse(str);
                                          });
                                        },
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: const InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'تعداد ماه',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        onChanged: (str) {
                                          setState(() {

                                            a_payoff = double.parse(str.replaceAll(',', ''));
                                          });
                                        },
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly,
                                          CurrencyTextInputFormatter(groupDigits: 3)
                                        ],
                                        decoration: const InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'مبلغ قسط',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 25.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${Amortization(a_payoff.toDouble(), a_rate.toDouble(), a_period ).calculateTotal().toStringAsFixed(2).seRagham()} تومان ',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 23),
                                    ),
                                    Text(
                                      ' تفاوت ${(a_payoff.toDouble() * a_period - Amortization(a_payoff.toDouble(), a_rate.toDouble(), a_period ).calculateTotal()).toStringAsFixed(2).seRagham()} تومان ',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w100,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'محاسبه قسط',
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.w800),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        textDirection: TextDirection.rtl,
                                        keyboardType: TextInputType.number,
                                        onChanged: (str) {
                                          setState(() {
                                            b_rate = double.parse(str);
                                          });
                                        },
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: const InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'درصد',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        onChanged: (str) {
                                          setState(() {
                                            b_period = int.parse(str);
                                          });
                                        },
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: const InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'تعداد ماه',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        onChanged: (str) {
                                          setState(() {
                                            b_total = double.parse(str.replaceAll(',', ''));
                                          });
                                        },
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly,
                                          CurrencyTextInputFormatter(groupDigits: 3)
                                        ],
                                        decoration: const InputDecoration(
                                          border: UnderlineInputBorder(),

                                          labelText: 'مبلغ کل',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 25.0),
                                child: Column(
                                  children: [
                                    Text(
                                      ReverseAmortization(b_total.toDouble(),
                                                  b_rate.toDouble(), b_period )
                                              .calculateMonthlyPayment()
                                              .toStringAsFixed(2)
                                              .seRagham() +
                                          ' تومان ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300, fontSize: 23),
                                    ),
                                    Text(
                                      ' تفاوت ${(ReverseAmortization(b_total.toDouble(),
                                          b_rate.toDouble(), b_period )
                                          .calculateMonthlyPayment() * a_period - b_total).toStringAsFixed(2).seRagham()} تومان ',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w100,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'محاسبه ماه',
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.w800),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        textDirection: TextDirection.rtl,
                                        keyboardType: TextInputType.number,
                                        onChanged: (str) {
                                          setState(() {
                                            c_rate = double.parse(str);
                                          });
                                        },
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: const InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'درصد',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        onChanged: (str) {
                                          setState(() {
                                            c_payoff = double.parse(str.replaceAll(',', ''));
                                          });
                                        },
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly,
                                          CurrencyTextInputFormatter(groupDigits: 3)
                                        ],
                                        decoration: const InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'مبلغ قسط',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        onChanged: (str) {
                                          setState(() {
                                            c_total = double.parse(str.replaceAll(',', ''));
                                          });
                                        },
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly,
                                          CurrencyTextInputFormatter(groupDigits: 3)
                                        ],
                                        decoration: const InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'مبلغ کل',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 25.0),
                                child: Text(
                                  '${CalculateMonth(c_total.toDouble(),
                                              c_rate.toDouble(),c_payoff)
                                          .calculatePeriods()} ماه ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300, fontSize: 23),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
