import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:youtube_demo/data.dart';
import 'package:youtube_demo/screen/screen_bar.dart';
import 'package:youtube_demo/widget/widgets.dart';

class VideoScreen extends ConsumerStatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends ConsumerState<VideoScreen> {
  ScrollController? _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ref.read(miniPlayerControllerProvider.notifier).state.animateToHeight(
            state: PanelState.MAX,
          ),
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Consumer(builder: (context, ref, watch) {
                final selectedVideo = ref.watch(selectedVideoProvider.notifier).state;
                return SafeArea(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Image.network(
                            selectedVideo!.thumbnailUrl,
                            height: 220.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              size: 30.0,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              ref.read(miniPlayerControllerProvider.notifier).state.animateToHeight(
                                    state: PanelState.MIN,
                                  );
                            },
                          ),
                        ],
                      ),
                      const LinearProgressIndicator(
                        value: 0.4,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                      VideoInfo(video: selectedVideo),
                    ],
                  ),
                );
              }),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (context, index) {
                final video = suggestedVideos[index];
                return VideoCard(
                  video: video,
                  hasPadding: true,
                  onTap: () => _scrollController!.animateTo(
                    0,
                    duration: const Duration(microseconds: 200),
                    curve: Curves.easeIn,
                  ),
                );
              },
              childCount: suggestedVideos.length,
            ))
          ],
        ),
      ),
    );
  }
}
