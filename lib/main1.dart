import 'package:flutter/material.dart';

main() {
  runApp(MaterialApp(
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: const Text('Tabs and scrolling'),
                forceElevated: innerBoxIsScrolled,
                pinned: true,
                floating: true,
                bottom: const TabBar(
                  tabs: <Tab>[
                    Tab(text: 'Page 1'),
                    Tab(text: 'Page 2'),
                    Tab(text: 'Page 3'),
                    Tab(text: 'Page 4'),
                    Tab(text: 'Page 5'),
                    Tab(text: 'Page 6'),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[
              _list(),
              _list(),
              _list(),
              _list(),
              _list(),
              _list(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _list() {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 50,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.grey[200]!.withOpacity((index % 2).toDouble()),
            child: ListTile(
              title: Text(index.toString()),
            ),
          );
        });
  }
}
