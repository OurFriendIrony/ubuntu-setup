## ubuntu
Installs Ubuntu configurations

#### Setup
- ***If on VM***
  - Install Guest Additions
- Bootstrap
  - Copy 'Bootstrap' to terminal
  - Execute Bootstrap
- Configure your profile
    - Create a user profile in "**user_profiles/**" from template "**user_profiles/\_\_DEMO\_\_.yml**"

#### Run
`./go.sh -s -p ubuntu -u {user_profile}`  

##### Bootstrap
```bash
sudo apt install -y python3 python3-pip python3-setuptools git \
  && sudo pip3 install ansible \
  && git clone https://github.com/OurFriendIrony/ansible.git /tmp/ansible \
  && cd /tmp/ansible
```

