# Sets reasonable macOS defaults.
#
# Or, in other words, set shit how I like in macOS.
#
# The original idea (and a couple settings) were grabbed from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.macos
#
# Run ./set-defaults.sh and you'll be good to go.

# Disable press-and-hold for keys in favor of key repeat.
defaults write -g ApplePressAndHoldEnabled -bool false

# Always open everything in Finder's list view. This is important.
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Show the ~/Library folder.
chflags nohidden ~/Library

# Set a really fast key repeat.
defaults write NSGlobalDomain KeyRepeat -int 1

# Set the Finder prefs for showing a few different volumes on the Desktop.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Tap to click setting
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Right click bottom right corner
defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true

# Set the date format in the OSX Bar
defaults write com.apple.menuextra.clock "DateFormat" "EEE d MMM h:mm:ss a"
# Set the battery percent
defaults write com.apple.menuextra.battery ShowPercent YES
# For the UI settings to take effect
killall SystemUIServer

# Set the dock preferences to left, size, don't show recent applications
defaults write com.apple.dock tilesize -int 42
defaults write com.apple.Dock orientation -string "left"
defaults write com.apple.dock show-recents -bool FALSE
killall Dock

# Power set display sleep 'never' on adapter, 25m on battery
sudo pmset sleep 0
sudo pmset -a displaysleep 0
sudo pmset -b displaysleep 25

# Power disable slightly dimming display on battery
sudo osascript <<EOD
tell application "System Preferences"
	activate
	reveal (pane id "com.apple.preference.energysaver")
end tell
delay 0.5
tell application "System Events"
	-- If we don't have UI Elements enabled, then nothing is really going to work.
	if UI elements enabled then
		tell application process "System Preferences" to tell window "Energy Saver" to tell tab group 1
			click radio button "Battery"
			set theCheckbox to checkbox "Slightly dim the display while on battery power" of list 2
			tell theCheckbox
				if (its value as boolean) then click theCheckbox
			end tell
		end tell
		tell application "System Preferences" to quit
	else
		-- GUI scripting not enabled.  Display an alert
		tell application "System Preferences"
			activate
			set current pane to pane "com.apple.preference.energysaver"
			display dialog "UI element scripting is not enabled. Please activate \"Enable access for assistive devices\""
		end tell
	end if
end tell
EOD

# Set use function-keys and hide input menu bar
sudo osascript <<EOD
tell application "System Preferences"
	activate
	reveal (pane id "com.apple.preference.keyboard")
end tell
delay 0.5
tell application "System Events"
	-- If we don't have UI Elements enabled, then nothing is really going to work.
	if UI elements enabled then
		tell application process "System Preferences" to tell window "Keyboard" to tell tab group 1
			click radio button "Keyboard"
			set theCheckbox to checkbox "Use F1, F2, etc. keys as standard function keys"
			tell theCheckbox
				if not (its value as boolean) then click theCheckbox
			end tell

			click radio button "Input Sources"
			set theCheckbox to checkbox "Show Input menu in menu bar"
			tell theCheckbox
				if (its value as boolean) then click theCheckbox
			end tell
		end tell
		tell application "System Preferences" to quit
	else
		-- GUI scripting not enabled.  Display an alert
		tell application "System Preferences"
			activate
			set current pane to pane "com.apple.preference.keyboard"
			display dialog "UI element scripting is not enabled. Please activate \"Enable access for assistive devices\""
		end tell
	end if
end tell
EOD

# trackpad sensitivity and mission control four fingers slide setting
sudo osascript <<EOD
set trackingValue to 4
tell application "System Preferences"
	activate
	reveal (pane id "com.apple.preference.trackpad")
end tell
delay 0.5
tell application "System Events"
	-- If we don't have UI Elements enabled, then nothing is really going to work.
	if UI elements enabled then
		tell application process "System Preferences" to tell window "Trackpad"
			click radio button "Point & Click" of tab group 1
			set value of slider 1 of tab group 1 to trackingValue

			click radio button "More Gestures" of tab group 1
			tell menu button 3 of tab group 1
				click
				click menu item "Swipe up with four fingers" of menu 1
			end tell
		end tell
		tell application "System Preferences" to quit
	else
		-- GUI scripting not enabled.  Display an alert
		tell application "System Preferences"
			activate
			set current pane to pane "com.apple.preference.trackpad"
			display dialog "UI element scripting is not enabled. Please activate \"Enable access for assistive devices\""
		end tell
	end if
end tell
EOD

# 3-finger drag
sudo osascript <<EOD
tell application "System Preferences"
	activate
	reveal (pane id "com.apple.preference.universalaccess")
end tell
delay 0.5
tell application "System Events"
	-- If we don't have UI Elements enabled, then nothing is really going to work.
	if UI elements enabled then
		tell application process "System Preferences" to tell window "Accessibility"
			tell scroll area 1 to tell table 1 to tell row 14 #open Pointer Control
				select
			end tell
			tell group 1 to tell tab group 1 to tell button "Trackpad Options…"
				click
			end tell
			set theCheckbox to checkbox "Enable dragging" of sheet 1
			tell theCheckbox
				if not (its value as boolean) then click theCheckbox
			end tell
			tell pop up button 1 of sheet 1
				click
				delay 0.1
				click menu item "three finger drag" of menu 1
			end tell
			click button "OK" of sheet 1
		end tell
		tell application "System Preferences" to quit
	else
		-- GUI scripting not enabled.  Display an alert
		tell application "System Preferences"
			activate
			set current pane to pane "com.apple.preference.universalaccess"
			display dialog "UI element scripting is not enabled. Please activate \"Enable access for assistive devices\""
		end tell
	end if
end tell
EOD

# Set screen resolution to more space and don't auto adjust brightness
sudo osascript <<EOD
tell application "System Preferences"
	activate
	reveal (pane id "com.apple.preference.displays")
end tell
delay 0.5
tell application "System Events"
	-- If we don't have UI Elements enabled, then nothing is really going to work.
	if UI elements enabled then
		tell application process "System Preferences" to tell window "Built-in Retina Display"
			tell tab group 1
				set theCheckbox to checkbox "Automatically adjust brightness"
				tell theCheckbox
					if (its value as boolean) then click theCheckbox
				end tell
				click radio button "Scaled"
				tell radio group 1 of group 1
					click radio button 4
				end tell
			end tell
		end tell
		tell application "System Preferences" to quit
	else
		-- GUI scripting not enabled.  Display an alert
		tell application "System Preferences"
			activate
			set current pane to pane "com.apple.preference.displays"
			display dialog "UI element scripting is not enabled. Please activate \"Enable access for assistive devices\""
		end tell
	end if
end tell
EOD

# Sound enable menu bar
sudo osascript <<EOD
tell application "System Preferences"
	activate
	reveal (pane id "com.apple.preference.sound")
end tell
delay 0.5
tell application "System Events"
	-- If we don't have UI Elements enabled, then nothing is really going to work.
	if UI elements enabled then
		tell application process "System Preferences" to tell window "Sound"
			set theCheckbox to checkbox "Show volume in menu bar"
			tell theCheckbox
				if not (its value as boolean) then click theCheckbox
			end tell
		end tell
		tell application "System Preferences" to quit
	else
		-- GUI scripting not enabled.  Display an alert
		tell application "System Preferences"
			activate
			set current pane to pane "com.apple.preference.sound"
			display dialog "UI element scripting is not enabled. Please activate \"Enable access for assistive devices\""
		end tell
	end if
end tell
EOD

# Show bluetooth input bar 
sudo osascript <<EOD
tell application "System Preferences"
	activate
	reveal (pane id "com.apple.preferences.bluetooth")
end tell
delay 0.5
tell application "System Events"
	-- If we don't have UI Elements enabled, then nothing is really going to work.
	if UI elements enabled then
		tell application process "System Preferences" to tell window "Bluetooth"
			set theCheckbox to checkbox "Show Bluetooth in menu bar"
			tell theCheckbox
				if not (its value as boolean) then click theCheckbox
			end tell
		end tell
		tell application "System Preferences" to quit
	else
		-- GUI scripting not enabled.  Display an alert
		tell application "System Preferences"
			activate
			set current pane to pane "com.apple.preferences.bluetooth"
			display dialog "UI element scripting is not enabled. Please activate \"Enable access for assistive devices\""
		end tell
	end if
end tell
EOD

# Enable SSH
sudo osascript <<EOD
tell application "System Preferences"
	activate
	reveal (pane id "com.apple.preferences.sharing")
end tell
delay 0.5
tell application "System Events"
	-- If we don't have UI Elements enabled, then nothing is really going to work.
	if UI elements enabled then
		tell application process "System Preferences" to tell window "Sharing"
			set theRow to item 1 of (rows of table 1 of scroll area 1 of group 1 whose value of static text 1 is "Remote Login")
			if (value of checkbox 1 of theRow) is equal to 0 then click checkbox 1 of theRow
		end tell
		tell application "System Preferences" to quit
	else
		-- GUI scripting not enabled.  Display an alert
		tell application "System Preferences"
			activate
			set current pane to pane "com.apple.preferences.sharing"
			display dialog "UI element scripting is not enabled. Please activate \"Enable access for assistive devices\""
		end tell
	end if
end tell
EOD
