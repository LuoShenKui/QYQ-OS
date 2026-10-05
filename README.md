# QYQ OS

**QiYinQiao Operating System**

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

---

## 中文简介

QYQ OS 的核心思路很简单：

用户应该描述“想完成什么”，而不是亲自完成大量机械操作。

例如：

```text
“安装 Blender”
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

系统中的 AI 模型运行于用户空间。

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

---

## Current Technical Direction

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

QYQ OS 优先复用成熟 Linux 基础设施。

项目主要开发新的智能系统层。

---

# Roadmap

## 0.0.1 — Bootable QYQ OS

第一步是先把 QYQ OS 真正跑起来。

目标：

- 基于 Debian Stable / LTS
- 生成 QYQ OS 系统镜像
- 可以在 QEMU / 虚拟机启动
- 可以正常进入系统
- 网络可用
- APT 可用
- systemd 正常工作
- 建立 QYQ OS branding
- 建立 QYQ OS 自有软件仓库基础
- 为后续 Agent Runtime 和系统服务预留结构

0.0.1 的目标不是加入复杂 AI 功能。

它的意义是建立一个可重复构建、可以启动、可以继续开发的 QYQ OS 基础系统。

---

## Next — Autonomous Download & Installation

0.0.1 跑通后，第一项 Agent-native 系统能力将是：

> **自主搜索、查询、下载、安全检查和安装。**

例如用户输入：

```text
安装 Blender
```

系统自动执行：

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

这将作为 QYQ OS 第一项真正体现 Agent-native 思路的系统功能。

---

# English

QYQ OS, short for **QiYinQiao Operating System**, is a personal intelligent operating system designed for the Agent era.

It is built on top of the Linux and Debian ecosystem and adds a new intelligent system layer including:

- Main Model
- Specialized Models
- Task Runtime
- Agent Runtime
- Memory Service
- Context Broker
- Permission Broker
- System API
- System Ledger

The goal is to let the computer understand user intent, execute tasks, maintain long-term memory, understand system state, and keep important system actions traceable and explainable.

> **Local First · Memory Sovereignty · Agent Native · User Controlled**

See [VISION.md](./VISION.md) for the full vision.

---

## Core Idea

Users should describe what they want to achieve instead of manually performing every low-level step.

For example:

```text
"Install Blender"
```

The system should handle:

```text
Search
↓
Query
↓
Select Trusted Source
↓
Download
↓
Verify
↓
Security Scan
↓
Install
↓
Validate
↓
Record
```

QYQ OS will gradually turn these workflows into native operating-system capabilities.

AI models run in userspace.

The planned model architecture is:

```text
One Main Model
+
Many Specialized Models
```

Specialized models may handle:

- Translation
- Speech Recognition
- TTS
- Vision
- Coding
- Embedding
- OCR
- Classification

Long-term user memory belongs to the operating system and the user.

Closed-source and cloud models must not freely inspect user memory. They only receive the minimum context required for the current task.

QYQ OS also maintains a System Ledger to record:

- Who performed an action
- What was done
- Why it was done
- Which permissions were used
- Where data came from
- Whether data was sent outside the device
- The final result

---

# Roadmap

## 0.0.1 — Bootable QYQ OS

The first goal is simple:

> **Make QYQ OS boot and run.**

0.0.1 should:

- Use Debian Stable / LTS as the initial base
- Produce a QYQ OS system image
- Boot successfully in QEMU / a virtual machine
- Provide working networking
- Provide working APT
- Run systemd correctly
- Include QYQ OS branding
- Establish the foundation for the QYQ OS package repository
- Reserve a clean structure for future Agent Runtime and system services

The purpose of 0.0.1 is to establish a reproducible, bootable base system that can be developed further.

---

## Next — Autonomous Download & Installation

After 0.0.1 works, the first Agent-native system capability will be:

> **Autonomous search, query, download, security verification, and installation.**

For example:

```text
Install Blender
```

QYQ OS should handle:

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

This will be the first practical step toward a task-oriented, Agent-native personal operating system.

---

## Status

QYQ OS is currently in the early design and bootstrap stage.

Current focus:

```text
VISION
↓
BOOTABLE 0.0.1
↓
AUTONOMOUS DOWNLOAD & INSTALLATION
↓
AGENT-NATIVE SYSTEM SERVICES
```
