import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MezzoScrollPage(),
    );
  }
}

class MezzoScrollPage extends StatefulWidget {
  MezzoScrollPage({Key? key}) : super(key: key);

  @override
  State<MezzoScrollPage> createState() => _MezzoScrollPageState();
}

class _MezzoScrollPageState extends State<MezzoScrollPage> {
  final ScrollController scrollController = ScrollController();
  double offset = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(onScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (scrollController.hasClients) ? scrollController.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            CurvedScrollableHeader(parentPageSize: MediaQuery.of(context).size, offset: offset),
            ...DummyWidgets(),
          ],
        ),
      ),
    );
  }
}

class CurvedScrollableHeader extends StatefulWidget {
  final Size parentPageSize;
  final double offset;
  CurvedScrollableHeader({
    Key? key,
    required this.parentPageSize,
    required this.offset,
  }) : super(key: key);

  @override
  State<CurvedScrollableHeader> createState() => _CurvedScrollableHeaderState();
}

class _CurvedScrollableHeaderState extends State<CurvedScrollableHeader> {
  @override
  Widget build(BuildContext context) {
    double height = widget.parentPageSize.height / 3;
    print('Height is: $height');
    return ClipPath(
      clipper: MezzoClipper(),
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.amber.shade50, Colors.amber.shade900],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          // color: Colors.amber,
        ),
      ),
    );
  }
}

class MezzoClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = Path();

    path.lineTo(0, size.height - 50);
    // path.lineTo(size.width, size.height - 50);
    // path.quadraticBezierTo(size.width / 4, size.height, size.width, size.height - 150);
    path.cubicTo(
        size.width / 4, size.height, size.width / 2, size.height / 2.5, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    // path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

List<Widget> DummyWidgets() => <Widget>[
      const SizedBox(height: 25),
      const Text('Under header'),
      const SizedBox(height: 100),
      const Text('Under header 2'),
      const SizedBox(height: 100),
      const Text('Under header 3'),
      const SizedBox(height: 100),
      const Text('Under header 4'),
      const SizedBox(height: 100),
      const Text('Under header 5'),
      const SizedBox(height: 100),
      Container(
        color: Colors.teal.shade200,
        child: const Text('The container'),
      )
    ];
