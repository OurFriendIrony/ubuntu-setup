@echo off

net session >nul 2>&1
if %errorLevel% == 0 (
  GOTO apply_bootstrap
) else (
  GOTO display_fault
)
EXIT /B

:apply_bootstrap
    ECHO #######################################
    ECHO Applying Bootstrap...
    ECHO - Allowing PowerShell execution
    Powershell.exe -Command { Set-ExecutionPolicy Bypass } >nul 2>&1
    ECHO - Upgrading PowerShell to latest
    Powershell.exe -File .\Upgrade-PowerShell.ps1
    ECHO - Configuring Remoting for Ansible
    Powershell.exe -File .\Configure-Remoting-For-Ansible.ps1
    ECHO #######################################
    GOTO :eof

:display_fault
    ECHO #######################################
    ECHO      Must be run as Administrator
    ECHO #######################################
    GOTO :eof