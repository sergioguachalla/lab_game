import 'package:flutter/material.dart';

class Obstacle{
  final double width;  // ancho del obstáculo
  final double height; // alto del obstáculo
  double x;  // posición x (horizontal)
  double y;  // posición y (vertical)
  double damage = 1.0; // daño que hace el obstáculo
  Obstacle({
    required this.width,
    required this.height,
    required this.x,
    required this.y,

  });
}