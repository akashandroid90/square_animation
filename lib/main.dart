import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestures And Animations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int numTaps = 0;
  int numDoubleTaps = 0;
  int numLongTaps = 0;
  double posX = 0.0;
  double posY = 0.0;
  double boxSize = 0.0;
  double fullBoxSize = 150.0;
  Animation<double> animation;
  AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5000));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    animation.addListener(() {
      setState(() {
        boxSize= fullBoxSize * animation.value;
      });
    center(context);
    });
    controller.forward();
  }

@override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    if (posX == 0.0) center(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestures And Animations'),
      ),
      bottomNavigationBar: Material(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            'Taps: $numTaps - Double Taps: $numDoubleTaps - Long Press - $numLongTaps',
            style: Theme.of(context).textTheme.title,
          ),
        ),
      ),
      body: GestureDetector(
        child: Stack(
          children: <Widget>[
            Positioned(
              left: posX,
              top: posY,
              child: Container(
                width: boxSize,
                height: boxSize,
                color: Colors.red,
              ),
            )
          ],
        ),
        onTap: () {
          setState(() {
            numTaps++;
          });
        },
        onDoubleTap: () {
          numDoubleTaps++;
        },
        onLongPress: () {
          setState(() {
            numLongTaps++;
          });
        },
        onVerticalDragUpdate: (DragUpdateDetails details) {
          setState(() {
            posY += details.delta.dy;
          });
        },
        onHorizontalDragUpdate: (DragUpdateDetails details) {
          setState(() {
            posX += details.delta.dx;
          });
        },
      ),
    );
  }

  void center(BuildContext context) {
    posX = MediaQuery.of(context).size.width / 2 - boxSize / 2;
    posY = MediaQuery.of(context).size.height / 2 - boxSize / 2 - 30.0;

    setState(() {
      posX = posX;
      posY = posY;
    });
  }
}
