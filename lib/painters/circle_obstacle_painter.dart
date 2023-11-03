
import 'package:flutter/material.dart';

import '../models/circle_obstacle.dart';

class CircleObstaclePainter extends CustomPainter {
  List<CircleObstacle> circles;

  CircleObstaclePainter({required this.circles});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;

    for (CircleObstacle circle in circles) {
      canvas.drawCircle(Offset(circle.x, circle.y), circle.radius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
