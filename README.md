# QYQ OS

**QiYinQiao Operating System**

[中文](./README.zh-CN.md) | English

QYQ OS is a personal intelligent operating system designed for the Agent era.

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

## Core Idea

Users should describe what they want to achieve instead of manually performing every low-level step.

For example:

```text
Install Blender
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

## Current Technical Direction

Initial base:

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

QYQ OS reuses mature Linux infrastructure wherever possible and focuses development on the intelligent system layer.

# Roadmap

## 0.0.1 — Bootable QYQ OS

Version baseline: [docs/0.0.1-BASELINE.md](./docs/0.0.1-BASELINE.md)

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

## License

Original QYQ OS code is licensed under **GPL-3.0-or-later**.

Third-party components retain their own licenses and copyright notices. See [LICENSES.md](./LICENSES.md) for details.
