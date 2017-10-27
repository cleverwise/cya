## Contributors Readme

Obviously you are free to edit the code on your copy(ies) to tailor the utility for your needs and environments.  Still you are free to submit ideas to Jeremy O'Connell, the lead developer, for consideration to the main branch.  There are contact methods in the README.md file or you may view the Github project page.

**Please read this document as it explains why certain actions were taken for the code.**

## Date Updated: 27 October 2017

### General Points

1) In no way is this code perfect.  There are areas that could be coded better.  After all coding is a journey and not a destination.  However everything has been tested to work on major Linuxes.

2) It should be noted this system is designed to work in many environments and different BASH versions.  So keep in mind while some areas of coding could be streamlined for a specific environment it would break it in others.  Thus some code was chosen not for streamlining but for broader compatibility.

**Remember code in the main branch should have mass compatibility, which again can sometimes limit streamlining**

3) This isn't a game that needs every ounce of speed.  There are no objections to having better code but mass compatibility is key.  So what would be better in some environments would break in others.

This project should attempt to work in as many environments as possible, which does limit speed at times.  Still this utility is very fast and often what is technically slower for a computer can't be detected by us humans.

4) Also keep in mind some coding is six in one and half dozen in another.  There are often multiple ways to code for a specific function so some of the code may or may not be the way you would do it.

5) It goes without saying but any code that is included into the main branch may be edited at the discretion of Jeremy O'Connell.  You may receive credit in the credit section if desired.

### Coding/Design Thoughts

This section will explain why certain functions were chosen and will develop overtime as developers raise questions or make suggestions.

*Order is random*

1) Why was /home/cya used?

See the "Why /home/cya?" section below for a lengthy explanation.

2) Error handling

It should be noted this script has its own error handling formatting, thus you'll see references to it through out the script.

3) Sudo handling

This system was coded with best sudo practices, which means **only** calling sudo when necessary.  One should avoid calling sudo on a whim.  After all running with root privileges should not be taken lightly.  Therefore you'll see sections that call sudo when it is necessary.

4) Curl over wget

While it is understood curl isn't always installed it is considered more secure than wget.  Curl is available in every major *nix, often a quick repo install away, and may be compiled too.  So sorry but wget suggestions will be rejected in favor of the more secure curl.

### Why /home/cya?

This was a year long project.  Well it didn't take a year to write the code but it took well over half a year, due to needing to find time, before any was logic generated.  This allowed Jeremy O'Connell and Joe Collins plenty of time to discuss features, ideas, and layout.

This included where to put the backup files that cya would generate.  This location was not chosen on a whim.  So let's review some of the reasoning behind this choice.

1) You might think why not stick the files in /opt/ or /usr/local/backups/ or something like that?

Well the answer is simple.  We are backing up **ALL** key system directories like /opt/ and /usr/ along with many others!  So if we placed cya data in say /opt/ then cya would be backing up all the data in there on each run!  That is **NOT** good and totally unacceptable!!!

You might think well then just write an exemption for the cya directory.  This was thought about and discussed but in the end we said no.  Why? Well there were also other points to consider; keep reading...

2) After the standard system directories were rejected the idea of creating a new top level directory was entertained.  So in the root filesystem create /cya/ on the same level as say /usr/.

After some discussion we felt creating a new root filesystem directory isn't ideal and generally discouraged by good filesystem layout.  Now you may or may not agree with this but programs in the *nix verse tend to use the existing layout.  So we rejected the idea of creating a top level /cya/.

3) So our options were quickly narrowing.  We couldn't use core system directories as they were being backed up and we didn't like the idea of creating a top level /cya/ directory.  So what was left?

Well our attention turned to /home/.  This directory is on every major *nix system and if it is missing on some edge case it may be created.  We thought great! A directory that already exists so we avoid creating a new top level directory and since cya isn't backing up /home/ it is a win-win! 

However we also realized many systems create the root file system / on one partition and put the bulk of the storage in /home/.  This is especially true for desktops were you'll see say 20-40GB for / and then hundreds GBs or more for /home/.  This means by using /home/ we won't be filling up the space on the root partition like we would have if say /cya/ was created.  So win-win-win!

4) Then the discussion turned toward should we place the files in a user's home directory? For example: /home/joe/cya/ or something similar.

This ended up be rejected after some additional investigation.  Why?

Well there were several reasons: servers (and IoT), backups, and restoring.  So let's look at each one of these.

A) You should keep in mind cya was designed with desktops **AND servers AND IoT** in mind.  This is not just a desktop utility.  So let's say we choose a user's directory.

Dan, an admin, installs cya on a company server and runs cya.  It throws the files into /home/dan/cya.  John comes along and needs to work with cya.  Now John needs to access Dan's home directory.  Does this make any sense?  Not to us.  The files should be stored more centrally and outside of Dan's home directory.

Plus what about IoT devices? These devices can do all kinds of odd things to the /home/DEFAULT_USER directory.  We thought it would be safer outside of that directory.

B) We didn't want to grow a user's home directory thus causing backups to grow unnecessarily.  So let's say we did use /home/mary/cya/ then when Mary backed up her home directory she would be backing up tens of GBs (or more) that are wasting backup space for files she probably doesn't care about having on her backup storage.

This utility is about system restoring not user data restoring.  Plus what happens if Mary wants to transfer her home directory to another system?  Now she has system restore files from another system!  What good is that?!

If Mary wants to backup /home/cya/ that is her call and easy to do, but she and anyone else is opting in and not out.  We felt this was very important that people manually choose to backup cya files and not be "forced" to with their normal backups.  Plus it is very obvious cya is separate and where the files are located.

C) Finally even if we had ignored the two points above it would have made restoring harder.  Not impossible but harder.  By choosing /home/cya the restore system knows where the files are located.

If we had used /home/mary/cya the restore system would have to figure this out *or* written a system file to /home; for example  /home/cya_path.  Therefore either way something was probably going to be written to /home. 

You should keep in mind that cya can completely restore a system even to a blank root partition.  You can literally mount /home and run cya to have it copy **ALL** system directories and files back and thus restore to a complete working state from literally nothing.  So we don't want to depend on anything in the root partition.

Closing thoughts:

The bottom line is /home/cya/ wasn't chosen on a whim.  It was not like we instantly said just throw the data in that directory.  Nope!  It was the topic of much discussion over quite some time.

You may or may not have made the same choice.  However we had to choose something and once we took **ALL** the above points into consideration along with some now probably forgotten /home/cya came out the winner.

This is **NOT** just a desktop tool but a server and IoT tool so you can't make choices based just on desktop systems with a single human user.  While we could have had desktop and server modes this would have added extra complexity for no real gain.  So that too was rejected in the name of keeping things as simple and lean as possible.

If you feel this violates some sacred file structure then edit your local copy or don't use this utility.

