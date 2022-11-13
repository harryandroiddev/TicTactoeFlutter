import 'package:flutter/material.dart';

import '../theme.dart';

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({
    Key? key,
    required this.isoturn,
    required this.p1score,
    required this.p2score,
  }) : super(key: key);

  final bool isoturn;
  final int p1score;
  final int p2score;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              'Player 0',
              style: MyTheme.body1.copyWith(
                  color: isoturn
                      ? MyTheme.primarycolor
                      : MyTheme.disablecolor),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$p1score',
                style: MyTheme.body1,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text('Player X',
                style: MyTheme.body1.copyWith(
                  color: isoturn
                      ? MyTheme.disablecolor
                      : MyTheme.primarycolor,
                )),
            Text(
              '$p2score',
              style: MyTheme.body1,
            ),
          ],
        )
      ],
    );
  }
}