import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Knapsack extends StatefulWidget {
  final List<int> weights;
  final List<int> values;
  final int capacity;
  final int len;
  const Knapsack(
      {Key? key,
      required this.weights,
      required this.values,
      required this.capacity,
      required this.len})
      : super(key: key);

  @override
  _KnapsackState createState() => _KnapsackState();
}

class _KnapsackState extends State<Knapsack> {
  //program for knapsack
  int max(int a, int b) {
    return (a > b) ? a : b;
  }

  int knapSack(List<int> wt, List<int> val, int cap, int size) {
    //if capicity is zero
    if (size == 0 || cap == 0) return 0;

    //if weight exceeds the capacity then it cannot bre added
    if (wt[size - 1] > cap)
      return knapSack(wt, val, cap, size - 1);

    //else taking the max of (if the element is taken or not)
    else
      return max(
          val[size - 1] + knapSack(wt, val, cap - wt[size - 1], size - 1),
          knapSack(wt, val, cap, size - 1));
  }

  int findMaxWeight(List<int> arr, int n, int sum) {
    int curr_sum = arr[0], max_sum = 0, start = 0;
    for (int i = 1; i < n; i++) {
      if (curr_sum <= sum) max_sum = max(max_sum, curr_sum);

      // If curr_sum becomes greater than
      // sum subtract starting elements of array
      while (curr_sum + arr[i] > sum && start < i) {
        curr_sum -= arr[start];
        start++;
      }
      // Add elements to curr_sum
      curr_sum += arr[i];
    }
    // Adding an extra check
    if (curr_sum <= sum) max_sum = max(max_sum, curr_sum);
    return max_sum;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget _title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              size: 35,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            "Result for Knapsack",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32, color: Colors.black),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var result =
        knapSack(widget.weights, widget.values, widget.capacity, widget.len);
    var sumWeight = findMaxWeight(widget.weights, widget.len, widget.capacity);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: _title(),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: RichText(
              text: TextSpan(
                  text: 'Total value of Items stored in Knapsack: ',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: '$result',
                      style: TextStyle(
                          color: Color(0xffFFA200),
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: CircularPercentIndicator(
              radius: 200.0,
              lineWidth: 20.0,
              animation: true,
              percent: sumWeight / widget.capacity,
              center: Text(
                "${(sumWeight / widget.capacity) * 100}%",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
              ),
              footer: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Knapsack Weight utilization",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                ),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Color(0xffFFA200),
            ),
          ),
        ],
      ),
    );
  }
}
