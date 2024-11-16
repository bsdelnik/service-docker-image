# Service Docker Image for Kubernetes Debugging

This repository provides a Docker image tailored for debugging within Kubernetes clusters. Built on Alpine Linux, it includes a comprehensive suite of tools to facilitate troubleshooting, performance testing, and interaction with AWS services.

## Table of Contents

- [Features](#features)
- [Included Tools](#included-tools)
- [Installation](#installation)
- [Usage](#usage)
  - [Running the Container](#running-the-container)
  - [Using in Kubernetes](#using-in-kubernetes)
- [Assume Role Script](#assume-role-script)
- [Contributing](#contributing)
- [License](#license)

## Features

- **Lightweight Base Image**: Uses Alpine Linux for a minimal footprint.
- **Extensive Toolset**: Pre-installed utilities for networking, debugging, and development.
- **AWS Integration**: Includes AWS CLI and Boto3 for AWS interactions.
- **Custom Scripts**: Provides an `assume-role` script for AWS IAM role assumption.
- **Performance Testing**: Comes with Vegeta for HTTP load testing.

## Included Tools

### Shells & Editors

- **bash**: GNU Bourne Again shell.
- **vim**: Advanced text editor.

### Networking & Debugging

- **busybox-extras**: Additional utilities for BusyBox.
- **curl**: Tool for transferring data with URLs.
- **bind-tools**: DNS tools like `dig`, `nslookup`, and `host`.
- **iproute2-ss**: Utilities for controlling networking.
- **netcat-openbsd**: Networking utility for reading and writing network connections.
- **nmap**: Network exploration and security auditing tool.
- **tcpdump**: Packet analyzer.
- **tcpflow**: Captures TCP connections for analysis.
- **wget**: Network downloader.

### Development & Scripting

- **git**: Distributed version control system.
- **python3**: Python programming language interpreter.
- **py3-pip**: Package installer for Python.
- **jq**: Command-line JSON processor.
- **screen**: Terminal multiplexer.

### Databases

- **postgresql-client**: PostgreSQL database client.

### AWS Tools

- **awscli**: Official Amazon AWS command-line interface.
- **boto3**: AWS SDK for Python.

### Performance Testing

- **Vegeta**: HTTP load testing tool.

## Installation

### Pull from Docker Hub

Pull the image directly from Docker Hub:

```bash
docker pull bsdelnik/service-image:latest
```

### Build from Source

Clone the repository and build the image:

```bash
git clone https://github.com/bsdelnik/service-docker-image.git
cd service-docker-image
docker build -t service-image:0.3 .
```

## Usage

### Running the Container

Run the Docker container interactively:

```bash
docker run -it --rm service-image:latest
```

This command starts the container and opens a Bash shell.

### Using in Kubernetes

Deploy the image in a Kubernetes cluster for debugging purposes.

**Example Pod Definition:**

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: debug-pod
spec:
  containers:
    - name: debug-container
      image: bsdelnik/service-image:latest
      command: ["/bin/bash"]
      stdin: true
      tty: true
```

**Deploy the Pod:**

```bash
kubectl apply -f debug-pod.yaml
```

**Access the Pod:**

```bash
kubectl exec -it debug-pod -- /bin/bash
```

## Assume Role Script

The image includes an `assume-role` script located at `/bin/assume-role`. This script simplifies the process of assuming AWS IAM roles.

### Usage

```bash
assume-role <role-arn> <session-name>
```

- `<role-arn>`: The Amazon Resource Name (ARN) of the IAM role you want to assume.
- `<session-name>`: An identifier for your session.

### Example

```bash
assume-role arn:aws:iam::123456789012:role/YourRole session-name
```

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Submit a pull request with a detailed explanation of your changes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
