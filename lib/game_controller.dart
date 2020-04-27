import 'dart:ui';
import 'package:basic_game/component/enemy.dart';
import 'package:basic_game/component/health_bar.dart';
import 'package:basic_game/component/player.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';

class GameController extends Game{
  Size screenSize;
  double tileSize;
  Player player;
  Enemy enemy;
  HealthBar healthBar;

  GameController(){
    initialize();
  }

  void initialize() async{ 
    resize(await Flame.util.initialDimensions());
    player = Player(this);
    enemy = Enemy(this,200,200);
    healthBar = HealthBar(this);
  }

  void render(Canvas c) {
    Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint()..color =  Color(0xFFFAFAFA);
    c.drawRect(background, backgroundPaint);
    player.render(c);
    enemy.render(c);
    healthBar.render(c);
  }

  void update(double t) {
    enemy.update(t);
    player.update(t);
    healthBar.update(t);
  }

  void resize(Size size){
    screenSize = size;
    tileSize =screenSize.width/10;
  }

  void onTapDown (TapDownDetails d){
    print(d.globalPosition);
    enemy.health--;
  }
} 