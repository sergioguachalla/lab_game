import 'package:flutter/material.dart';
import 'package:obstacle_game/models/obstacle.dart';

class ObstaclePainter extends CustomPainter {
  List<Obstacle> obstacles;

  ObstaclePainter({required this.obstacles});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.deepPurpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

   for (Obstacle obstacle in obstacles) {
     canvas.drawRect(
         Rect.fromCenter(
             center: Offset(obstacle.x, obstacle.y),
             width: obstacle.width,
             height: obstacle.height),
         paint);
   }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
