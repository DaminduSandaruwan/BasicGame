import 'dart:math';
import 'dart:ui';
import 'package:basic_game/component/enemy.dart';
import 'package:basic_game/component/health_bar.dart';
import 'package:basic_game/component/highscore_text.dart';
import 'package:basic_game/component/player.dart';
import 'package:basic_game/component/score_text.dart';
import 'package:basic_game/enemy_spawner.dart';
import 'package:basic_game/state.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameController extends Game{
  final SharedPreferences storage;
  Random rand;
  Size screenSize;
  double tileSize;
  Player player;
  EnemySpawner enemySpawner;
  List<Enemy> enemies;
  HealthBar healthBar;
  int score;
  ScoreText scoreText;
  States state;
  HighscoreText highscoreText;

  GameController(this.storage){
    initialize();
  }

  void initialize() async{ 
    resize(await Flame.util.initialDimensions());
    state = States.menu;
    rand = Random();
    player = Player(this);    
    enemies = List<Enemy>();
    enemySpawner = EnemySpawner(this);
    healthBar = HealthBar(this);
    score = 0;
    scoreText =ScoreText(this);
    highscoreText = HighscoreText(this);
    //spawnEnemy();
  }

  void render(Canvas c) {
    Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint()..color =  Color(0xFFFAFAFA);
    c.drawRect(background, backgroundPaint);
    player.render(c);

    if(state==States.menu){
      //startButton.render(c);
      highscoreText.render(c);
    }
    else if(state == States.playing){
      enemies.forEach((Enemy enemy)=>enemy.render(c));
      scoreText.render(c);
      healthBar.render(c);
    }    
  }

  void update(double t) {
    if(state == States.menu){
      //startButton.update(t);
      highscoreText.update(t); 

    } else if(state==States.playing){
      enemySpawner.update(t);
      enemies.forEach((Enemy enemy)=>enemy.update(t));
      enemies.removeWhere((Enemy enemy)=>enemy.isDead);
      player.update(t);
      scoreText.update(t);
      healthBar.update(t);
    }  
  }

  void resize(Size size){
    screenSize = size;
    tileSize =screenSize.width/10;
  }

  void onTapDown (TapDownDetails d){
    //print(d.globalPosition);
    if(state == States.menu){
      state = States.playing;
    } else if(state == States.playing){
      enemies.forEach((Enemy enemy){
        if(enemy.enemyRect.contains(d.globalPosition)){
          enemy.onTapDown();
        }
      });
    }
  }

  void spawnEnemy(){
    double x,y; 
    switch (rand.nextInt(4)){
      case 0: 
        //top
        x = rand.nextDouble() * screenSize.width;
        y = -tileSize*2.5;
        break;
      case 1:
        //right
        x = screenSize.width + tileSize*2.5;
        y = rand.nextDouble() * screenSize.height;
        break;
      case 2:
        //bottom
        x = rand.nextDouble() * screenSize.width;
        y = screenSize.height + tileSize *  2.5;
        break;
      case 3:
        //left
        x = -tileSize * 2.5;
        y = rand.nextDouble() * screenSize.height;
        break;

    }
    enemies.add(Enemy(this,x,y));
  }
} 