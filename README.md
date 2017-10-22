## Bootstap
```
sudo apt-get install -y python-pip git \
&& sudo pip install ansible \
&& git clone https://github.com/OurFriendIrony/ubuntu-setup.git /tmp/ansible \
&& cd /tmp/ansible \
&& git checkout ansiblise
```

## Run
`./go.sh -p ubuntu -s -d`

## Help
`./go.sh -h`

## Module index
All Modules are documented [**here**](http://docs.ansible.com/ansible/latest/list_of_all_modules.html)

___
## Bugs
- prereqs
  - autoremove failed
  - autoclean failed
- powerline-shell
  - thinks it wants to install sysmonitor
- vim
  - doesnt have Plugins applied for user
  