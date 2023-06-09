import 'package:flutter/material.dart';
import 'package:youtube_demo/data.dart';
import 'package:timeago/timeago.dart' as timeago;

class VideoInfo extends StatelessWidget {
  final Video video;

  const VideoInfo({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            video.title,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15.0),
          ),
          const SizedBox(height: 8.0),
          Text(
            '${video.viewCount} view • ${timeago.format(video.timestamp)}',
            style: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: 14.0,
                ),
          ),
          const Divider(),
          _ActionRow(video: video),
          const Divider(),
          _AuthorInfo(user: video.author),
          const Divider(),
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  final Video video;

  const _ActionRow({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildContext(context, Icons.thumb_up_outlined, video.likes),
        _buildContext(context, Icons.thumb_down_outlined, video.dislikes),
        _buildContext(context, Icons.reply_outlined, 'Share'),
        _buildContext(context, Icons.download_outlined, 'Download'),
        _buildContext(context, Icons.library_add_outlined, 'Save'),
      ],
    );
  }
}

Widget _buildContext(BuildContext context, IconData icon, label) {
  return GestureDetector(
    onTap: () {},
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon),
      const SizedBox(height: 6.0),
      Text(
        label,
        style: Theme.of(context).textTheme.caption!.copyWith(
              color: Colors.black,
            ),
      ),
    ]),
  );
}

class _AuthorInfo extends StatelessWidget {
  final User user;

  const _AuthorInfo({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('Navigate to profile'),
      child: Row(
        children: [
          CircleAvatar(
            foregroundImage: NetworkImage(user.profileImageUrl),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    user.username,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 15.0,
                        ),
                  ),
                ),
                Flexible(
                  child: Text(
                    '${user.subscribers} subscribers',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          fontSize: 14.0,
                        ),
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'SUBSCRIBE',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.red,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
