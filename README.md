# Flutter 贪吃蛇游戏

一个使用Flutter框架开发的经典贪吃蛇游戏，支持多平台运行。

## 运行示例

![游戏演示](https://luckly007.oss-cn-beijing.aliyuncs.com/image/chip.gif)

## 项目介绍

这是一个使用Flutter开发的贪吃蛇游戏，具有简洁的界面和流畅的游戏体验。游戏实现了贪吃蛇的基本功能，包括移动、吃食物、增长身体以及碰撞检测等。

## 功能特点

- 经典贪吃蛇玩法
- 触控方向控制
- 实时分数显示
- 游戏结束提示
- 可调节游戏速度
- 随机生成食物
- 碰撞检测（边界和自身）

## 安装说明

### 前提条件

- 安装 [Flutter SDK](https://flutter.dev/docs/get-started/install)
- 配置好Flutter开发环境

### 获取代码

```bash
git clone https://gitcode.com/nutpi/flutter_snake_game.git
cd flutter_snake_game
```

### 安装依赖

```bash
flutter pub get
```

### 运行应用

```bash
flutter run
```

## 支持平台

- Android
- iOS
- Web
- macOS
- Windows
- Linux
- HarmonyOS (OHOS)

## 游戏操作

- 使用屏幕底部的方向按钮控制蛇的移动方向
- 引导蛇吃到随机出现的食物来增加分数
- 避免蛇撞到边界或自身，否则游戏结束

## 项目结构

```
lib/
├── control_button.dart  # 控制按钮组件
├── control_panel.dart   # 控制面板组件
├── direction.dart       # 方向枚举定义
├── direction_type.dart  # 方向类型定义
├── game.dart           # 游戏核心逻辑
├── main.dart           # 应用入口
└── piece.dart          # 游戏元素定义
```

## 技术栈

- Flutter
- Dart

## 贡献指南

1. Fork 项目
2. 创建功能分支 (`git checkout -b feature/amazing-feature`)
3. 提交更改 (`git commit -m 'Add some amazing feature'`)
4. 推送到分支 (`git push origin feature/amazing-feature`)
5. 创建 Pull Request

## 许可证

本项目采用 MIT 许可证 - 详情请参阅 [LICENSE](LICENSE) 文件

## 作者

坚果派 (nutpi) - [GitHub主页](https://gitcode.com/nutpi)

## 致谢

- Flutter团队提供的优秀框架
- 所有贡献者和测试者