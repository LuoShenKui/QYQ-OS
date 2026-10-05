# QYQ OS

**QiYinQiao Operating System**

中文 | [English](./README.md)

QYQ OS 是一个面向 Agent 时代的个人智能操作系统。

项目基于 Linux 和 Debian 生态构建，在成熟的系统基础设施之上加入：

- Main Model
- Specialized Models
- Task Runtime
- Agent Runtime
- Memory Service
- Context Broker
- Permission Broker
- System API
- System Ledger

目标是让计算机能够理解用户意图、执行任务、保存长期记忆、理解系统状态，并让重要行为始终可追踪、可解释。

> **Local First · Memory Sovereignty · Agent Native · User Controlled**

详细愿景见：[VISION.md](./VISION.md)

## 核心思路

用户应该描述“想完成什么”，而不是亲自完成大量机械操作。

例如：

```text
安装 Blender
```

系统负责完成：

```text
搜索
↓
查询
↓
选择可信来源
↓
下载
↓
校验
↓
安全检查
↓
安装
↓
验证
↓
记录
```

QYQ OS 将逐步把这些能力做成操作系统级能力。

AI 模型运行于用户空间。

QYQ OS 计划采用：

```text
一个 Main Model
+
多个 Specialized Models
```

专用模型可以负责：

- 翻译
- 语音识别
- TTS
- Vision
- Coding
- Embedding
- OCR
- Classification

用户长期 Memory 属于操作系统和用户本身。

闭源模型和云模型不能自由读取用户 Memory，只能获得当前任务所需的最小必要上下文。

QYQ OS 同时维护 System Ledger，用于记录：

- 谁执行了操作
- 做了什么
- 为什么执行
- 使用了什么权限
- 数据来自哪里
- 是否向外部发送数据
- 最终结果

## 当前技术方向

初期技术底座：

```text
Linux Kernel
Debian Stable / LTS
systemd
glibc
APT / dpkg
Wayland
Mesa
PipeWire
NetworkManager
D-Bus
polkit
```

QYQ OS 优先复用成熟 Linux 基础设施，把主要开发工作集中在新的智能系统层。

# 路线图

## 0.0.1 — 跑起来 QYQ OS

版本基线：[docs/0.0.1-BASELINE.md](./docs/0.0.1-BASELINE.md)

第一步很简单：

> **先让 QYQ OS 真正启动并运行。**

0.0.1 的目标：

- 基于 Debian Stable / LTS
- 生成 QYQ OS 系统镜像
- 可以在 QEMU / 虚拟机中启动
- 网络可用
- APT 可用
- systemd 正常工作
- 加入 QYQ OS branding
- 建立 QYQ OS 自有软件仓库基础
- 为后续 Agent Runtime 和系统服务预留清晰结构

0.0.1 的意义，是先建立一个可重复构建、可以启动、可以继续开发的 QYQ OS 基础系统。

## 下一步 — 自主下载与安装

0.0.1 跑通后，第一项 Agent-native 系统能力是：

> **自主搜索、查询、下载、安全检查和安装。**

例如用户输入：

```text
安装 Blender
```

QYQ OS 自动执行：

```text
Resolve Software
↓
Search Sources
↓
Select Trusted Source
↓
Download
↓
Verify Signature / Hash
↓
Security Scan
↓
Permission Check
↓
Install
↓
Verify Installation
↓
Write System Ledger
```

用户不需要自己搜索下载页、判断版本、选择架构、下载安装包或处理安装步骤。

这将是 QYQ OS 第一项真正体现 Agent-native 思路的系统能力。

## 当前状态

QYQ OS 目前处于早期设计和启动阶段。

当前重点：

```text
VISION
↓
BOOTABLE 0.0.1
↓
AUTONOMOUS DOWNLOAD & INSTALLATION
↓
AGENT-NATIVE SYSTEM SERVICES
```

## 许可证

QYQ OS 自有代码采用 **GPL-3.0-or-later** 许可证。

第三方组件继续遵守其各自原有许可证和版权声明。详细说明见 [LICENSES.md](./LICENSES.md)。
