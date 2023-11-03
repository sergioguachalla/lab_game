import 'package:flutter/material.dart';

class Player {
  double x, y; // Coordenadas del centro del jugador
  double size; // Puede ser el radio si es un círculo

  Player({this.x = 0, required this.y, this.size = 30});

// Métodos para manipular el Player, como moverlo, podrían ir aquí
  void moveForward(double distance) {
    y += distance;
  }
}