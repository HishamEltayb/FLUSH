# FLUSH

# FLUSH 42 Cleanup Script

**FLUSH 42** is a macOS cleanup script designed to help you reclaim disk space by deleting unnecessary files, caches, logs, and more. It provides both a normal and an aggressive cleaning mode with clear visual feedback. The script also includes an option to safely remove keychain files with explicit user confirmation.

## Features

- **Animated Intro & Flush Process**:  
  - The script starts with an animated loading sequence and displays "FLUSH" in big ASCII art.  
  - It then animates the flushing process with colorful frames for a fun experience.
  
- **Storage Overview**:  
  - Displays the total and available storage before and after the cleaning process in color-coded formats.
  
- **Normal & Super Flush Modes**:  
  - **Normal Flush**: Deletes various unwanted files such as caches, logs, and temporary files.  
  - **Super Flush**: Includes the option to delete sensitive keychain files after user confirmation.
  
- **Logging Option**:  
  - Add the `-p` or `--print` flag to display the size of the files being deleted during the cleanup process.
  
- **Keychain Deletion Warning**:  
  - Before deleting any keychain files, the script asks for explicit confirmation to prevent accidental loss of important login data.

- **Clean Specific Files & Directories**:  
  - Removes system and application cache files, browser cache data, Slack and Discord cache, and unused files from the Desktop (e.g., `.DS_Store`).

## Installation

1. Clone or download the script to your macOS machine:
   ```bash
   git clone https://github.com/yourusername/flush_42.git
   cd flush_42
   ```
2. Give the script executable permissions:
   ```bash
   chmod +x flush_42.sh
   ```

## Usage

1. Run the script in normal mode:
   ```bash
   ./flush_42.sh
   ```

2. Run with logging enabled:
   ```bash
   ./flush_42.sh -p
   ```
   or
   ```bash
   ./flush_42.sh --print
   ```

3. Run in Super Flush mode (includes keychain deletion):
   ```bash
   ./flush_42.sh -s
   ```
   or
   ```bash
   ./flush_42.sh --super
   ```

## Warning

- Always backup important data before running cleanup scripts
- Be especially careful when using Super Flush mode as it can delete keychain files
- The script requires administrative privileges for certain operations

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Thanks to the 42 School community for inspiration and support
- All contributors who have helped to improve this script
