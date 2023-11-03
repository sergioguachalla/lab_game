import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:obstacle_game/models/circle_obstacle.dart';
import 'package:obstacle_game/models/triangle_obstacle.dart';
import 'package:obstacle_game/painters/circle_obstacle_painter.dart';
import 'package:obstacle_game/painters/triangle_obstacle_painter.dart';

import '../models/obstacle.dart';
import '../models/player.dart';
import '../painters/game_painter.dart';
import '../painters/obstacle_painter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double sizeObstacle = 72;
  double x = 500,y = 850;
  Player player = Player(size: 36, x: 0, y: 0);
  Timer? _timer;
  double playerLife = 3.0;
  bool tookDamage = false;




  void startTimer(){
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {

      setState(() {

        player.moveForward(10);
        print(player.y);
      });
    });
  }

  @override
  void initState()   {
    super.initState();
    print("initState");
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _showMyDialog();
    });
    //startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Es importante cancelar el timer al desechar el widget
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    //triangle.x = size.width/2;
    List<Obstacle> obstacles = [
      Obstacle(width: sizeObstacle, height: sizeObstacle, x: size.width * 0.78, y: size.height * 0.75),  // Reducido en 0.02
      Obstacle(width: sizeObstacle, height: sizeObstacle, x: size.width * 0.38, y: size.height * 0.45),  // Reducido en 0.02
      Obstacle(width: sizeObstacle, height: sizeObstacle, x: size.width * 0.18, y: size.height * 0.25),  // Reducido en 0.02
      Obstacle(width: sizeObstacle, height: sizeObstacle, x: size.width * 0.38, y: size.height * 0.25),  // Reducido en 0.02

    ];

    List<TriangleObstacle> triangleObstacles = [
      TriangleObstacle(x: size.width * 0.18, y: size.height * 0.75, size: sizeObstacle),  // Reducido en 0.02
      TriangleObstacle(x: size.width * 0.58, y: size.height * 0.6, size: sizeObstacle),   // Reducido en 0.02
      TriangleObstacle(x: size.width * 0.78, y: size.height * 0.25, size: sizeObstacle),  // Reducido en 0.02
    ];

    List<CircleObstacle> circleObstacles = [
      CircleObstacle(x: size.width * 0.58, y: size.height * 0.75),  // Reducido en 0.02
      CircleObstacle(x: size.width * 0.18, y: size.height * 0.45),  // Reducido en 0.02
      CircleObstacle(x: size.width * 0.78, y: size.height * 0.6),   // Reducido en 0.02
    ];



    return Scaffold(
      body: Stack(
        children: [
        CustomPaint(
          painter: GamePainter(player: player,x: x,y: y),
          child: Container(),
        ),
          CustomPaint(
            painter: TrianglePainter(triangleObstacles: triangleObstacles),
            child: Container(),
          ),
          CustomPaint(
            painter: CircleObstaclePainter(circles: circleObstacles),
            child: Container(),
          ),
          CustomPaint(
            painter: ObstaclePainter(obstacles: obstacles),
            child: Container(),
          ),

          Positioned(
            top: 30,
            right: 20,
            child: Row(
              children: _buildStars(),
            ),
          ),
        ]
      ),
      bottomNavigationBar:  BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_circle_up),
              onPressed:
              (){
                if(collidingWithCircles(circleObstacles)){
                  setState(() {

                    playerLife -= circleObstacles.last.damage;
                  });
                }

                if(collidingWithTriangles(triangleObstacles)){
                  setState(() {
                    playerLife -= triangleObstacles.last.damage;
                  });
                }
                if(collidingWithObstacles(obstacles)){
                  setState(() {
                    playerLife -= obstacles.last.damage;
                  });
                }
                setState(() {
                    y-=24;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_circle_down),
              onPressed:
              (){
                if(collidingWithCircles(circleObstacles)){
                  setState(() {
                    playerLife -= circleObstacles.last.damage;
                  });
                }

                if(collidingWithTriangles(triangleObstacles)){
                  setState(() {
                    playerLife -= triangleObstacles.last.damage;
                  });
                }
                if(collidingWithObstacles(obstacles)){
                  setState(() {
                    playerLife -= obstacles.last.damage;
                  });
                }
                setState(() {
                  y+=24;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_circle_left),
              onPressed: (){
                setState(() {
                  if(collidingWithCircles(circleObstacles)){
                    setState(() {
                      playerLife -= circleObstacles.last.damage;
                    });
                  }
                  if(collidingWithTriangles(triangleObstacles)){
                    setState(() {
                      playerLife -= triangleObstacles.last.damage;
                    });
                  }
                  if(collidingWithObstacles(obstacles)){
                    setState(() {
                      playerLife -= obstacles.last.damage;
                    });
                  }

                  x -= 24;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_circle_right),
              onPressed: (){
                setState(() {
                  if(collidingWithCircles(circleObstacles)){
                    setState(() {
                      playerLife -= circleObstacles.last.damage;
                    });
                  }
                  if(collidingWithTriangles(triangleObstacles)){
                    setState(() {
                      playerLife -= triangleObstacles.last.damage;
                    });
                  }
                  if(collidingWithObstacles(obstacles)){
                    setState(() {
                      playerLife -= obstacles.last.damage;
                    });
                  }
                  x += 24;
                });
              },
            ),

          ]
        )
      ),
    );
  }

  bool isCollidingWithObstacle(Obstacle obstacle) {
    double rocketMinX = x - player.size / 2;
    double rocketMaxX = x + player.size / 2;
    double rocketMinY = y - player.size * 1.5; // Toma en cuenta la nariz
    double rocketMaxY = y + player.size / 2; // Toma en cuenta las aletas

    // Coordenadas del obstáculo
    double obstacleMinX = obstacle.x - obstacle.width / 1.8;
    double obstacleMaxX = obstacle.x + obstacle.width / 1.8;
    double obstacleMinY = obstacle.y - obstacle.height / 1.8;
    double obstacleMaxY = obstacle.y + obstacle.height / 1.8;

    if (rocketMaxX < obstacleMinX || rocketMinX > obstacleMaxX ||
        rocketMaxY < obstacleMinY || rocketMinY > obstacleMaxY) {
      return false; // No hay colisión
    }
    return true; // Hay colisión
  }


  bool isCollidingWithTriangleCircleMethod(TriangleObstacle triangle) {
    double rocketCenterX = x;
    double rocketCenterY = y;
    double rocketRadius = player.size * 1.5 / 2; // Usando la mitad de la altura del cohete

    double triangleCenterX = triangle.x;
    double triangleCenterY = triangle.y;
    double triangleRadius = triangle.size / 1.4; // Aproximadamente la mitad del tamaño del lado

    double dx = rocketCenterX - triangleCenterX;
    double dy = rocketCenterY - triangleCenterY;
    double distance = sqrt(dx * dx + dy * dy);

    // Comprobar colisión
    if (distance < rocketRadius + triangleRadius) {
      return true; // Hay colisión
    }
    return false; // No hay colisión
  }

  bool isCollidingWithCircle(CircleObstacle circle) {
    // Centro y "radio" del cohete
    double rocketCenterX = x;
    double rocketCenterY = y;
    double rocketRadius = player.size * 1.5 / 2; // Usando la mitad de la altura del cohete

    // Centro y radio del círculo
    double circleCenterX = circle.x;
    double circleCenterY = circle.y;
    double circleRadius = circle.radius;

    // Calcula la distancia entre los centros
    double dx = rocketCenterX - circleCenterX;
    double dy = rocketCenterY - circleCenterY;
    double distance = sqrt(dx * dx + dy * dy);

    // Comprobar colisión
    if (distance < rocketRadius + circleRadius) {
      return true; // Hay colisión
    }
    return false; // No hay colisión
  }

  List<Widget> _buildStars() {
    List<Widget> stars = [];
    for (int i = 1; i <= 3; i++) {
      if (playerLife >= i) {
        stars.add(Icon(Icons.star, color: Colors.yellow));
      } else if (playerLife >= i - 0.5 && playerLife < i) {
        stars.add(Icon(Icons.star_half, color: Colors.yellow));
      } else {
        stars.add(Icon(Icons.star_border, color: Colors.yellow));
      }
    }
    return stars;
  }

  bool collidingWithCircles(List<CircleObstacle> circles) {
    for (CircleObstacle circle in circles) {
      if (isCollidingWithCircle(circle)) {
        return true;
      }
    }
    return false;
  }

  bool collidingWithTriangles(List<TriangleObstacle> triangles) {
    for (TriangleObstacle triangle in triangles) {
      if (isCollidingWithTriangleCircleMethod(triangle)) {
        return true;
      }
    }
    return false;
  }

  bool collidingWithObstacles(List<Obstacle> obstacles) {
    for (Obstacle obstacle in obstacles) {
      if (isCollidingWithObstacle(obstacle)) {
        return true;
      }
    }
    return false;
  }

  _showMyDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ejemplo de cómo jugar'),
          content: Image.asset('assets/example.png'),

          actions: <Widget>[
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
                _showSecondDialog();
              },
            ),
          ],
        );
      },
    );
  }
  _showSecondDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Información sobre el juego'),
          content: Image.asset('assets/damage.png'),
          actions: <Widget>[
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el segundo diálogo
              },
            ),
          ],
        );
      },
    );
  }

}
