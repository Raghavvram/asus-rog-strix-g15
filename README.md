# asus-rog-strix-g15
config files specific to ASUS ROG STRIX G15


## How to use
##### Make the script executable
```bash
chmod +x ~/toggle_power_profile.sh
```

#### Find the appropriate keybinding you want to use (in my case its XF86Launch4) then add this entry in your Hyprland Keybinding.conf file
```bash
bind = XF86Launch4, exec, ~/toggle_power_profile.sh
```
