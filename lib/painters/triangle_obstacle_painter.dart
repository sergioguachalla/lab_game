import 'package:flutter/material.dart';
import '../models/triangle_obstacle.dart';

class TrianglePainter extends CustomPainter {
  List<TriangleObstacle> triangleObstacles;

  TrianglePainter({required this.triangleObstacles});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red // Puedes cambiar este color si lo deseas
      ..style = PaintingStyle.fill;

    for (var triangleObstacle in triangleObstacles) {
      final double centerX = triangleObstacle.x;
      final double centerY = triangleObstacle.y;
      final double halfSize = triangleObstacle.size / 2;

      // Creando el path para el triángulo
      Path trianglePath = Path();
      trianglePath.moveTo(centerX, centerY - halfSize); // Punto superior
      trianglePath.lineTo(centerX - halfSize, centerY + halfSize); // Esquina inferior izquierda
      trianglePath.lineTo(centerX + halfSize, centerY + halfSize); // Esquina inferior derecha
      trianglePath.close(); // Cierra el path conectando el último punto con el primero

      canvas.drawPath(trianglePath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
