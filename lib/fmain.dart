import 'package:flutter/material.dart';

/// Flutter code sample for [NestedScrollView].

void main() => runApp(const NestedScrollViewExampleApp());

class NestedScrollViewExampleApp extends StatelessWidget {
  const NestedScrollViewExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NestedScrollViewExample(),
    );
  }
}

class NestedScrollViewExample extends StatelessWidget {
  const NestedScrollViewExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(headerSliverBuilder:
            (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        SliverOverlapAbsorber(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          sliver: SliverAppBar(
            title: const Text('Snapping Nested SliverAppBar'),
            automaticallyImplyLeading: true,
            floating: true,
            // snap: true,
            expandedHeight: 500.0,
            pinned: true,
            forceElevated: innerBoxIsScrolled,
            flexibleSpace: ListView(
              primary: false,
              children: [
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: Image.network(
                    "http://72.63.223.53:8000/storage/app/public/35/43-hotel-exterior-v2-resized.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: Container(
                color: Colors.white,
                child: Row(
                  children: [
                    Tab(text: 'TAB 1'),
                    Tab(text: 'TAB 2'),
                    Tab(text: 'TAB 3'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ];
    }, body: Builder(builder: (BuildContext context) {
      return CustomScrollView(
        // The "controller" and "primary" members should be left unset, so that
        // the NestedScrollView can control this inner scroll view.
        // If the "controller" property is set, then this scroll view will not
        // be associated with the NestedScrollView.

        slivers: <Widget>[
          SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
          SliverFixedExtentList(
            itemExtent: 48.0,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) =>
                  ListTile(title: Text('Item $index')),
              childCount: 100,
            ),
          ),
        ],
      );
    })));
  }
}
