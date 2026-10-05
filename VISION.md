# QYQ OS Vision

## QiYinQiao Operating System

**QYQ OS**（QiYinQiao OS）是面向 Agent 时代设计的个人智能操作系统。

QYQ OS 基于 Linux 和 Debian 生态构建，保留成熟的硬件、驱动、软件和桌面生态，在其上建立面向个人智能计算的新系统层。

核心目标：

> **让计算机能够理解用户的目标、记住长期上下文、组织模型与工具完成任务，同时让数据、权限和最终控制权始终属于用户。**

---

# 1. Personal Intelligent Operating System

传统个人计算机主要围绕 Application 工作：

```text
User
  ↓
Application
  ↓
Menu / Button / Command
  ↓
Operating System
```

用户负责把一个目标拆解成大量操作：

```text
搜索
查询
下载
打开
配置
安装
复制
粘贴
执行
检查
```

QYQ OS 将 **Task** 作为更高层的系统抽象。

```text
User
  ↓
Intent
  ↓
Task
  ↓
Agent Runtime
  ↓
Tools / Applications / System
```

例如：

```text
“安装 Blender”
```

这已经是完整任务。

系统负责完成内部流程：

```text
理解软件名称
↓
搜索可用来源
↓
查询版本和平台
↓
选择可信来源
↓
下载
↓
校验签名 / Hash
↓
安全检查
↓
请求必要权限
↓
安装
↓
验证运行状态
↓
记录结果
```

用户描述目标。

系统负责执行过程。

---

# 2. Linux Foundation

QYQ OS 以 Linux 作为内核基础。

初期使用 Debian Stable / LTS 提供成熟用户空间和软件生态。

计划直接复用：

```text
Linux Kernel
Debian
systemd
glibc
APT / dpkg
Wayland
Mesa
PipeWire
NetworkManager
BlueZ
D-Bus
polkit
```

这些组件已经解决了大量基础问题：

- CPU 与内存管理
- Hardware Drivers
- Filesystem
- Network
- Wi-Fi
- Bluetooth
- Graphics
- Audio
- Process Management
- Package Management
- Desktop Applications

QYQ OS 将主要开发新的智能系统层。

```text
QYQ OS
────────────────────────────

Personal Intelligence Layer

Task Runtime
Agent Runtime
Memory Service
Context Broker
Permission Broker
System API
System Ledger
Model Runtime
Tool Runtime

────────────────────────────

Debian Userspace

────────────────────────────

Linux Kernel
```

成熟的 Linux 基础设施优先复用。

---

# 3. Intelligence Lives in Userspace

AI 模型运行于用户空间。

模型不会进入 Linux Kernel。

Linux Kernel 继续负责：

```text
Process
Memory
Device
Filesystem
Network
Scheduling
Security primitives
```

智能系统层负责：

```text
Understanding
Planning
Memory
Context
Task Execution
Model Routing
System Observation
```

基本关系：

```text
Models
   ↓
QYQ Intelligence Layer
   ↓
System API
   ↓
Linux Userspace
   ↓
Linux Kernel
```

模型可以理解系统和内核状态，但不需要直接读取 Kernel Memory。

---

# 4. System Awareness

QYQ OS 应该让智能系统能够随时理解计算机当前状态。

Linux 已经提供大量底层信息来源：

```text
/proc
/sys
Netlink
udev
systemd
journald
eBPF
perf
PSI
```

QYQ OS 将这些信息整理为稳定、结构化的 System API。

例如：

```text
/system/cpu
/system/memory
/system/gpu
/system/storage
/system/network
/system/devices
/system/processes
/system/services
/system/events
```

智能系统无需通过大量 Shell 命令反复探测计算机。

系统持续维护当前状态。

```text
Linux Kernel
     ↓
System Events / Telemetry
     ↓
System State Service
     ↓
Structured System Context
     ↓
Main Model / Agents
```

例如系统能够理解：

```text
当前内存压力很高
NVMe IO 接近满载
某个进程占用了大量 CPU
网络刚刚断开
某个 systemd 服务启动失败
GPU Driver 出现异常
```

这些信息可以直接成为 Agent 的系统上下文。

---

# 5. One Main Model, Many Specialized Models

QYQ OS 的智能系统由多个模型组成。

系统拥有一个 **Main Model**。

Main Model 负责：

- 日常交互
- Intent Understanding
- Task Planning
- Context Understanding
- Tool Selection
- Model Selection
- Agent Coordination
- Result Verification

Main Model 是个人智能系统的主要认知中枢。

大量明确的小任务交给专用模型。

```text
                  Main Model
                      │
        ┌─────────────┼─────────────┐
        ↓             ↓             ↓
 Translation       Speech         Vision
        ↓             ↓             ↓
 Embedding        Coding        Reranker
        ↓             ↓             ↓
 Classification   OCR           Other Models
```

模型可以包括：

```text
Main General Model
Translation Model
Speech Recognition Model
TTS Model
Vision Model
Coding Model
Embedding Model
Reranker
Classification Model
OCR Model
Specialized Models
```

QYQ OS 不要求所有任务都经过大型通用模型。

简单任务应优先使用更小、更快、更便宜的模型。

---

# 6. Translation Is a System Capability

翻译是 QYQ OS 的基础智能能力之一。

Translation Model 可以作为长期存在的系统服务：

```text
translationd
```

应用可以直接调用系统翻译能力。

```text
Browser
Game
Document
Chat
Video
Application
     ↓
Translation API
     ↓
Local Translation Model
```

应用无需各自实现一套翻译系统。

例如：

```text
英文网页
↓
实时中文

日文游戏字幕
↓
实时中文

英语视频
↓
Speech Recognition
↓
Translation
↓
中文字幕
```

翻译、语音和其他高频基础模型应尽可能支持本地运行。

---

# 7. Memory Is an Operating System Capability

用户记忆属于 QYQ OS。

Memory 不属于 Main Model。

也不属于任何单独的 Agent 或 AI Provider。

```text
QYQ OS
   │
   ├── Memory Service
   ├── Context Broker
   ├── Permission Broker
   │
   ├── Local Models
   └── External Models
```

模型可以更换。

Agent 可以更换。

AI Provider 可以更换。

用户多年积累的 Memory 仍然属于同一个操作系统和用户。

Memory 可以包含：

```text
Personal Memory
Project Memory
Long-term Preferences
Task History
Important Decisions
Application Context
Knowledge Index
Relationships
User-defined Information
```

Memory Service 负责：

- Storage
- Search
- Update
- Deduplication
- Linking
- Lifecycle
- Permission
- Context Retrieval

---

# 8. Memory Sovereignty

个人长期记忆是操作系统中最高敏感等级的数据之一。

默认原则：

> **Memory stays local.**

以下内容都属于 Memory 边界：

```text
Raw Memory
Memory Summary
Memory Index
Embeddings
Topic Graph
Relationship Graph
Search History
Memory Metadata
```

这些数据默认保存在用户设备。

闭源模型和云端模型不能自由查询 Memory Service。

禁止：

```text
External Model
      ↓
Search all user memory
```

外部模型只能接收当前任务所需要的上下文。

---

# 9. Context Broker

Context Broker 位于用户数据和模型之间。

```text
Memory
Files
Project State
System State
        │
        ↓
 Context Broker
        │
        ↓
Task-specific Context
        │
   ┌────┴────┐
   ↓         ↓
Local      External
Models      Models
```

Context Broker 根据：

- 当前 Task
- 用户权限
- 数据敏感度
- 模型位置
- Provider
- Privacy Policy

构建上下文。

例如用户要求：

```text
“帮我回复这封邮件。”
```

外部模型可能获得：

```text
当前邮件正文
相关项目摘要
必要的联系人关系
用户邮件风格偏好
```

它不会因此获得：

```text
完整邮件历史
完整联系人数据库
全部个人记忆
其他项目内容
完整 Memory Index
```

系统遵循：

> **Minimum Necessary Context**

只提供当前任务所需要的信息。

---

# 10. Local Models and External Models

不同模型拥有不同信任等级。

例如：

```text
Local Main Model
    ↓
较高 Memory Access

Local Specialized Model
    ↓
Task-scoped Access

External Closed Model
    ↓
No Direct Memory Access

Cloud Agent
    ↓
No Direct Memory Access
```

外部模型位于 QYQ OS 的隐私边界之外。

```text
                Local Trust Boundary

┌────────────────────────────────────┐
│                                    │
│ Memory                             │
│ Files                              │
│ Personal Context                   │
│ System State                       │
│                                    │
│          Context Broker            │
│                │                   │
└────────────────┼───────────────────┘
                 │
          Selected Context
                 │
                 ↓
        External AI Provider
```

用户可以查看哪些信息被发送到了哪个模型。

---

# 11. Task Runtime

QYQ OS 使用 Task 描述用户目标。

Task 可以是：

```text
安装一个软件
寻找一个文件
下载一个模型
修复一个项目
翻译一段视频
整理照片
分析系统故障
写一份报告
更新一个项目
```

一个 Task 可以包含多个节点。

例如：

```text
Install Blender

├── Resolve Software
├── Search Sources
├── Select Source
├── Download
├── Verify
├── Security Scan
├── Permission Check
├── Install
└── Verify Installation
```

用户通常只需要表达：

```text
“安装 Blender。”
```

Task Runtime 管理后续执行。

---

# 12. Resource Acquisition

搜索、查询和下载属于系统基础任务能力。

用户可以直接要求：

```text
“下载 Linux Kernel 源码。”

“下载这个 GitHub 项目最新版本。”

“找到这篇论文并保存下来。”

“安装 Blender。”

“下载一个适合当前显卡运行的模型。”
```

系统负责：

```text
Search
↓
Resolve
↓
Select
↓
Verify Source
↓
Download
↓
Security Check
↓
Organize
↓
Record
```

Resource Acquisition 可以支持：

```text
HTTP
APT
Git
GitHub Releases
Model Repositories
Container Registries
Software Repositories
Other Sources
```

用户描述需要什么资源。

系统决定如何获取。

---

# 13. Permission Broker

Agent 无法默认获得完整系统权限。

系统能力通过 Permission Broker 管理。

例如 Coding Agent 请求：

```text
Read /projects/qyq
Write /projects/qyq
Access github.com
Run compiler
Use GPU
Create Processes
```

Permission Broker 可以决定：

```text
Allow
Deny
Ask User
Allow Once
Allow Temporarily
Allow for Project
```

权限应该：

- 最小化
- 可撤销
- 可查看
- 可审计
- 与 Task 关联
- 与 Project 关联
- 与 Agent 关联

Agent 不直接获得无限制 root 权限。

---

# 14. Agent Sandbox

QYQ OS 使用 Linux 已有安全能力构建 Agent Sandbox。

包括：

```text
Namespaces
cgroup v2
seccomp
Capabilities
Landlock
AppArmor / SELinux
```

例如：

```text
Coding Agent

CPU:
4 cores

Memory:
8 GB

Filesystem:
  /projects/qyq     rw
  /home/user        deny
  /tmp              rw

Network:
  github.com        allow
  other             deny

Devices:
  GPU               allow
  Camera            deny
  Microphone        deny
```

Sandbox 是 Agent Runtime 的标准运行环境。

---

# 15. System Ledger

QYQ OS 从系统层记录重要行为。

每个 Task 和关键系统动作都产生结构化事件。

每条事件至少能够回答：

```text
WHO
谁执行

WHAT
做了什么

WHY
为什么执行

WHEN
什么时候执行

SOURCE
数据来自哪里

PERMISSION
使用了什么权限

RESULT
执行结果
```

例如：

```text
Task:
Install Blender

14:03:01
User requested installation

14:03:02
Software Resolver found Debian package

14:03:03
Source verified as Debian official repository

14:03:04
Package signature verified

14:03:05
287 MB download started

14:03:19
Installation started

14:03:28
Installation completed

14:03:29
Launch verification successful
```

用户可以直接询问：

```text
“刚才系统做了什么？”

“为什么电脑昨晚一直高负载？”

“这个文件是谁删除的？”

“为什么 Python 被安装了？”

“今天哪些信息发送到了云端模型？”

“哪个 Agent 使用了 GPU？”
```

System Ledger 提供这些问题所需要的数据。

---

# 16. Explainable System

QYQ OS 的重要系统行为必须能够解释。

核心原则：

> **Every meaningful system action should be traceable and explainable.**

系统后台发生的重要行为不应该成为用户无法理解的黑箱。

包括：

```text
Software Installation
System Update
Agent Actions
Network Transfers
Cloud Model Calls
File Modification
Permission Changes
Background Tasks
Service Failures
System Recovery
Hardware Events
```

所有重要操作都应该进入统一的事件体系。

---

# 17. System Ledger and Low-Level Logs

传统日志继续存在：

```text
Kernel Logs
journald
Application Logs
Driver Logs
Service Logs
```

QYQ OS 在其上建立 System Ledger。

```text
Low-level Logs
      ↓
Event Collectors
      ↓
Normalization
      ↓
System Ledger
      ↓
Query API
      ↓
Human / Agent / GUI
```

Low-level Logs 用于工程诊断。

System Ledger 用于理解系统发生了什么。

---

# 18. Main Model Lifecycle

Main Model 不需要始终以最高算力运行。

QYQ OS 可以采用多级运行方式：

```text
Always-on Small Models
        ↓
Main Model
        ↓
Large Local / Cloud Model
```

例如：

```text
Tiny Router
↓
识别简单请求
↓
调用 Translation / Speech / Search 等专用模型

复杂请求
↓
唤醒 Main Model

高难任务
↓
按需调用更大的本地或云模型
```

这允许系统在智能能力、性能、功耗和成本之间进行平衡。

---

# 19. Model Independence

QYQ OS 不绑定某个 AI Provider。

模型可以来自：

```text
Local Open Models
Self-hosted Models
Cloud Models
Commercial Models
Specialized Models
```

用户可以替换：

```text
Main Model
Coding Model
Translation Model
Speech Model
Vision Model
```

操作系统的核心 Memory、Task、Permission 和 Ledger 不依赖特定模型供应商。

---

# 20. Traditional Applications

传统 Linux 软件生态继续存在。

用户仍然可以使用：

```text
Browser
IDE
Office
Steam
Games
Creative Software
Terminal
Development Tools
Linux Applications
```

Agent 可以将这些应用作为 Tool 使用。

例如：

```text
User Task
   ↓
Agent
   ↓
Blender / Browser / IDE / CLI / Other Tool
```

传统应用和 Agent-native 工作方式可以长期共存。

---

# 21. Human and Agent Interfaces

QYQ OS 同时为人和 Agent 提供系统接口。

```text
             System Capability
            /        |         \
           /         |          \
         GUI        CLI        Agent API
```

GUI 用于人的直接交互。

CLI 保持完整能力。

Agent API 提供结构化系统接口。

三种接口共享同一套权限、状态和日志体系。

---

# 22. Self-Maintenance

QYQ OS 可以逐步具备系统自维护能力。

例如：

```text
Observe
↓
Detect
↓
Diagnose
↓
Plan
↓
Authorize
↓
Execute
↓
Verify
↓
Record
```

系统可以：

- 分析异常服务
- 检查磁盘空间
- 发现高资源占用
- 诊断网络问题
- 分析启动失败
- 检查软件更新
- 检查硬件异常
- 尝试恢复服务
- 给用户提供处理建议

所有自动操作都经过权限体系，并写入 System Ledger。

---

# 23. Core Architecture

长期架构：

```text
                         User
                           │
              ┌────────────┼────────────┐
              ↓            ↓            ↓
             GUI           CLI         Intent
                                          │
                                          ↓
                                     Main Model
                                          │
                   ┌──────────────────────┼──────────────────────┐
                   ↓                      ↓                      ↓
                Memory               Task Runtime            Model Router
                   │                      │                      │
                   ↓                      │             ┌────────┼────────┐
             Context Broker               │             ↓        ↓        ↓
                   │                      │          Speech   Translate  Coding
                   └──────────────┬───────┘
                                  ↓
                             Agent Runtime
                                  │
                             Tool Runtime
                                  │
                         Permission Broker
                                  │
                            Agent Sandbox
                                  │
                              System API
                                  │
                            System Ledger
                                  │
                          Debian Userspace
                                  │
                              Linux Kernel
```

---

# 24. Core Principles

QYQ OS 的核心原则：

## Local First

个人数据和基础智能能力优先本地运行。

## Memory Sovereignty

用户记忆属于用户和操作系统。

模型只是经过授权的 Memory 消费者。

## Agent Native

Agent 是操作系统的一等公民。

## Model Federation

一个主模型负责主要智能任务，多个专用模型承担高频和专业工作。

## Task Oriented

用户表达目标，系统组织执行过程。

## User Controlled

用户拥有数据、权限和系统行为的最终控制权。

## Observable

重要系统状态和行为可以被用户和系统理解。

## Explainable

重要系统行为能够追踪到原因、执行者、权限和结果。

---

# 25. Vision

QYQ OS 希望构建一种长期存在于个人计算机中的智能系统。

它能够：

```text
Understand
Remember
Search
Plan
Act
Verify
Explain
Maintain
```

它拥有一个负责日常工作的主模型，以及多个长期存在或按需运行的专用模型。

它能够理解当前系统状态。

它能够使用软件、文件、网络和设备完成任务。

它能够长期保存属于用户自己的记忆。

它知道哪些信息可以留在本地，哪些信息允许发送给外部模型。

它记录系统做过的重要事情。

它能够回答：

```text
发生了什么？
谁做的？
为什么做？
用了什么权限？
发送了什么数据？
结果怎么样？
```

QYQ OS 希望让个人计算机从需要用户不断操作的工具，逐渐发展为能够长期理解、协助并执行任务的个人智能系统。

---

# QYQ OS

**QiYinQiao Operating System**

**Personal Intelligent Operating System for the Agent Era**

核心原则：

> **Local First · Memory Sovereignty · Agent Native · User Controlled**

中文：

> **本地优先 · 记忆主权 · Agent 原生 · 用户控制**
