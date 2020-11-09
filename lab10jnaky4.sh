#!/bin/bash
#start of lab10
let n=0
until [ $n -eq 6 ]
do
	let n=0
	echo Hi $USER
	echo Today is $(date)
	echo ====================
	echo       Main Menu
	echo ====================
	echo 1. Operating system info
	echo 2. Network info
	echo 3. Users\'s information
	echo 4. File Operations
	echo 5. Find files
	echo 6. Exit
	echo Enter your choice [ 1 - 6 ]
	read n
	case $n in
			#Operating Sytem
		1)	let m=0
			until [ $m -eq 6 ]
			do
				echo ================
				echo Operating System
				echo ================
				echo 1. Type of OS
				echo 2. Free and used memory
				echo 3. Disk Usage
				echo 4. System uptime
				echo 6. Go back
				echo Enter your choice \[ 1 - 6 \]
				read m
				case $m in
					1) echo "$(uname -a)";;
					2) echo "$(free)";;
					3) echo "$(df)";;
					4) echo "$(uptime)";;
					6) echo going back;;
					*) echo not a valid input;;
				esac	
			done
			
			;;

			#Network interfaces, IP configurations, etc
		2)	echo "$(ifconfig)";;

			#User Operations
		3)	let p=0
			until [ $p -eq 6 ]
			do
				echo ================
				echo User information
				echo ================
				echo 1. who is currently online
				echo 2. last logged in users
				echo 6. Go back
				echo Enter your choice \[ 1 - 6 \]
				read p
				case $p in
					1) echo "$(w)";;
					2) echo "$(last)";;
					6) echo going back;;
					*) echo not a valid input;;
				esac	
			done
			;;

			#File Operations
		4) 	let q=0
			until [ $q -eq 7 ]
			do
				echo ===============
				echo File Operations
				echo ===============
				echo 1. Create a file
				echo 2. Delete a file
				echo 3. Create a directory
				echo 4. Delete a directory
				echo 5. compress files
				echo 6. Decompress an archive
				echo Enter your choice \[ 1 - 6 \]
				read q
				case $q in
					1)	echo Enter the file to be created
						read t
						if test -f "$t";
						then
							echo Do you really want to overwrite $t? \(y\/n\)\:
							read a
							case $a in
								y)	$(touch $t)
									echo overwritten;;
								n)	echo not overwritten;;
								*) 	echo no a valid input;;
							esac
						else	
							$(touch $t)
						fi
						;;
						
					2)	echo Enter the file to be deleted
						read t
						if $(rm $t);
						then
							echo sucessfully deleted
						else
							echo deletion failed
						
						fi
						;;
					3)	echo Enter the directory to be created
						read t
						$(mkdir $t)
						echo Specify the permissions to set for this new directory \(4 Octal Digits \)\:
						read u
						$(chmod $u $t)
						;;
					4)	echo Enter the directory to be deleted
						read t
						if $(rmdir $t);
						then
							echo sucessfully deleted
						else
							echo deletion failed
						fi
						;;
					5)	echo Enter the wildcard expression to archive matching files
						read t
						$(tar -cf archive$t.tar *.$t)
						#$(find ~ -name "*.$t" | tar -cf archive$t.tar -T - -C .)
						;;
					6)	echo Enter the name of the archive to decompress
						read t
						$(tar -xvf $t)
						;;
					7) echo going back;;
					*) echo not a valid input;;
				esac
			done
			;;
			#Create a file
				#Check if exists
				#if it does prompt user to overrwrite(y/n)
			#delete a file
				#check if deletion was sucessful
			#Create a Directory
				#ask octal permissions
			#Delete a Directory
				#check if deletion was sucessful
			#compress a file
			#Decompress an archive

		5) 	#Find Files
			let s=0
			until [ $s -eq 6 ]
			do
				echo ==========
				echo Find Files
				echo ==========
				echo 1. Fine files by modification time
				echo 2. Find by extension
				echo 5. Go back
				echo Enter your choice \[ 1 - 6 \]
				read s
				case $s in
					1)	echo Enter the minimum number of days passed since modification
						read t
						echo "$(find ~ iname "*" -mtime -$t )"
						echo Do you want to back up these files? \(y\/n\)\:
						read u
						case $u in
							y)
								$(find ~ iname "*" -mtime -$t | tar -cf archive$t.tar -T -)
								;;
							n)	echo not backed up;;
							*)	echo not a valid input;;
						esac
						;;
						
					2)	echo Enter the extension \(ex. \"txt\" to search for \> html
						read t
						echo "$(find ~ -type f -name "*.$t" )"
						;;
					6) echo going back;;
					*) echo not a valid input;;
				esac
			done
			;;
			
			#find files that were modified in the last num days
			#specified by user
				#ask if they want to backup
				#back up to backup_bonus.tar
				#if exists overrwrite
			#find all files of specific extension
				#prompt new extention 
				#pdf -> all txt become pdf
				
		6)	echo bye;;
		*) 	echo not a valid input;;
	esac
done
