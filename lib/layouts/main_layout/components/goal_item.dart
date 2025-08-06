import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

Widget goalItem(id, goalName) => Container(
  height: 80,
  margin: const EdgeInsets.all(10),
  decoration: BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3),
      ),
    ],
    gradient: LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [Colors.black, Colors.grey],
    ),
  ),
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Icon(Icons.check, color: Colors.green),
        Text(
          '${id} : ${goalName}',
          style: TextStyle(color: Colors.white, fontSize: 24),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          maxLines: 1,
        ),
      ],
    ),
  ),
);
