/*
 * Copyright (c) 2023 坚果派 (nutpi)
 * 
 * 微信公众号: nutpi
 * 邮箱: jianguo@nutpi.net
 * 
 * 本文件定义了游戏中的控制按钮组件，用于接收用户的方向输入。
 */

import 'package:flutter/material.dart';

/// 控制按钮组件
/// 
/// 用于创建游戏中的方向控制按钮，包含图标和点击事件处理
class ControlButton extends StatelessWidget {
  /// 按钮点击事件处理函数
  final Function? onPressed;
  
  /// 按钮显示的图标
  final Icon? icon;

  /// 构造函数
  /// 
  /// @param key Widget标识键
  /// @param onPressed 点击事件回调函数
  /// @param icon 按钮图标
  const ControlButton({Key? key, this.onPressed, this.icon}) : super(key: key);

  /// 构建按钮UI
  /// 
  /// @param context 构建上下文
  /// @return 返回配置好的按钮Widget
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.5,
      child: Container(
        width: 80.0,
        height: 80.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            elevation: 0.0,
            child: this.icon,
            onPressed: this.onPressed as void Function()?,
          ),
        ),
      ),
    );
  }
}
