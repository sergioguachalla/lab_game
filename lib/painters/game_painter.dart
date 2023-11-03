import 'package:flutter/material.dart';

import '../models/obstacle.dart';
import '../models/player.dart';

class GamePainter extends CustomPainter {
  Player player;
  double x, y;

  GamePainter({required this.player, required this.x, required this.y});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.fill;



    double rocketCenterX = x;
    double rocketCenterY = y;

    Path bodyPath = Path();
    double bodyWidth = player.size * 1.3;
    double bodyHeight = player.size * 1.4; // Reduzco la altura del cuerpo para dejar espacio para la punta.

    bodyPath.addRect(Rect.fromLTWH(rocketCenterX - bodyWidth / 2, rocketCenterY - bodyHeight / 2 + bodyWidth / 2, bodyWidth, bodyHeight));

    Path nosePath = Path();
    nosePath.moveTo(rocketCenterX, rocketCenterY - bodyHeight); // Punto superior
    nosePath.lineTo(rocketCenterX - bodyWidth / 2, rocketCenterY - bodyHeight / 2 + bodyWidth / 2); // Esquina inferior izquierda
    nosePath.lineTo(rocketCenterX + bodyWidth / 2, rocketCenterY - bodyHeight / 2 + bodyWidth / 2); // Esquina inferior derecha
    nosePath.close();

    double finWidth = bodyWidth / 2;
    double finHeight = bodyWidth / 3;

    Path finPath = Path();
    finPath.moveTo(rocketCenterX - bodyWidth / 2, rocketCenterY + bodyHeight / 2 - finHeight);
    finPath.lineTo(rocketCenterX - bodyWidth / 2 - finWidth, rocketCenterY + bodyHeight / 2);
    finPath.lineTo(rocketCenterX - bodyWidth / 2, rocketCenterY + bodyHeight / 2);
    finPath.close();

    finPath.moveTo(rocketCenterX + bodyWidth / 2, rocketCenterY + bodyHeight / 2 - finHeight);
    finPath.lineTo(rocketCenterX + bodyWidth / 2 + finWidth, rocketCenterY + bodyHeight / 2);
    finPath.lineTo(rocketCenterX + bodyWidth / 2, rocketCenterY +  bodyHeight / 2);
    finPath.close();

    canvas.drawPath(bodyPath, paint);
    canvas.drawPath(nosePath, paint);
    canvas.drawPath(finPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  moveForward(double distance) {
    y += distance;
  }



}
