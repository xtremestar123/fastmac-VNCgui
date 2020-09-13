# disable spotlight indexing
sudo mdutil -i off -a
echo Edit script-mac.sh in your fastmac repo to auto-run commands in your Mac instances

#Create new account
sudo dscl . -create /Users/vncuser UserShell /bin/bash
sudo dscl . -create /Users/vncuser RealName "VNC User"
sudo dscl . -create /Users/vncuser UniqueID 1001
sudo dscl . -create /Users/vncuser PrimaryGroupID 1000
sudo dscl . -create /Users/vncuser NFSHomeDirectory /Local/Users/vncuser
sudo dscl . -passwd /Users/vncuser secretpassword
sudo dscl . -append /Groups/admin GroupMembership vncuser

#Enable VNC
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -allowAccessFor -allUsers -privs -all
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -clientopts -setvnclegacy -vnclegacy yes 

#vnc password set workaround?
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -clientopts -setvncpw -vncpw hello
#VNC password - http://hints.macworld.com/article.php?story=20071103011608872
#this sets it to 'hello', use the script linked to set it to your own
#sudo echo 7F513D02E4A8C5E2FF1C39567390ADCA > /Library/Preferences/com.apple.VNCSettings.txt

#Start VNC/reset changes
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -restart -agent -console
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate

#install ngrok, don't forget your key at https://dashboard.ngrok.com/auth
brew cask install ngrok

echo you'll need to do a couple things from SSH...
echo sudo echo 7F513D02E4A8C5E2FF1C39567390ADCA > /Library/Preferences/com.apple.VNCSettings.txt
echo sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -restart -agent -console
echo sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate

echo At this point ngrok authtoken AUTH_TOKEN_HERE and then ngrok tcp 5900 and hop in, your vnc pass is "hello" and the vncuser pass is "secretpassword"
