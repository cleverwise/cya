# CYA .:. Cover Your Ass(ets)

This open source and freely available tool is written to run in the BASH shell and allows for easy snapshots and rollbacks of your Linux (any flavor) or other *nix operating system.  It is filesystem agnostic (EXT2/3/4, XFS, UFS, GPFS, reiserFS, JFS, BtrFS, ZFS), easy to remove, and is portable.  Plus, obviously, you are free to verify all the code.  This system only backups and restores the operating system itself and not your actual user data.  **This is a system restore utility.**

The underlying backup method is actually rsync -  a well known and vetted system.  However CYA makes it super simple to create rolling backups.  This is because with a **single command** it will copy all key directories like /bin/ /lib/ /usr/ /var/ and several others.  You are even free to add your own unique directories and files into the configuration so CYA will pick those up as well.  It is also possible to configure the system to skip subdirectories so if you don't want /var/logs/ backed up with the /var/ directory no problem.

When it comes time to restore CYA will rollback your operating system using the backup profile you specify.  This undoes the damage caused by bad updates, configuration changes, intrusions/hacks, etc! These files are stored so you may easily access them even without a complete rollback using your terminal or file manager.  This way if you change a configuration file you may manually restore that single file without having to restore the whole system.

However CYA does allow for partial restores, for example just a single directory.  You are also able to generate a custom recovery script to automate the mounting of your system partition(s) when you restore off a live CD, USB, or network image.

There are many other features such as the system will keep three separate copies, which is configurable.  So that way you have multiple restore points.  Then on the fourth snapshot it will overwrite the first, on the fifth it will overwrite the second, etc.  As stated the number is configurable.  You may also create long term backups that are kept until you delete them.  An archiving function is also included in this powerful utility.

CYA even supports mixing all three methods at the same time: rotating, manual, and archiving.  However best of all these processes may be automated with crontab, anacron, systemd, etc.

**As stated above this utility does NOT touch data outside of configured directories.  Therefore your personal data is safe!**

More information: [https://www.cyberws.com/bash/cya/](https://www.cyberws.com/bash/cya/)

Need help using CYA? [Youtube Instruction Videos](https://www.youtube.com/watch?v=fdH3Um4XNUs&list=PL7DdW0jxJRrEQfKXeuIzTWmPyomIp4k4Y)

----

## Updates

* Follow this page
* [Follow on Youtube](https://www.youtube.com/channel/UCeQtI9fcAapQkiHph42NjWA)
* [Follow on Facebook](https://www.facebook.com/cyberwscom/)

## Contribute/Contact

If contacting for technical support please see video manuals first.  I'll do my best to help troubleshoot but can't make any promises due to limited time.

* Message through Github
* [Contact Form on CyberWS](https://www.cyberws.com/contact-us/)

## Installing

This is a very easy utility to install.  You simply need to put the file **cya** on your system and turn on executable permissions like chmod 700 or 755.  It is suggested you place the file in either **/home/YOUR_USER/bin/** or **/usr/local/bin/** depending on who you want using this program.  Once that step has been done simply run the command from the commandline.

To bring up a list of commands:

shell> **cya help**

If you are on Linux you should run the following command:

shell> **cya script**

Now copy the resulting **recovery.sh** to a USB stick.  This will aid you in mounting your drive(s) and setting up a chrooted environment so your system is ready to accept a rollback.  Otherwise you can do this manually (see the Recovery section below).

### Storing Data

CYA stores all backups and configuration data in **/home/cya/** with backups stored in **/home/cya/points/BACKUP_NAME**.  If you wish to alter the system edit the configuration file at **/home/cya/cya.conf**

### Removing

What? You want to remove CYA? Why!? :-(

1) Stop any backup processes then disable and remove systemd units, crontab entries, or anacron entries.
2) Remove the **cya** file itself; where ever you installed it.  If necessary use whereis or find commands to locate the file.
3) Finally delete the directory **/home/cya/**
4) Done.  Now reinstall it right? ;-)

Note: If you performed a restore using cya then in your root file system you'll find **CYA_LOG** file which contains date and time along with directories restored.

###	Generating Snapshots/Backups

There are multiple methods that may be issued from the commandline or called from automated sources like systemd, cron, or anacron.

1) For standard rolling backups that keeps three snapshots before overwriting simply use the command: 

shell> **cya save**

2A) To provide a custom name for a backup that will **NOT** be overwritten: 

shell> **cya keep**

Script friendly version:

shell> **cya keep name BACKUP_NAME**

The BACKUP_NAME must be unique each time you run the script (see #3).  So using this method in a script attach a time stamp or random string.

2B) To provide a custom name for a backup that **WILL** overwrite:

shell> **cya keep name BACKUP_NAME overwrite**

Note the overwrite flag, which tells cya it is okay to overwrite files in backup profile.

2C) To backup and archive which will tar and gzip then move file to **/home/cya/archives** directory use the archive tag

shell> **cya keep name BACKUP_NAME archive**

This command *IS script safe* as a unix timestamp will be added to make unique filenames.  Also note this option will remove the backup profile directory and backup will *NOT* appear in the back up list.

###	Recovery

If you find your system in a situation where things aren't right then it is time to restore it.  Now should you have a known single file issue it would be faster to restore that single file, however you will need to watch out for ownership and permissions.  Thus the cp command may or may not be enough depending on the situation.

Still if you have a more major issue or you aren't sure of the trouble then a full rollback is in order.

You may do this totally manually or if on Linux use the **recovery.sh** file assuming you created one.  You see for best success you really should do the recovery in a live environment booted from a disc, USB, or network image.  Why?  Because you'll need to overwrite running files that are locked.  So ideally these files should **NOT** be loaded and in use thus the need for a live environment.

**Notice: For best results use a live boot environment from same major version as your installed environment!** It has been discovered that mixing versions can cause issues.  For example your installed system is 16.04 and you use a 17.10 boot image.  While it might seem like it shouldn't matter it does at times.  So if on 16.04 use a 16.04 boot image.

1) Boot off a live image on disc, USB, or network.
2) Mount your drive(s) so your system's / and /home are mounted to the **/mnt/cya** directory. This is made really easy and handled automatically by the **recovery.sh** script for Linux users.  If you wish to do this manually see "Setting Up Restore Environment Manually" below.
3) Now run **sudo /mnt/cya/home/cya/cya restore** and follow the onscreen instructions.  This will be done automatically when using the **recovery.sh** script.
4) Once files have been restored restart your system along with ejecting any images so your system boots off the recovered installed OS.
5) Done.  You should now be in your recovered operating system.  Now don't forget to run any necessary updates (unless updating was the issue and you need to do some research).

##### Setting Up Restore Environment Manually

1) Boot off a live image on disc, USB, or network.
2) At the command prompt create a directory to be used to mount your drive(s).  For example /mnt/cya  
shell> **sudo mkdir -p /mnt/cya**
3) Now you need to mount your / and /home (if on another partition) into the /mnt/cya point.  Below are **ONLY** examples:
shell> sudo mount /dev/sda1 /mnt/cya  
shell> sudo mount /dev/sda3 /mnt/cya/home
4) Now execute the restore command to start the process  
shell> **sudo /mnt/cya/home/cya/cya restore**

## Customizing

#### Adding Directories

1) Open the following file in your text editor /home/cya/cya.conf
2) Add or edit the following variable

BACKUP_DIRECTORIES=””

Now between the quotes add the directories separated by a space.

Example:

BACKUP_DIRECTORIES=”/tmp/ /important/ /myfiles/configuration/”

3) Once completed save and close file.  You may verify by running the following command:

shell> cya directories

#### Exclude Subdirectories

1) Open the following file in your text editor /home/cya/cya.conf
2) Now simply type EXCLUDE (all uppercase) then underscore then parent directory with slashes and between quotes add children directories separated by a space. IMPORTANT: Subdirectories should NOT include the parent directory. NO FORWARD SLASHES FOR CHILDREN DIRECTORIES!

Example:

Let’s say we want to exclude /var/tmp/ and /var/logs/ which are inside /var/, obviously.

EXCLUDE_/var/=”tmp/ logs/”  

You simply repeat for additional directories with EXCLUDE_/dir/ one per line.
Example:

EXCLUDE_/etc/=”logs/ conf/”  
EXCLUDE_/var/=”tmp/ logs/”  

3) Once completed save and close file. 

#### Add specific files to include in backup:

You are able to backup specific files instead of whole directories.  You should keep in mind this is only necessary for directories not included in the backup.  Also files will be stored in a subdirectory called "**cya-backup-files**" inside the backup profile directory.

1) Open the following file in your text editor /home/cya/cya.conf
2) Add or edit the following variable:

BACKUP_FILES=""

Now between the quotes add the full path to files separated by a space.

Example:

BACKUP_FILES="/custom/my_log /custom/sudir/config /app2/config/settings" 

#### Alter number of rotation backups:

The default number of backups before rotating when using "**cya save**" is three (3).  However you may wish to change this number.  This is very easy.

1) Open the following file in your text editor /home/cya/cya.conf
2) Add or edit the following variable while placing the new number between quotes.

Example:

Let's say you want to alter this number to six (6) backups.

MAX_SAVES="6"

Note: If you reduce the number higher profiles will NOT be removed.  So if you go from ten (10) to five (5) cya will start rotating at five (5) but backups six to ten will remain unless you remove them.

#### Disable Disclaimer

1) Open the following file in your text editor /home/cya/cya.conf
2) Add the following variable on its own line:
DISCLAIMER="off"
3) Once completed save and close file.  

#### Changing Name Of A Backup Profile

If you wish to rename a backup profile simply alter the name of the directory/folder in **/home/cya/points** to the desired name.  That's it.  However if you have scheduled tasks that call the backup profile then you'll need to edit your command call to the new name.

## Scheduling

### Wrapper

You'll find a wrapper file in the wrapper directory.  This is provided just in case your environment requires such a file.  You see some setups will allow you to execute CYA directly from a scheduler.  Others however will fail because they start in a SH environment and don't want to switch to BASH.

Therefore if your system doesn't like calling CYA directly then use the wrapper script to call CYA and use your scheduled method: SystemD, cron, anacron, etc to call the wrapper script.

#### SystemD

In this project is a systemd directory which contains two files to get CYA working with systemd.  *If necessary use the wrapper file!*

1) cya.service = This sets up the service for systemd.  **You'll need to edit this file** to change the path to where you installed the CYA program.  Plus if you want to use the manual backup method you'll need to alter the command path.

Look for the following line to modify:

**ExecStart=/home/USER/bin/cya save**

2) cya.timer = This sets up the time systemd run CYA.  The file included will run a backup once a week.  This may or may not be enough for your situation.  If a week works for you then no need to change this file.

If you want something other than week modify:

**OnCalendar=weekly**

3) To setup upload both cya.service and cya.timer to **/etc/systemd/system/** and chmod 644 both of them

4) Now enable the cya.timer unit by issuing the following two commands at the prompt:

shell> **sudo systemctl enable cya.timer**  
shell> **sudo systemctl start cya.timer**

That's it! If you want to see the status issue the following command at the prompt:

shell> **sudo systemctl status cya**

Notes:
* If you want multiple intervals you'll need to create multiple sets of these files and alter the command and timing functions accordingly.  For example: cya-weekly.service and cya-weekly.timer, cya-monthly.service and cya-monthly.timer, cya-daily.service and cya-daily.timer
* To remove the systemd units issue the following command:

shell> **sudo systemctl disable cya.timer**

Now delete cya.service and cya.timer files.  That's it.

#### Crontab

It is recommended you crontab this using root or setup a user that doesn't need to enter a sudo password.  *If necessary use the wrapper file!*

The example entry below will run cya at every Monday at 2:05 am with output dumped into /dev/null.

5 2 * * 1 /home/developer/bin/cya save >/dev/null 2>&1

