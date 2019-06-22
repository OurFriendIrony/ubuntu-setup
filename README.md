  * [User Profiles](#user-profiles)
  * [Tags](#tags)
  * [Playbooks](#playbooks)
    * [Ubuntu](#ubuntu)
    * [Ubuntu TP](#ubuntu-tp)
    * [Retropie](#retropie)
  * [Help](#help)
  * [Ansible Module Index](#ansible-module-index)
___
# User Profiles
Your user profile can be used to override every roles `defaults` values. For example, adding:
```
terraform_version : "0.9.6"
```
will install that specific version of terraform, instead of the default values.  
  
If you want to see what you can override for a given role, check `roles/{ROLE_NAME}/defaults/main.yml`  
If you want to see what you can override across all roles, you can try the following:
```
for dir in $(find . -type d -name "defaults"); do grep -vE "^---" ${dir}/main.yml ; done
```
___
# Tags
Every role contains tags that you can specifically execute instead of running a full playbook.  
There is a standard behind the tags naming, so if you just want to install intellij, which exists in `developer/ide/intellij` you can run either `-t developer`, `-t ide` or `-t intellij`.
___
# Playbooks
The sections below cover install and build steps to get a full functioning linux box meeting whatever requirements you have. 
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
sudo apt install -y python-pip python-setuptools git \
  && sudo pip install ansible \
  && git clone --depth=1 https://github.com/OurFriendIrony/ansible.git /tmp/ansible \
  && cd /tmp/ansible
```
___
## ubuntu-tp
#### Setup
Installs Ubuntu configurations from behind a proxy
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
  && sudo apt update \
  && sudo apt install -y python-pip python-setuptools git cntlm \
  && sudo -E pip install ansible \
  && git clone --depth=1 https://github.com/OurFriendIrony/ansible.git /tmp/ansible \
  && cd /tmp/ansible \
  && echo ${TMP_PASS} | cntlm -H -d tpplc -u ${LOGNAME} | awk 'NR==4 {print "\nntlm_hash = "$2}' \
  && unset TMP_PASS
```
___
## retropie
Installs all configurations for a [**Retropie 4.4**](https://retropie.org.uk/2018/04/retropie-4-4-is-released/) install

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
sudo apt install -y python-pip python-setuptools git dialog unzip xmlstarlet \
  && sudo pip install ansible \
  && git clone --depth=1 https://github.com/OurFriendIrony/ansible.git /tmp/ansible \
  && cd /tmp/ansible
```
___
# Help
`./go.sh -h`
```
go.sh -p PLAYBOOK -u USER [-l LIMIT] [-t TAGS] [-z SKIP] [-v VERBOSITY] [-k KEY] [-e EXTRAVARS] [-s] [-c] [-h]
     -p PLAYBOOK      path to playbook
     -u USER          user profile to load
     -l LIMIT         limit to host
     -t TAGS          run only tasks with provided tags
     -z SKIP          skips tasks with provided tags
     -v VERBOSITY     v, vv, vvv, vvvv
     -k KEY           use private key
     -e EXTRAVARS     include as extra vars
     -s               run as sudo
     -c               run in check mode
     -h               show help
```
___
# Ansible Module Index
All Modules are documented [**here**](http://docs.ansible.com/ansible/latest/list_of_all_modules.html)
