import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

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

class NestedScrollViewExample extends StatefulWidget {
  const NestedScrollViewExample({super.key});

  @override
  State<NestedScrollViewExample> createState() =>
      _NestedScrollViewExampleState();
}

class _NestedScrollViewExampleState extends State<NestedScrollViewExample> {
  int selectedMenu = 0;
  // ScrollController contentScrollController = ScrollController();
  // ScrollController tabScrollController = ScrollController();
  // var itemKey = <GlobalKey>[
  //   GlobalKey(),
  //   GlobalKey(),
  //   GlobalKey(),
  //   GlobalKey(),
  //   GlobalKey(),
  //   GlobalKey(),
  //   GlobalKey(),
  //   GlobalKey(),
  // ];
  var itemScrollController = ItemScrollController();
  var tabScrollController = ItemScrollController();
  var itemPositionsListener = ItemPositionsListener.create();
  final List<String> tabs = <String>[
    'Tab 1',
    'Tab 2',
    'Tab 3',
    'Tab 4',
    'Tab 5',
    'Tab 6',
    'Tab 7',
    'Tab 8'
  ];

  @override
  void initState() {
    // TODO: implement initState
    // contentScrollController.addListener(() {
    //   print('OFFSET: ${contentScrollController.offset}');
    //   tabScrollController.animateTo(contentScrollController.offset,
    //       duration: Duration(seconds: 1), curve: Curves.linear);
    //   // setState(() {
    //   //   selectedMenu = contentScrollController.offset.toInt();
    //   // });
    //   // if (contentScrollController.offset != selectedMenu) {

    //   // }
    // });

    itemPositionsListener.itemPositions.addListener(() {
      final indice = itemPositionsListener.itemPositions.value
          .where((item) {
            final isTopVisible = item.itemLeadingEdge >= 0;
            final isBottomVisible = item.itemTrailingEdge <= 1;

            return isTopVisible && isBottomVisible;
          })
          .map((item) => item.index)
          .toList();

      if (indice.isNotEmpty) {
        if (selectedMenu != indice.first) {
          setState(() {
            selectedMenu = indice.first;
            scrollToTab();
            print("VISIBLE: $indice");
          });
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future scrollToItem() async {
    //  final context = itemKey[selectedMenu].currentContext;
    // await Scrollable.ensureVisible(context!,
    //     alignment: 0.5, duration: const Duration(seconds: 1));
    itemScrollController.scrollTo(
        index: selectedMenu,
        duration: const Duration(seconds: 1),
        alignment: 0.5);
  }

  Future scrollToTab() async {
    tabScrollController.scrollTo(
      index: selectedMenu,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          // These are the slivers that show up in the "outer" scroll view.
          return <Widget>[
            SliverOverlapAbsorber(
              // This widget takes the overlapping behavior of the SliverAppBar,
              // and redirects it to the SliverOverlapInjector below. If it is
              // missing, then it is possible for the nested "inner" scroll view
              // below to end up under the SliverAppBar even when the inner
              // scroll view thinks it has not been scrolled.
              // This is not necessary if the "headerSliverBuilder" only builds
              // widgets that do not overlap the next sliver.
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                // title: const Text('Books'), // This is the title in the app bar.
                pinned: true,
                floating: true,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.fullscreen,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ],
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            4,
                            (index) => IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.home,
                                  size: 36,
                                  color: Colors.white,
                                ))),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.home,
                                size: 36,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.home,
                                size: 36,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.home,
                                size: 36,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.home,
                                size: 36,
                                color: Colors.white,
                              ))
                        ])
                  ],
                ),
                expandedHeight: 500,
                // The "forceElevated" property causes the SliverAppBar to show
                // a shadow. The "innerBoxIsScrolled" parameter is true when the
                // inner scroll view is scrolled beyond its "zero" point, i.e.
                // when it appears to be scrolled below the SliverAppBar.
                // Without this, there are cases where the shadow would appear
                // or not appear inappropriately, because the SliverAppBar is
                // not actually aware of the precise position of the inner
                // scroll views.
                forceElevated: innerBoxIsScrolled,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(50),
                  child: Container(
                    color: Colors.white,
                    height: 50,
                    child: ScrollablePositionedList.builder(
                      itemScrollController: tabScrollController,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // These are the widgets to put in each tab in the tab bar.
                      scrollDirection: Axis.horizontal,
                      itemCount: tabs.length,
                      itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedMenu = index;
                                // contentScrollController.animateTo(
                                //     index.toDouble(),
                                //     duration: const Duration(seconds: 1),
                                //     curve: Curves.easeInOut);
                                scrollToItem();
                                print('SELECTED: $selectedMenu');
                                // controller.attach(position);
                              });
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(tabs[index]),
                                Container(
                                  height: 4,
                                  width: 100,
                                  color: (index == selectedMenu)
                                      ? Colors.red
                                      : null,
                                )
                              ],
                            ),
                          )),
                    ),
                  ),
                ),
              ),
            )
          ];
        },
        body: buildTheContent(),
      ),
    );
  }

  SafeArea safeArea() {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        // This Builder is needed to provide a BuildContext that is
        // "inside" the NestedScrollView, so that
        // sliverOverlapAbsorberHandleFor() can find the
        // NestedScrollView.
        builder: (BuildContext context) {
          return CustomScrollView(
            //  controller: controller,
            // The "controller" and "primary" members should be left
            // unset, so that the NestedScrollView can control this
            // inner scroll view.
            // If the "controller" property is set, then this scroll
            // view will not be associated with the NestedScrollView.
            // The PageStorageKey should be unique to this ScrollView;
            // it allows the list to remember its scroll position when
            // the tab view is not on the screen.
            // key: PageStorageKey<String>(name),
            slivers: <Widget>[
              SliverOverlapInjector(
                // This is the flip side of the SliverOverlapAbsorber
                // above.
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                // In this example, the inner scroll view has
                // fixed-height list items, hence the use of
                // SliverFixedExtentList. However, one could use any
                // sliver widget here, e.g. SliverList or SliverGrid.
                sliver: SliverFixedExtentList(
                  // The items in this example are fixed to 48 pixels
                  // high. This matches the Material Design spec for
                  // ListTile widgets.
                  itemExtent: 200,
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      // This builder is called for each child.
                      // In this example, we just number each list item.
                      return buildTheContent();
                      //   return GestureDetector(
                      //     onTap: () {
                      //       setState(() {
                      //         selectedMenu = index;
                      //       });
                      //     },
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Container(
                      //           color: Colors.blueAccent,
                      //           child: Text('Item ${index + 1}')),
                      //     ),
                      //   );
                    },
                    // The childCount of the SliverChildBuilderDelegate
                    // specifies how many children this inner list
                    // has. In this example, each tab has a list of
                    // exactly 30 items, but this is arbitrary.
                    childCount: 1,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  buildTheContent() {
    return Builder(builder: (context) {
      return ScrollablePositionedList.builder(
          // primary: false,
          itemScrollController: itemScrollController,
          itemPositionsListener: itemPositionsListener,
          shrinkWrap: false,
          // controller: contentScrollController,
          itemCount: tabs.length,
          padding: const EdgeInsets.only(top: 80),
          itemBuilder: (context, index) {
            return GestureDetector(
              // key: itemKey[index],
              onTap: () {
                setState(() {
                  selectedMenu = index;
                  scrollToTab();
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 200,
                    color: Colors.black26,
                    child: Text('Item ${index + 1}')),
              ),
            );
          });
    });
  }
}
