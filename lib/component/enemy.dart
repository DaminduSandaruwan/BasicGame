import 'package:basic_game/game_controller.dart';
import 'dart:ui';

class Enemy{
  final GameController gameController;
  int health;
  int damage;
  double speed;
  Rect enemyRect;
  bool isDead = false;

  Enemy(this.gameController, double x, double y){
    health = 3;
    damage = 1;
    speed = gameController.tileSize*2;
    enemyRect = Rect.fromLTWH(
      x, 
      y, 
      gameController.tileSize * 1.2,     
      gameController.tileSize*1.2
    );
  }

  void render(Canvas c){
    Color color;
    switch (health){
      case 1:
        color = Color(0xFFFF7F7);
        break;
      case 2:
        color = Color(0xFFFF4C4C);
        break;
      case 3:
        color = Color(0xFFFF4500);
        break;
      default:
        color = Color(0xFFFF0000);
        break;
    }
    Paint enemyColor = Paint()..color=color;
    c.drawRect(enemyRect, enemyColor);

  }

  void update(double t){
    if(!isDead){
      double stepDistance = speed * t;
      Offset toPlayer = gameController.player.playerRect.center - enemyRect.center;
      if(stepDistance<= toPlayer.distance){
        Offset stepToPlayer = Offset.fromDirection(toPlayer.direction,stepDistance);
        enemyRect = enemyRect.shift(stepToPlayer);
      }
    }
  }

  void onTapDown(){
    if(!isDead){
      health--;
      if(health<=0){
        isDead=true;
        //score
      }

    }
  }
}