#!/bin/bash

# Colors for better visual output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to display header
show_header() {
    clear
    echo -e "${CYAN}╔════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║                                                ║${NC}"
    echo -e "${CYAN}║        ${YELLOW}ThisIsDara VPN Shell Script${CYAN}          ║${NC}"
    echo -e "${CYAN}║                                                ║${NC}"
    echo -e "${CYAN}╔════════════════════════════════════════════════╗${NC}"
    echo ""
}

# Function to show progress bar
progress_bar() {
    local duration=$1
    local step_name=$2
    local width=50
    
    echo -e "${BLUE}[INFO]${NC} $step_name"
    
    for ((i=0; i<=width; i++)); do
        local percent=$((i * 100 / width))
        local filled=$((i))
        local empty=$((width - i))
        
        printf "\r${GREEN}["
        printf "%${filled}s" | tr ' ' '='
        printf ">${NC}"
        printf "%${empty}s" | tr ' ' ' '
        printf "${GREEN}]${NC} ${percent}%%"
        
        sleep $(echo "scale=3; $duration/$width" | bc)
    done
    echo ""
    echo -e "${GREEN}✓ Completed${NC}"
    echo ""
}

# Function to execute command with feedback
execute_step() {
    local step_num=$1
    local total_steps=$2
    local description=$3
    shift 3
    local cmd="$@"
    
    echo -e "${CYAN}═══════════════════════════════════════════════${NC}"
    echo -e "${YELLOW}Step ${step_num}/${total_steps}: ${description}${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════${NC}"
    echo ""
    
    eval "$cmd"
    local status=$?
    
    if [ $status -eq 0 ]; then
        echo ""
        echo -e "${GREEN}✓ Step ${step_num} completed successfully!${NC}"
        echo ""
        sleep 1
    else
        echo ""
        echo -e "${RED}✗ Step ${step_num} failed with error code: ${status}${NC}"
        echo -e "${RED}Exiting script...${NC}"
        exit $status
    fi
}

# Main script
show_header

echo -e "${YELLOW}Starting VPN installation process...${NC}"
echo ""
sleep 2

# Total steps
TOTAL_STEPS=9

# Step 1: Switch to root
execute_step 1 $TOTAL_STEPS "Switching to root user" "echo 'Switching to root environment...'"
progress_bar 1 "Preparing root access"

# Step 2: Update package list
execute_step 2 $TOTAL_STEPS "Updating package lists" "sudo apt update"

# Step 3: Upgrade packages
execute_step 3 $TOTAL_STEPS "Upgrading system packages" "sudo apt upgrade -y"

# Step 4: Create directory
execute_step 4 $TOTAL_STEPS "Creating directory 'thisisdara'" "mkdir -p thisisdara"
progress_bar 0.5 "Directory created"

# Step 5: Change to directory
execute_step 5 $TOTAL_STEPS "Navigating to 'thisisdara' directory" "cd thisisdara && pwd"

# Step 6: Clone repository
execute_step 6 $TOTAL_STEPS "Cloning 3x-ui repository from GitHub" "cd thisisdara && git clone https://github.com/MHSanaei/3x-ui"

# Step 7: Navigate to 3x-ui
execute_step 7 $TOTAL_STEPS "Entering 3x-ui directory" "cd thisisdara/3x-ui && pwd"
progress_bar 0.5 "Ready for installation"

# Step 8: Make install script executable
execute_step 8 $TOTAL_STEPS "Setting execute permissions on install.sh" "chmod +x thisisdara/3x-ui/install.sh"
progress_bar 0.5 "Permissions set"

# Step 9: Run installation
execute_step 9 $TOTAL_STEPS "Running 3x-ui installation" "cd thisisdara/3x-ui && ./install.sh"

# Completion message
echo ""
echo -e "${CYAN}╔════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║                                                ║${NC}"
echo -e "${CYAN}║           ${GREEN}Installation Complete!${CYAN}               ║${NC}"
echo -e "${CYAN}║                                                ║${NC}"
echo -e "${CYAN}║     ${YELLOW}ThisIsDara VPN is now installed${CYAN}          ║${NC}"
echo -e "${CYAN}║                                                ║${NC}"
echo -e "${CYAN}╔════════════════════════════════════════════════╗${NC}"
echo ""
