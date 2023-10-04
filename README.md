# Automatic Setup and Takedown of Docker Desktop

Docker is a powerful tool for IT and application development. 
Containerizing your applications allows for an immense increase in versatility and stability of your production services.

That said, setting it up on anything _but_ Linux can be somewhat painful, and removing it when your done can be equally difficult.

## Docker Setup
To set up Docker Desktop on your PC, you will want to enable WSL2 (Windows Subsystem for Linux 2) on your system and have a working instance of WinGet.

### Prerequisites
1. You must be running at minimum Windows 10 version 2004 (Build 1901 and higher), or any version of Windows 11.
2. You must make sure your Microsoft Store app is up to date.

### Setup Instructions (Windows 11)
1. Open "Windows Terminal" or "Powershell" on your PC.
2. Run the `WinGet --version` command, if this returns a "Not Recognized" error, than you may need to download "App Installer" from the Microsoft Store [here](https://apps.microsoft.com/store/detail/app-installer/9NBLGGH4NNS1).
3. Install Docker Desktop with the command: `WinGet install Docker.DockerDesktop`
    * You may need to type `Yes` to agree to the Microsoft Store terms of service.

### Setup Instructions (Windows 10)
1. Open "Windows Terminal" or "Powershell" AS ADMINISTRATOR on your PC.
    * The quickest way to do this is to right-click on the Start button and select the corrosponding option.
2. Run the following command and then restart your PC:
```Powershell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```
3. Open "Windows Terminal" or "Powershell" again, you do not need to be administrator this time.
2. Run the `WinGet --version` command, if this returns a "Not Recognized" error, than you may need to download "App Installer" from the Microsoft Store [here](https://apps.microsoft.com/store/detail/app-installer/9NBLGGH4NNS1).
3. Activate WSL2 with the following command(s):
```Powershell
wsl --set-default-version 2 # This command only works on older versions of WSL, ignore any errors.
wsl --install
```
4. Install Docker Desktop with the command: `WinGet install Docker.DockerDesktop`
    * You may need to type `Yes` to agree to the Microsoft Store terms of service.

## Takedown

Instructions for the takedown of Docker and its related components are available [here](docker-clean.md).
