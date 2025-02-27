/*
 * Copyright (c) 2023 坚果派 (nutpi)
 * 
 * 微信公众号: nutpi
 * 邮箱: jianguo@nutpi.net
 * 
 * 本文件是贪吃蛇游戏的入口文件，负责初始化应用程序并设置主题。
 */

import 'package:flutter/material.dart';

import 'game.dart';

/// 应用程序入口函数
/// 
/// 启动Flutter应用并运行MyApp组件
void main() {
  runApp(MyApp());
}

/// 应用程序主组件
/// 
/// 定义应用程序的主题和初始页面
class MyApp extends StatelessWidget {
  /// 构建应用程序UI
  /// 
  /// @param context 构建上下文
  /// @return 返回配置好的MaterialApp实例
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Snake', // 应用标题
      debugShowCheckedModeBanner: false, // 隐藏调试标签
      theme: ThemeData(
        primarySwatch: Colors.blue, // 主题颜色
        visualDensity: VisualDensity.adaptivePlatformDensity, // 视觉密度自适应
      ),
      home: GamePage(), // 设置游戏页面为首页
    );
  }
}
