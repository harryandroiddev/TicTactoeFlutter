import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tictactoe/theme.dart';
import 'package:confetti/confetti.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int id = 0;

  int p1score = 0;
  int p2score = 0;

  List<String> displayelement = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
  ];

  bool isoturn = false;

  String x = 'x';

  String o = 'o';

  int filledbox = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.bgcolor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Tic Tac Toe',
                style: MyTheme.heading,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
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
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: GridView.builder(
                    itemCount: 9,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      crossAxisCount: 3,
                    ),
                    itemBuilder: ((context, index) => InkWell(
                          onTap: () {
                            print('$isoturn');
                            if (isoturn && displayelement[index] == '') {
                              setState(() {
                                displayelement[index] = o;
                                isoturn = false;
                              });
                            } else if (displayelement[index] == '') {
                              setState(() {
                                displayelement[index] = x;
                                isoturn = true;
                              });
                            }
                            filledbox++;

                            checkWinner();
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border:
                                    Border.all(color: Colors.white10, width: 3),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                              displayelement[index],
                              style: TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold,
                                  color: displayelement[index] == 'o'
                                      ? Colors.blue
                                      : Colors.red),
                            )),
                          ),
                        ))),
              ),
              TextButton(
                  onPressed: () {
                    clearboard();
                    p1score = 0;
                    p2score = 0;
                    isoturn = false;
                  },
                  child: Text(
                    'Reset',
                    style: MyTheme.body1,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  checkWinner() {
    //check row
    if (displayelement[0] == displayelement[1] &&
        displayelement[0] == displayelement[2] &&
        displayelement[0] != '') {
      showwinnerdialog(context, displayelement[0]);
    }

    if (displayelement[3] == displayelement[4] &&
        displayelement[3] == displayelement[5] &&
        displayelement[3] != '') {
      showwinnerdialog(context, displayelement[3]);
    }

    if (displayelement[6] == displayelement[7] &&
        displayelement[6] == displayelement[8] &&
        displayelement[6] != '') {
      showwinnerdialog(context, displayelement[6]);
    }

    //check column

    if (displayelement[0] == displayelement[3] &&
        displayelement[0] == displayelement[6] &&
        displayelement[0] != '') {
      showwinnerdialog(context, displayelement[0]);
    }

    if (displayelement[1] == displayelement[4] &&
        displayelement[1] == displayelement[7] &&
        displayelement[1] != '') {
      showwinnerdialog(context, displayelement[1]);
    }

    if (displayelement[2] == displayelement[5] &&
        displayelement[2] == displayelement[8] &&
        displayelement[2] != '') {
      showwinnerdialog(context, displayelement[2]);
    }

    //check diagonal

    if (displayelement[0] == displayelement[4] &&
        displayelement[0] == displayelement[8] &&
        displayelement[0] != '') {
      showwinnerdialog(context, displayelement[0]);
    }

    if (displayelement[2] == displayelement[4] &&
        displayelement[2] == displayelement[6] &&
        displayelement[2] != '') {
      showwinnerdialog(context, displayelement[2]);
    }

    if (filledbox == 9) {
      print('game draw');
      showwinnerdialog(context, "", isdraw: true);
    }
  }

  showwinnerdialog(BuildContext context, String player, {bool isdraw = false}) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text(
        "OK",
        style: MyTheme.buttontext,
      ),
      onPressed: () {
        if (player == 'x' && filledbox != 9) {
          isoturn = false;
          p2score++;
        } else if (filledbox != 9) {
          isoturn = true;
          p1score++;
        }
        clearboard();
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: MyTheme.bgcolor,
      title: Text(
        isdraw ? 'Try again' : "Congratulations",
        style: MyTheme.body1,
      ),
      content: Text(
        isdraw ? 'Game is draw' : "Player $player wins the game.",
        style: MyTheme.body1,
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  clearboard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayelement[i] = '';
      }
      filledbox = 0;
    });
  }
}

class P2Widget extends StatelessWidget {
  const P2Widget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.rotate(
          angle: 45,
          child: Container(
            height: 10,
            width: 50,
            decoration: const BoxDecoration(color: MyTheme.p2color),
          ),
        ),
        Transform.rotate(
          angle: 90,
          child: Container(
            height: 10,
            width: 50,
            decoration: const BoxDecoration(color: MyTheme.p2color),
          ),
        ),
      ],
    );
  }
}

class P1Widget extends StatelessWidget {
  const P1Widget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(color: MyTheme.p1color, width: 3)),
    );
  }
}
