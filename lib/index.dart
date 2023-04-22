// ignore_for_file: avoid_print, no_logic_in_create_state, avoid_returning_null_for_void, unnecessary_brace_in_string_interps, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:emy/Store/store.dart';

import 'package:intl/intl.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() {
    print('ESTADO CRIADO');
    return _IndexState();
  }
}

class _IndexState extends State<Index> {
  late StreamSubscription _streamSubscription;
  final StreamController<int> _controller = StreamController<int>();

  @override
  void initState() {
    print('ESTADO INICIADO');
    super.initState();
    _streamSubscription = _controller.stream.listen((data) {
      // Atualiza a interface gráfica com os novos dados do stream
      print('Data from stream: $data');
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    // Cancela a assinatura do stream
    super.dispose();
  }

  final Counter appStore = Counter();
  final Variables variables = Variables();
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    List<Widget> containers = [];
    List<Widget> slides = [];

    // Obter data e hora atuais
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy - HH:mm:ss').format(now);

    bool _isHighISO = true;

    for (int i = 0; i < 5; i++) {
      containers.add(Observer(
        builder: (_) => Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i == variables.indexList ? Colors.black : Colors.grey)),
      ));
    }

    for (int i = 0; i < 5; i++) {
      slides.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 4),
                  borderRadius: BorderRadius.circular(10),
                ),
              )),
        ),
      );
    }

    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.white,
          secondary: Colors.black12,
        ),
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            elevation: 0,
            onPressed: appStore.increment,
            child: const Icon(
              Icons.heart_broken_outlined,
            )),
        appBar: AppBar(
            title: const Text(
              'App in Flutter',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            scrolledUnderElevation: 0,
            elevation: 0,
            shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(8.0),
              child: Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xFF363636), width: 4))),
              ),
            ),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/secound');
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ))
            ]),
        body: SingleChildScrollView(
          controller: controller,
          physics: const ScrollPhysics(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Observer(
                    builder: (_) => Text(
                          'Count : ${appStore.counter}',
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20,
                            backgroundColor: null,
                          ),
                        )),
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: PageView(
                      pageSnapping: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      controller: controller,
                      children: slides,
                      onPageChanged: (int index) {
                        variables.indexList = index;
                      }),
                ),
                SizedBox(
                    width: 60,
                    height: 20,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: containers)),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'Olá, seja bem vindo!',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.normal,
                              overflow: TextOverflow.fade,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color(0xff000000)),
                                      minimumSize: MaterialStateProperty.all(
                                          const Size(120, 40))),
                                  onPressed: () {},
                                  child: const Text('Ver mais'),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: Stack(children: [
                    SizedBox(
                        width: double.infinity,
                        height: 300,
                        child: Image.asset(
                          'assets/imgs/bg2.png',
                          fit: BoxFit.cover,
                        )),
                    Positioned(
                      top: 20,
                      left: 0,
                      right: 0,
                      bottom: 20,
                      child: PageView(
                          pageSnapping: false,
                          controller: PageController(viewportFraction: 0.5),
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: ClipRect(
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                  child: Container(
                                    width: 40000,
                                    height: 1000,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xFFACACAC)
                                          .withAlpha(128),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: ClipRect(
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xFFACACAC)
                                          .withAlpha(128),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    )
                  ]),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Valor',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => variables.chanceswitchvalue(),
                                child: Observer(
                                  builder: (_) => Switch(
                                    value: variables.switchvalue,
                                    onChanged: (bool newValue) {
                                      variables.chanceswitchvalue();
                                    },
                                    activeTrackColor: Colors.black,
                                    activeColor:
                                        const Color.fromARGB(255, 95, 90, 90),
                                    inactiveThumbColor: Colors.white,
                                    inactiveTrackColor: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Observer(
                          builder: (_) => AnimatedOpacity(
                            opacity: variables.switchvalue == true ? 1 : 0,
                            duration: const Duration(seconds: 1),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                Container(
                                    width: double.infinity,
                                    height: 100,
                                    decoration:
                                        const BoxDecoration(color: Colors.pink),
                                    child: const Text(
                                      'Valor',
                                      style:
                                          TextStyle(fontFamily: 'Montserrat'),
                                    )),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 500,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
