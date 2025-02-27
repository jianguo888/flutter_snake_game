/*
 * Copyright (c) 2023 坚果派 (nutpi)
 * 
 * 微信公众号: nutpi
 * 邮箱: jianguo@nutpi.net
 * 
 * 本文件包含游戏的核心逻辑，负责处理游戏状态、蛇的移动、碰撞检测等功能。
 */

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'control_panel.dart';
import 'direction.dart';
import 'direction_type.dart';
import 'piece.dart';

/// 游戏页面组件
/// 
/// 游戏的主界面，包含游戏区域和控制面板
class GamePage extends StatefulWidget {
  /// 创建游戏页面状态
  /// 
  /// @return 返回游戏页面状态实例
  @override
  _GamePageState createState() => _GamePageState();
}

/// 游戏页面状态类
/// 
/// 管理游戏的状态和逻辑，包括蛇的移动、食物生成、碰撞检测等
class _GamePageState extends State<GamePage> {
  /// 蛇身体各部分的位置列表
  List<Offset?> positions = [];
  
  /// 蛇的长度
  int length = 5;
  
  /// 移动步长
  int step = 20;
  
  /// 当前移动方向
  Direction direction = Direction.right;

  /// 食物组件
  late Piece food;
  
  /// 食物位置
  Offset? foodPosition;

  /// 屏幕宽度
  late double screenWidth;
  
  /// 屏幕高度
  late double screenHeight;
  
  /// 游戏区域边界
  late int lowerBoundX, upperBoundX, lowerBoundY, upperBoundY;

  /// 游戏计时器
  Timer? timer;
  
  /// 游戏速度
  double speed = 1;

  /// 游戏得分
  int score = 0;

  /// 绘制蛇
  /// 
  /// 计算蛇的每个部分的新位置
  void draw() async {
    if (positions.length == 0) {
      positions.add(getRandomPositionWithinRange());
    }

    while (length > positions.length) {
      positions.add(positions[positions.length - 1]);
    }

    for (int i = positions.length - 1; i > 0; i--) {
      positions[i] = positions[i - 1];
    }
    positions[0] = await getNextPosition(positions[0]!);
  }

  /// 获取随机方向
  /// 
  /// @param type 方向类型，可选参数
  /// @return 返回随机生成的方向
  Direction getRandomDirection([DirectionType? type]) {
    if (type == DirectionType.horizontal) {
      bool random = Random().nextBool();
      if (random) {
        return Direction.right;
      } else {
        return Direction.left;
      }
    } else if (type == DirectionType.vertical) {
      bool random = Random().nextBool();
      if (random) {
        return Direction.up;
      } else {
        return Direction.down;
      }
    } else {
      int random = Random().nextInt(4);
      return Direction.values[random];
    }
  }

  /// 获取游戏区域内的随机位置
  /// 
  /// @return 返回随机生成的位置坐标
  Offset getRandomPositionWithinRange() {
    int posX = Random().nextInt(upperBoundX) + lowerBoundX;
    int posY = Random().nextInt(upperBoundY) + lowerBoundY;
    return Offset(roundToNearestTens(posX).toDouble(),
        roundToNearestTens(posY).toDouble());
  }

  /// 检测碰撞
  /// 
  /// 检查蛇是否碰到边界
  /// @param position 要检查的位置
  /// @return 如果发生碰撞返回true，否则返回false
  bool detectCollision(Offset position) {
    if (position.dx >= upperBoundX && direction == Direction.right) {
      return true;
    } else if (position.dx <= lowerBoundX && direction == Direction.left) {
      return true;
    } else if (position.dy >= upperBoundY && direction == Direction.down) {
      return true;
    } else if (position.dy <= lowerBoundY && direction == Direction.up) {
      return true;
    }

    return false;
  }

  /// 显示游戏结束对话框
  /// 
  /// 当游戏结束时显示分数和重新开始选项
  void showGameOverDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.black,
                width: 3.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            "游戏结束",
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            "游戏结束，但你玩得很好,你的分数是 " + score.toString() + ".",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                restart();
              },
              child: Text(
                "重新开始",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  /// 获取下一个位置
  /// 
  /// 根据当前方向计算蛇头的下一个位置
  /// @param position 当前位置
  /// @return 返回计算出的下一个位置
  Future<Offset?> getNextPosition(Offset position) async {
    Offset? nextPosition;

    if (detectCollision(position) == true) {
      if (timer != null && timer!.isActive) timer!.cancel();
      await Future.delayed(
          Duration(milliseconds: 500), () => showGameOverDialog());
      return position;
    }

    if (direction == Direction.right) {
      nextPosition = Offset(position.dx + step, position.dy);
    } else if (direction == Direction.left) {
      nextPosition = Offset(position.dx - step, position.dy);
    } else if (direction == Direction.up) {
      nextPosition = Offset(position.dx, position.dy - step);
    } else if (direction == Direction.down) {
      nextPosition = Offset(position.dx, position.dy + step);
    }

    return nextPosition;
  }

  /// 绘制食物
  /// 
  /// 在随机位置生成食物，并处理蛇吃到食物的逻辑
  void drawFood() {
    if (foodPosition == null) {
      foodPosition = getRandomPositionWithinRange();
    }

    if (foodPosition == positions[0]) {
      length++;
      speed = speed + 0.25;
      score = score + 5;
      changeSpeed();

      foodPosition = getRandomPositionWithinRange();
    }

    food = Piece(
      posX: foodPosition!.dx.toInt(),
      posY: foodPosition!.dy.toInt(),
      size: step,
      color: Color(0XFF8EA604),
      isAnimated: true,
    );
  }

  /// 获取所有游戏元素
  /// 
  /// 生成蛇身体的所有部分
  /// @return 返回蛇身体各部分的组件列表
  List<Piece> getPieces() {
    List<Piece> pieces = [];
    draw();
    drawFood();

    for (int i = 0; i < length; ++i) {
      if (i >= positions.length) {
        continue;
      }

      pieces.add(
        Piece(
          posX: positions[i]!.dx.toInt(),
          posY: positions[i]!.dy.toInt(),
          size: step,
          color: Colors.red,
        ),
      );
    }

    return pieces;
  }

  /// 获取控制面板
  /// 
  /// 创建方向控制按钮面板
  /// @return 返回控制面板组件
  Widget getControls() {
    return ControlPanel(
      onTapped: (Direction newDirection) {
        direction = newDirection;
      },
    );
  }

  /// 将数字四舍五入到最接近的步长倍数
  /// 
  /// 用于确保位置对齐到网格
  /// @param num 要四舍五入的数字
  /// @return 返回四舍五入后的数字
  int roundToNearestTens(int num) {
    int divisor = step;
    int output = (num ~/ divisor) * divisor;
    if (output == 0) {
      output += step;
    }
    return output;
  }

  /// 改变游戏速度
  /// 
  /// 根据当前速度设置计时器间隔
  void changeSpeed() {
    if (timer != null && timer!.isActive) timer!.cancel();

    // if you want timer to tick at fixed duration.
    timer = Timer.periodic(Duration(milliseconds: 200 ~/ speed), (timer) {
      setState(() {});
    });
  }

  /// 获取分数显示组件
  /// 
  /// 创建显示当前分数的文本组件
  /// @return 返回分数显示组件
  Widget getScore() {
    return Positioned(
      top: 50.0,
      right: 40.0,
      child: Text(
        "积分: " + score.toString(),
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }

  /// 重新开始游戏
  /// 
  /// 重置所有游戏状态到初始值
  void restart() {
    score = 0;
    length = 5;
    positions = [];
    direction = getRandomDirection();
    speed = 1;
    changeSpeed();
  }

  /// 获取游戏区域边框
  /// 
  /// 创建游戏区域的边界显示
  /// @return 返回边框组件
  Widget getPlayAreaBorder() {
    return Positioned(
      top: lowerBoundY.toDouble(),
      left: lowerBoundX.toDouble(),
      child: Container(
        width: (upperBoundX - lowerBoundX + step).toDouble(),
        height: (upperBoundY - lowerBoundY + step).toDouble(),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black.withOpacity(0.2),
            style: BorderStyle.solid,
            width: 1.0,
          ),
        ),
      ),
    );
  }

  /// 初始化状态
  /// 
  /// 在组件首次创建时调用，初始化游戏
  @override
  void initState() {
    super.initState();

    restart();
  }

  /// 构建游戏UI
  /// 
  /// @param context 构建上下文
  /// @return 返回配置好的游戏界面
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    lowerBoundX = step;
    lowerBoundY = step;
    upperBoundX = roundToNearestTens(screenWidth.toInt() - step);
    upperBoundY = roundToNearestTens(screenHeight.toInt() - step);

    return Scaffold(
      body: Container(
        color: Color(0XFFF5BB00),
        child: Stack(
          children: [
            getPlayAreaBorder(),
            Container(
              child: Stack(
                children: getPieces(),
              ),
            ),
            food,
            getControls(),
            getScore(),
          ],
        ),
      ),
    );
  }
}
