## ubuntu-tp
Installs Ubuntu configurations from behind a proxy

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
  && sudo apt update \
  && sudo apt install -y python3 python3-pip python3-setuptools git cntlm \
  && sudo -E pip3 install ansible \
  && git clone https://github.com/OurFriendIrony/ansible.git /tmp/ansible \
  && cd /tmp/ansible \
  && echo ${TMP_PASS} | cntlm -H -d tpplc -u ${LOGNAME} | awk 'NR==4 {print "\nntlm_hash = "$2}' \
  && unset TMP_PASS
```

