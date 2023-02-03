import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final int _scoreX = 0;
  final int _scoreY = 0;
  int _filledBoxes = 0;
  bool _turnofo = true;
  final List<String> xoryList = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  void onTap(int index) {
    setState(() {
      if (_turnofo && xoryList[index] == '') {
        xoryList[index] = 'Y';
        _filledBoxes += 1;
      } else if (!_turnofo && xoryList[index] == '') {
        xoryList[index] = 'X';
        _filledBoxes += 1;
      }
      _turnofo = !_turnofo;
      _checkTheWinner();
    });
  }

  final systemColor = SystemUiOverlayStyle(
      statusBarColor: Colors.grey[900],
      systemNavigationBarColor: Colors.grey[900]);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(systemColor);
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text(
          "Tic Tac Toe",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.grey[900],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text(
                    "Player X",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  Text("Score : $_scoreX",
                      style: const TextStyle(fontSize: 22, color: Colors.white))
                ],
              ),
              Column(
                children: [
                  const Text(
                    "Player Y",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  Text("Score : $_scoreY",
                      style:
                          const TextStyle(fontSize: 22, color: Colors.white)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 25),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      onTap(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0.0),
                          color: Colors.white),
                      child: Center(
                        child: Text(
                          xoryList[index],
                          style: TextStyle(
                              fontSize: 60,fontWeight: FontWeight.bold,
                              color: xoryList[index] == 'x'
                                  ? Colors.white
                                  : Colors.red),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          _buildTurn(),
          const SizedBox(height: 5),
          Container(
            height: 55,
            margin: const EdgeInsets.all(8.0),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0), color: Colors.white),
            child: TextButton(
              onPressed: () {
                _clearBoard();
              },
              child: Text(
                "Reset",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[900],
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _checkTheWinner() {
    // check first row
    if (xoryList[0] == xoryList[1] &&
        xoryList[0] == xoryList[2] &&
        xoryList[0] != '') {
      // showAlertDialog('Winner', xoryList[0]);
      return;
    }

    // check second row
    if (xoryList[3] == xoryList[4] &&
        xoryList[3] == xoryList[5] &&
        xoryList[3] != '') {
      // showAlertDialog('Winner', xoryList[3]);
      return;
    }

    // check third row
    if (xoryList[6] == xoryList[7] &&
        xoryList[6] == xoryList[8] &&
        xoryList[6] != '') {
      // showAlertDialog('Winner', xoryList[6]);
      return;
    }

    // check first column
    if (xoryList[0] == xoryList[3] &&
        xoryList[0] == xoryList[6] &&
        xoryList[0] != '') {
      // showAlertDialog('Winner', xoryList[0]);
      return;
    }

    // check second column
    if (xoryList[1] == xoryList[4] &&
        xoryList[1] == xoryList[7] &&
        xoryList[1] != '') {
      // showAlertDialog('Winner', xoryList[1]);
      return;
    }

    // check third column
    if (xoryList[2] == xoryList[5] &&
        xoryList[2] == xoryList[8] &&
        xoryList[2] != '') {
      // showAlertDialog('Winner', xoryList[2]);
      return;
    }

    // check diagonal
    if (xoryList[0] == xoryList[4] &&
        xoryList[0] == xoryList[8] &&
        xoryList[0] != '') {
      // showAlertDialog('Winner', xoryList[0]);
      return;
    }

    // check diagonal
    if (xoryList[2] == xoryList[4] &&
        xoryList[2] == xoryList[6] &&
        xoryList[2] != '') {
      // showAlertDialog('Winner', xoryList[2]);
      return;
    }

    if (_filledBoxes == 9) {
      // showAlertDialog('Draw', '');
    }
  }

  Widget _buildTurn() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Center(
        child: Text(
          _turnofo ? ' ---Turn of Y---' : '---Turn of X---',
          style: const TextStyle(color: Colors.white,fontSize: 28),
        ),
      ),
    );
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        xoryList[i] = '';
      }
    });

    _filledBoxes = 0;
  }
}
