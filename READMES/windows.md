## windows
Installs Windows configurations

#### Setup
**Note:**
- *Your password will be need to be held as free text at least for the duration of the execution, but can be changed afterwards*
- *Windows can currently only be configured from a linux box, such as the Windows 10 - Linux SubSystem. This can be installed via the 'Turn Windows Features on and off' menu*

- Bootstrap
  - On Windows
    - Execute the bootstrap at ".ansible-sys/windows-support/bootstap.bat"
    - This will update powershell and give Ansible the ability to make connections with winrm
- Configure your profile
  - On Linux
    - Create a user profile in "**user_profiles/**" from template "**user_profiles/\_\_DEMO\_\_.yml**"
    - Make sure the `ansible_user` and `ansible_password` correctly reflects your Microsoft account on the windows machine.
    - **DO NOT** commit your password back to git...

#### Run 
- On Linux
  - `./go.sh -p windows -u {user_profile}`

