import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_paralax_animation/closed_bottom_sheet_widget.dart';

class SlidingCardWidget extends StatefulWidget {
  const SlidingCardWidget({super.key});

  @override
  State<SlidingCardWidget> createState() => _SlidingCardWidgetState();
}

class _SlidingCardWidgetState extends State<SlidingCardWidget> {
  late PageController pageController;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController
        .addListener(() => setState(() => pageOffset = pageController.page!));
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: pageController,
        builder: (context, child) => SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              child: PageView.builder(
                  controller: pageController,
                  itemCount: events.length,
                  itemBuilder: (context, index) => CardWidget(
                      name: 'Shenzhen Global design Award',
                      assetName: events[index].assetName,
                      date: events[index].date,
                      pageOffset: pageOffset - index)),
            ));
  }
}

class CardWidget extends StatelessWidget {
  final String name, assetName, date;
  final double pageOffset;

  const CardWidget(
      {super.key,
      required this.name,
      required this.assetName,
      required this.date,
      required this.pageOffset});

  @override
  Widget build(BuildContext context) {
    double gauss = exp(-(pow((pageOffset.abs() - 0.5), 2) / 0.08));
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.55,
      child: Card(
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 24),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.asset('assets/$assetName',
                    height: MediaQuery.of(context).size.height * 0.3,
                    alignment: Alignment(pageOffset.abs(), 0),
                    fit: BoxFit.none)),
            const SizedBox(height: 8),
            CardContentWidget(name: name, date: date, pageOffset: gauss),
          ],
        ),
      ),
    );
  }
}

class CardContentWidget extends StatelessWidget {
  const CardContentWidget(
      {Key? key,
      required this.name,
      required this.date,
      required this.pageOffset})
      : super(key: key);

  final String name;
  final String date;
  final double pageOffset;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.translate(
              offset: Offset(8 * pageOffset, 0),
              child: Text(name, style: const TextStyle(fontSize: 20))),
          const SizedBox(height: 8),
          Transform.translate(
              offset: Offset(8 * pageOffset, 0),
              child: Text(date, style: const TextStyle(color: Colors.grey))),
          const SizedBox(height: 8),
          Transform.translate(
            offset: Offset(8 * pageOffset, 0),
            child: const Text(
                'Now, what should SlidingCard look like? '
                'It definitely drops some shadows so we '
                'should think of Material or Card widget. '
                'I went with the Card.',
                style: TextStyle(color: Colors.grey)),
          ),
          const Spacer(),
          Transform.translate(
            offset: Offset(8 * pageOffset, 0),
            child: Row(
              children: [
                MaterialButton(
                  color: const Color(0xFF162A49),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  onPressed: () {},
                  child: const Text('Reserve'),
                ),
                const Spacer(),
                const Text(
                  '0.00 \$',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
