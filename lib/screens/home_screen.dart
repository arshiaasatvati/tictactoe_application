import 'package:flutter/material.dart';
import 'package:tictactoe_application/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isTurnO = true;
  List<String> xOrOList = ['', '', '', '', '', '', '', '', ''];
  int filledBoxes = 0;
  bool gameHasResult = false;
  int scoreX = 0;
  int scoreO = 0;
  String resultTitle = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              gameHasResult = false;
              resetGame();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
        title: Text(
          'Tic Tac Toe',
          style: TextStyle(
            color: kWhiteGrey,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: kBgGrey,
      ),
      backgroundColor: kBgGrey,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _getScoreBoard(),
          _getResultButton(),
          _getGridView(),
          _getTurn(),
        ],
      )),
    );
  }

  void tapped(int index) {
    setState(() {
      if (gameHasResult) {
        return;
      }
      if (xOrOList[index] != '') {
        return;
      }
      if (isTurnO) {
        xOrOList[index] = 'O';
        filledBoxes++;
      } else {
        xOrOList[index] = 'X';
        filledBoxes++;
      }
      isTurnO = !isTurnO;
      checkWinner();
    });
  }

  void checkWinner() {
    if (xOrOList[0] == xOrOList[1] &&
        xOrOList[0] == xOrOList[2] &&
        xOrOList[0] != '') {
      setResult(xOrOList[0], 'Winner is ' + xOrOList[0]);
      return;
    }

    if (xOrOList[3] == xOrOList[4] &&
        xOrOList[3] == xOrOList[5] &&
        xOrOList[3] != '') {
      setResult(xOrOList[3], 'Winner is ' + xOrOList[3]);
      return;
    }

    if (xOrOList[6] == xOrOList[7] &&
        xOrOList[6] == xOrOList[8] &&
        xOrOList[6] != '') {
      setResult(xOrOList[6], 'Winner is ' + xOrOList[6]);
      return;
    }
    if (xOrOList[0] == xOrOList[3] &&
        xOrOList[0] == xOrOList[6] &&
        xOrOList[0] != '') {
      setResult(xOrOList[0], 'Winner is ' + xOrOList[0]);
      return;
    }
    if (xOrOList[1] == xOrOList[4] &&
        xOrOList[1] == xOrOList[7] &&
        xOrOList[1] != '') {
      setResult(xOrOList[1], 'Winner is ' + xOrOList[1]);
      return;
    }
    if (xOrOList[2] == xOrOList[5] &&
        xOrOList[2] == xOrOList[8] &&
        xOrOList[2] != '') {
      setResult(xOrOList[2], 'Winner is ' + xOrOList[2]);
      return;
    }

    if (xOrOList[0] == xOrOList[4] &&
        xOrOList[0] == xOrOList[8] &&
        xOrOList[0] != '') {
      setResult(xOrOList[0], 'Winner is ' + xOrOList[0]);
      return;
    }

    if (xOrOList[2] == xOrOList[4] &&
        xOrOList[2] == xOrOList[6] &&
        xOrOList[2] != '') {
      setResult(xOrOList[2], 'Winner is ' + xOrOList[2]);
      return;
    }

    if (filledBoxes == 9) {
      setResult('', 'Draw');
    }
  }

  Widget _getTurn() {
    return Text(
      isTurnO ? 'Turn O' : 'Turn X',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: isTurnO ? kOColor : kXColor,
      ),
    );
  }

  Widget _getGridView() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 9,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            tapped(index);
          },
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: Center(
              child: Text(
                xOrOList[index],
                style: TextStyle(
                  fontSize: 64,
                  color: xOrOList[index] == 'X' ? kXColor : kOColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _getScoreBoard() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                'Player O',
                style: TextStyle(color: kOColor, fontSize: 20),
              ),
              SizedBox(height: 8),
              Text(
                '$scoreO',
                style: TextStyle(color: kOColor, fontSize: 20),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                'Player X',
                style: TextStyle(color: kXColor, fontSize: 20),
              ),
              SizedBox(height: 8),
              Text(
                '$scoreX',
                style: TextStyle(color: kXColor, fontSize: 20),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getResultButton() {
    return Visibility(
      visible: gameHasResult,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kBgGrey,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              width: 1,
              color: kWhiteGrey,
            ),
          ),
        ),
        onPressed: () {
          setState(() {
            gameHasResult = false;
            playAgain();
          });
        },
        child: Text(
          '$resultTitle, Play Again!',
          style: TextStyle(
            color: kWhiteGrey,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  void setResult(String winner, String title) {
    gameHasResult = true;
    resultTitle = title;
    if (winner == 'O') {
      setState(() {
        scoreO++;
      });
    } else if (winner == 'X') {
      setState(() {
        scoreX++;
      });
    } else {}
  }

  void resetGame() {
    for (int i = 0; i < xOrOList.length; i++) {
      setState(() {
        xOrOList[i] = '';
        isTurnO = true;
        scoreO = 0;
        scoreX = 0;
      });
      filledBoxes = 0;
    }
  }

  void playAgain() {
    for (int i = 0; i < xOrOList.length; i++) {
      setState(() {
        xOrOList[i] = '';
        isTurnO = true;
      });
      filledBoxes = 0;
    }
  }
}
