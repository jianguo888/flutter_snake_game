/*
 * Copyright (c) 2023 坚果派 (nutpi)
 * 
 * 微信公众号: nutpi
 * 邮箱: jianguo@nutpi.net
 * 
 * 本文件定义了游戏中的基本元素组件，用于显示蛇身和食物。
 */

import 'package:flutter/material.dart';

/// 游戏元素组件
/// 
/// 用于创建游戏中的视觉元素，如蛇身体的各个部分和食物
class Piece extends StatefulWidget {
  /// X坐标位置
  final int? posX;
  
  /// Y坐标位置
  final int? posY;
  
  /// 元素大小
  final int? size;
  
  /// 元素颜色
  final Color color;
  
  /// 是否启用动画效果
  final bool isAnimated;

  /// 构造函数
  /// 
  /// @param key Widget标识键
  /// @param posX X坐标位置
  /// @param posY Y坐标位置
  /// @param size 元素大小
  /// @param color 元素颜色，默认为橙红色
  /// @param isAnimated 是否启用动画效果，默认为false
  const Piece({Key? key, this.posX, this.posY, this.size, this.color = const Color(0XFFBF3100), this.isAnimated = false}) : super(key: key);

  /// 创建元素状态
  /// 
  /// @return 返回元素状态实例
  @override
  _PieceState createState() => _PieceState();
}

/// 游戏元素状态类
/// 
/// 管理游戏元素的状态和动画效果
class _PieceState extends State<Piece> with SingleTickerProviderStateMixin {
  /// 动画控制器
  late AnimationController _animationController;

  /// 初始化状态
  /// 
  /// 设置动画控制器并启动动画
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      lowerBound: 0.25,
      upperBound: 1.0,
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reset();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });

    _animationController.forward();
  }

  /// 释放资源
  /// 
  /// 释放动画控制器资源
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// 构建元素UI
  /// 
  /// @param context 构建上下文
  /// @return 返回配置好的元素Widget
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.posX!.toDouble(),
      top: widget.posY!.toDouble(),
      child: Opacity(
        opacity: widget.isAnimated ? _animationController.value : 1.0,
        child: Container(
          width: widget.size!.toDouble(),
          height: widget.size!.toDouble(),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.all(
              Radius.circular(
                widget.size!.toDouble(),
              ),
            ),
            border: Border.all(color: Colors.black, width: 2.0),
          ),
        ),
      ),
    );
  }
}
