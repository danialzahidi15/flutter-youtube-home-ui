import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:riverpod/riverpod.dart';
import 'package:youtube_demo/data.dart';
import 'package:youtube_demo/screen/home.dart';
import 'package:youtube_demo/screen/video_screen.dart';

final selectedVideoProvider = StateProvider<Video?>((ref) => null);

final miniPlayerControllerProvider = StateProvider.autoDispose<MiniplayerController>(
  (ref) => MiniplayerController(),
);

class ScreenBar extends StatefulWidget {
  const ScreenBar({Key? key}) : super(key: key);

  @override
  State<ScreenBar> createState() => _ScreenBarState();
}

class _ScreenBarState extends State<ScreenBar> {
  static const double _playerMinHeight = 60.0;

  int _selectedIndex = 0;

  final _screens = const [
    Home(),
    Scaffold(body: Center(child: Text('Short'))),
    Scaffold(body: Center(child: Text('Add'))),
    Scaffold(body: Center(child: Text('Subscription'))),
    Scaffold(body: Center(child: Text('Library'))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, watch) {
          final selectedVideo = ref.watch(selectedVideoProvider);
          final miniPlayerController = ref.watch(miniPlayerControllerProvider);
          return Stack(
            children: _screens
                .asMap()
                .map((i, screen) => MapEntry(
                      i,
                      Offstage(
                        offstage: _selectedIndex != i,
                        child: screen,
                      ),
                    ))
                .values
                .toList()
              ..add(
                Offstage(
                  offstage: selectedVideo == null,
                  child: Miniplayer(
                    controller: miniPlayerController,
                    minHeight: _playerMinHeight,
                    maxHeight: MediaQuery.of(context).size.height,
                    builder: (height, percentage) {
                      if (selectedVideo == null) return const SizedBox.shrink();

                      if (height <= _playerMinHeight + 50.0) {
                        return Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: Center(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.network(
                                      selectedVideo.thumbnailUrl,
                                      height: _playerMinHeight - 4,
                                      width: 120.0,
                                      fit: BoxFit.cover,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                selectedVideo.title,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context).textTheme.caption!.copyWith(
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black,
                                                    ),
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                selectedVideo.author.username,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context).textTheme.caption!.copyWith(
                                                      fontSize: 14.0,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon((Icons.play_arrow)),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: const Icon((Icons.close)),
                                      onPressed: () {
                                        ref.read(selectedVideoProvider.notifier).state = null;
                                      },
                                    ),
                                  ],
                                ),
                                  const LinearProgressIndicator(
                                    value: 0.4,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                                  )
                              ],
                            ),
                          ),
                        );
                      }
                      return const VideoScreen();
                    },
                  ),
                ),
              ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (i) => setState(() {
                _selectedIndex = i;
              }),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 10.0,
          unselectedFontSize: 10.0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.explore_outlined,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.explore,
                color: Colors.black,
              ),
              label: 'Short',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle_outline,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.add_circle,
                color: Colors.black,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.subscriptions_outlined,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.subscriptions,
                color: Colors.black,
              ),
              label: 'Subscription',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.video_library_outlined,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.video_library,
                color: Colors.black,
              ),
              label: 'Library',
            ),
          ]),
    );
  }
}
