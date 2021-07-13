import 'package:flutter/material.dart';
import 'package:knapsack/knapsack-code.dart';
import 'package:knapsack/utils/divider.dart';
import 'package:knapsack/utils/title.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> weights = <int>[];
  List<int> values = <int>[];
  int capacity = 0;

  final wtController = TextEditingController();
  final valController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    valController.dispose();
    wtController.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showInSnackBar(
    String value,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(value), backgroundColor: Colors.red[600]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: MyTitle(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 300,
                          child: Text(
                            "Enter the Maximum capacity for the knapsack: ",
                            style: TextStyle(fontSize: 20),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          child: TextField(
                            cursorHeight: 30,
                            style: TextStyle(fontSize: 22),
                            keyboardType: TextInputType.number,
                            decoration: new InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (txt) {
                              setState(() {
                                if (txt != "") {
                                  setState(() {
                                    capacity = int.parse(txt);
                                    print(capacity);
                                  });
                                } else {
                                  showInSnackBar("Capacity cannot be null");
                                }
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Divide(),
                  Container(
                      child: (values.isNotEmpty && weights.isNotEmpty)
                          ? ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: weights.length,
                              itemBuilder: (context, index) {
                                final weight = weights[index];
                                final value = values[index];
                                return Dismissible(
                                  key: Key(weights[index].toString()),
                                  direction: DismissDirection.startToEnd,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(15.0),
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 10, 30, 10),
                                        decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                          weight.toString(),
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_right_alt,
                                        size: 30,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.all(15.0),
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 10, 30, 10),
                                        decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                          value.toString(),
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              weights.removeAt(index);
                                              values.removeAt(index);
                                            });
                                          },
                                          child: Text(
                                            "Remove",
                                            style: TextStyle(
                                                color: Colors.red[600],
                                                fontSize: 16),
                                          ))
                                    ],
                                  ),
                                  onDismissed: (direction) {
                                    setState(() {
                                      weights.removeAt(index);
                                      values.removeAt(index);
                                    });
                                  },
                                );
                              },
                            )
                          : Column(
                              children: [
                                Container(
                                    child: Icon(
                                  Icons.info_outline,
                                  color: Colors.grey,
                                  size: 150,
                                )),
                                Container(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        "Provide some weights and values",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.grey)),
                                  ),
                                ),
                              ],
                            )),

                  //Inputs method extracted
                  UserInput(context),

                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (capacity == 0)
                          showInSnackBar("Capacity cannot be null");
                        if (weights.isEmpty && values.isEmpty)
                          showInSnackBar("Please provide some inputs");
                        else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Knapsack(
                                    weights: weights,
                                    values: values,
                                    capacity: capacity,
                                    len: weights.length,
                                  )));
                        }
                      },
                      child: Text("Solve"),
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xffFFA200),
                          onPrimary: Colors.white,
                          shadowColor: Colors.red,
                          elevation: 5,
                          textStyle: TextStyle(fontSize: 20)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Align UserInput(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 28),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 4,
              child: TextField(
                controller: wtController,
                cursorHeight: 30,
                style: TextStyle(fontSize: 22),
                keyboardType: TextInputType.number,
                onSubmitted: (txt) {
                  setState(() {
                    if (wtController.text != "" && valController.text != "") {
                      weights.add(int.parse(wtController.text));
                      values.add(int.parse(valController.text));
                    } else {
                      showInSnackBar("Please enter valid Weights and Values");
                    }
                  });
                  wtController.clear();
                  valController.clear();
                },
                decoration: new InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "weight",
                ),
              ),
            ),
            Icon(
              Icons.arrow_right_alt,
              size: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 4,
              child: TextField(
                controller: valController,
                cursorHeight: 30,
                style: TextStyle(fontSize: 22),
                keyboardType: TextInputType.number,
                onSubmitted: (txt) {
                  setState(() {
                    if (wtController.text != "" && valController.text != "") {
                      weights.add(int.parse(wtController.text));
                      values.add(int.parse(valController.text));
                    } else {
                      showInSnackBar("Please enter correct weights and values");
                    }
                  });
                  wtController.clear();
                  valController.clear();
                },
                decoration: new InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "value",
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (wtController.text != "" && valController.text != "") {
                    weights.add(int.parse(wtController.text));
                    values.add(int.parse(valController.text));
                  } else {
                    showInSnackBar("Please enter correct weights and values");
                  }
                });
                wtController.clear();
                valController.clear();
              },
              child: Text(
                "Add",
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
                onPrimary: Colors.white,
                shadowColor: Colors.red,
                elevation: 5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
