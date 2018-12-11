## Summary
The sections below cover install and build steps to get a full functioning linux box meeting whatever requirements you have.

  * [Playbooks](#playbooks)
    * [Ubuntu](#ubuntu)
    * [Ubuntu TP](#ubuntu-tp)
    * [Retropie](#retropie)
  * [Help](#help)
  * [Ansible Module Index](#ansible-module-index)

___
# Playbooks
## ubuntu
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
sudo apt-get install -y python-pip git \
  && sudo pip install ansible \
  && git clone https://github.com/OurFriendIrony/ansible.git /tmp/ansible \
  && cd /tmp/ansible
```
___
## ubuntu-tp
#### Setup
***Note:** Your password will be temporarily stored in a couple of files to initially escape the to the internet via the proxy, where it can download cntlm and apply your hashed password. It is then 'forgotten'*

- ***If on VM***
  - Install Guest Additions
- Bootstrap
  - Copy 'Bootstrap' to terminal
  - Replace `__YOURPASSWORD__` with your password
  - Execute Bootstrap
    - note your "**ntlm_hash**"
- Configure your profile
    - Create a user profile in "**user_profiles/**" from template "**user_profiles/\_\_DEMO\_\_.yml**"
    - Add your "**ntlm_hash**" to your user profile

#### First Run
To ensure successful executions, first run the following and then restart you machine before attempting to run the main rollout
`./go.sh -s -p ubuntu-tp -u {user_profile} -t proxy`

#### Run 
`./go.sh -s -p ubuntu-tp -u {user_profile}`


#### Bootstrap
```bash
 TMP_PASS="__YOURPASSWORD__"
```
followed by
```bash
export https_proxy="http://${LOGNAME}:${TMP_PASS}@10.0.20.196:8080" \
  && echo -e "Acquire::http::Proxy \"${https_proxy}\";" | sudo tee /etc/apt/apt.conf.d/01proxy > /dev/null \
  && echo -e "[http]\n  proxy = ${https_proxy}" > ~/.gitconfig \
  && sudo apt-get update \
  && sudo apt-get install -y python-pip git cntlm \
  && sudo -E pip install ansible \
  && git clone https://github.com/OurFriendIrony/ansible.git /tmp/ansible \
  && cd /tmp/ansible \
  && echo ${TMP_PASS} | cntlm -H -d tpplc -u ${LOGNAME} | awk 'NR==4 {print "\nntlm_hash = "$2}' \
  && unset TMP_PASS
```
___
## retropie
#### Allow SSH connectivity
- Connect Wifi
- sudo raspi-config
  - 5 --> 2 [Turn on SSH client]
  - 7 --> 1 [Expand FileSystem]

#### Setup
- Bootstrap
  - Copy 'Bootstrap' to terminal
  - Execute Bootstrap
- Configure your profile
    - Create a user profile in "**user_profiles/**" from template "**user_profiles/\_\_DEMO\_\_.yml**"

#### Run
`./go.sh -s -p retropie -u pi`  

#### Bootstrap
```bash
sudo apt-get install -y python-pip git \
  && sudo pip install -y ansible \
  && git clone https://github.com/OurFriendIrony/ansible.git /tmp/ansible \
  && cd /tmp/ansible
```

___
# Help
`./go.sh -h`

___
# Ansible Module Index
All Modules are documented [**here**](http://docs.ansible.com/ansible/latest/list_of_all_modules.html)

