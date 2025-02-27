/*
 * Copyright (c) 2023 坚果派 (nutpi)
 * 
 * 微信公众号: nutpi
 * 邮箱: jianguo@nutpi.net
 * 
 * 本文件定义了游戏中的控制面板组件，用于布局方向控制按钮。
 */

import 'package:flutter/material.dart';

import 'control_button.dart';
import 'direction.dart';

/// 控制面板组件
/// 
/// 用于创建游戏中的方向控制面板，包含上下左右四个方向按钮
class ControlPanel extends StatelessWidget {
  /// 方向按钮点击回调函数
  /// 当用户点击方向按钮时，通过此回调函数通知游戏改变蛇的移动方向
  final void Function(Direction direction)? onTapped;

  /// 构造函数
  /// 
  /// @param key Widget标识键
  /// @param onTapped 方向按钮点击回调函数
  const ControlPanel({Key? key, this.onTapped}) : super(key: key);

  /// 构建控制面板UI
  /// 
  /// @param context 构建上下文
  /// @return 返回配置好的控制面板Widget
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(),
                ),
                ControlButton(
                  icon: Icon(Icons.arrow_left),
                  onPressed: () {
                    onTapped!(Direction.left);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                ControlButton(
                  icon: Icon(Icons.arrow_drop_up_sharp),
                  onPressed: () {
                    onTapped!(Direction.up);
                  },
                ),
                SizedBox(
                  height: 75.0,
                ),
                ControlButton(
                  icon: Icon(Icons.arrow_drop_down_sharp),
                  onPressed: () {
                    onTapped!(Direction.down);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                ControlButton(
                  icon: Icon(Icons.arrow_right),
                  onPressed: () {
                    onTapped!(Direction.right);
                  },
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
