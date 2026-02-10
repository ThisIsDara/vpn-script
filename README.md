# VPN Setup Script

This script automates the installation and setup of a VPN server using the 3x-ui panel.

## Prerequisites

- Ubuntu/Debian-based Linux system
- Root or sudo access
- Internet connection

## One-Command Installer

To install and run the VPN setup in one go, execute:

```bash
git clone https://github.com/ThisIsDara/vpn-script.git && cd vpn-script && chmod +x vpn-setup.sh && ./vpn-setup.sh
```

This command will:
1. Clone the repository
2. Navigate to the directory
3. Make the script executable
4. Run the installation

## What It Does

The script performs the following steps:
- Updates system packages
- Upgrades packages
- Clones the 3x-ui repository
- Installs 3x-ui for VPN management

## Note

Ensure you have the necessary permissions and that your system meets the requirements before running.