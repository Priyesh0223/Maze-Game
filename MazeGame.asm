#-----------------------------------------------------------------------------
# Maze Game By Priyesh Patel
# A game where the player collects gems and avoids an enemy throughtout mazes
# All gems must be collected to move to the next level
# The Enemy moves twices for eveny one movement the player makes
#-----------------------------------------------------------------------------
# Instructions:
#   Set pixel dimensions to 32x32
#   Set display dimensions to 512x512
#   Set base address for display to $gp
#   Connect display and keyboard to MIPS and Run
#-----------------------------------------------------------------------------
# Constants:
.eqv WIDTH  16  # Width of screen in pixels 512/32 = 16
.eqv HEIGHT 16 	# Height of screen in pixels 512/32 = 16
# Colors:
.eqv 	RED 	0x00FF0000	
.eqv 	GREEN	0x0035BA35 
.eqv 	BLUE	0x001E90FF
.eqv 	WHITE	0x00FFFFFF
.eqv 	ORANGE  0x00FF8C00	
.eqv	BLACK   0x00000000

.data
#all array are used to display the bitmap
#each array element corresponds to the bitmap position
#each individual number corresponds to a color in the color scheme

#----------Final Winner Screen---------
winner_TitleDisplay: .word
	1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
	0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
	1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	2,2,0,0,0,0,0,2,0,0,0,0,0,2,0,2
	2,2,0,2,2,2,0,2,0,2,2,2,0,2,0,2
	2,2,0,2,2,2,2,2,0,2,2,2,2,2,0,2
	2,2,0,2,0,0,0,2,0,2,0,0,0,2,0,2
	2,2,0,2,2,2,0,2,0,2,2,2,0,2,0,2
	2,2,0,2,2,2,0,2,0,2,2,2,0,2,2,2
	2,2,0,2,2,2,0,2,0,2,2,2,0,2,0,2
	2,2,0,0,0,0,0,2,0,0,0,0,0,2,0,2
	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
	0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
	1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
#-----------Loser Screen---------------	
loser_TitleDisplay: .word
	4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	0,0,0,4,0,0,0,4,0,0,0,0,0,4,0,0
	0,4,4,4,0,4,0,4,0,4,0,4,0,4,0,4
	0,4,0,4,0,0,0,4,0,4,0,4,0,4,0,0
	0,4,0,4,0,4,0,4,0,4,4,4,0,4,0,4
	0,0,0,4,0,4,0,4,0,4,4,4,0,4,0,0
	4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	4,0,0,0,4,0,4,0,4,0,0,4,0,0,0,4
	4,0,4,0,4,0,4,0,4,0,4,4,0,4,0,4
	4,0,4,0,4,0,4,0,4,0,0,4,0,0,4,4
	4,0,4,0,4,0,4,0,4,0,4,4,0,4,0,4
	4,0,0,0,4,4,0,4,4,0,0,4,0,4,0,4
	4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
#-----------All Level 1 Data-----------
level1_TitleDisplay: .word
	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2   
	2,0,2,2,0,0,2,0,2,0,2,0,0,2,0,2
	2,0,2,2,0,2,2,0,2,0,2,0,2,2,0,2
	2,0,2,2,0,0,2,0,2,0,2,0,0,2,0,2
	2,0,2,2,0,2,2,0,2,0,2,0,2,2,0,2
	2,0,0,2,0,0,2,2,0,2,2,0,0,2,0,0
	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	2,2,2,2,2,2,2,0,2,2,2,2,2,2,2,2
	2,2,2,2,2,2,0,0,2,2,2,2,2,2,2,2
	2,2,2,2,2,2,2,0,2,2,2,2,2,2,2,2
	2,2,2,2,2,2,2,0,2,2,2,2,2,2,2,2
	2,2,2,2,2,2,2,0,2,2,2,2,2,2,2,2
	2,2,2,2,2,2,2,0,2,2,2,2,2,2,2,2
	2,2,2,2,2,0,0,0,0,0,2,2,2,2,2,2
	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
level1_PlayerX: .word 9
level1_PlayerY: .word 3
level1_EnemyX:	.word 6
level1_EnemyY:	.word 3
level1_GemCount:.word 10	
level1_Display:	.word   
	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	1,3,0,0,0,1,1,1,1,1,1,0,0,0,3,1
	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	1,0,0,1,0,0,0,0,0,0,0,0,1,0,0,1
	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	1,1,0,0,0,3,0,1,1,0,3,0,0,0,1,1
	1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1
	1,1,0,3,0,1,0,5,5,0,1,0,3,0,1,1
	1,1,0,0,0,1,0,5,5,0,1,0,0,0,1,1
	1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1
	1,1,0,0,0,3,0,1,1,0,3,0,0,0,1,1
	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	1,0,0,1,0,0,0,0,0,0,0,0,1,0,0,1
	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	1,3,0,0,0,1,1,1,1,1,1,0,0,0,3,1
	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
#-----------All Level 2 Data-----------
level2_TitleDisplay: .word
	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2   
	2,0,2,2,0,0,2,0,2,0,2,0,0,2,0,2
	2,0,2,2,0,2,2,0,2,0,2,0,2,2,0,2
	2,0,2,2,0,0,2,0,2,0,2,0,0,2,0,2
	2,0,2,2,0,2,2,0,2,0,2,0,2,2,0,2
	2,0,0,2,0,0,2,2,0,2,2,0,0,2,0,0
	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	2,2,2,2,2,2,0,0,0,0,2,2,2,2,2,2
	2,2,2,2,2,2,2,2,2,0,2,2,2,2,2,2
	2,2,2,2,2,2,2,2,2,0,2,2,2,2,2,2
	2,2,2,2,2,2,0,0,0,0,2,2,2,2,2,2
	2,2,2,2,2,2,0,2,2,2,2,2,2,2,2,2
	2,2,2,2,2,2,0,2,2,2,2,2,2,2,2,2
	2,2,2,2,2,2,0,0,0,0,2,2,2,2,2,2
	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
level2_PlayerX: .word 12
level2_PlayerY: .word 11
level2_EnemyX:	.word 14
level2_EnemyY:	.word 14
level2_GemCount:.word 8	
level2_Display:	.word   
	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	1,3,0,0,1,0,0,0,0,0,3,1,0,0,3,1
	1,0,0,0,1,0,0,0,0,0,0,1,0,0,0,1
	1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1
	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	1,0,0,0,0,0,0,0,0,0,1,1,1,0,0,1
	1,1,1,1,0,0,0,1,0,0,0,1,3,0,0,1
	1,0,0,0,0,0,0,1,0,0,0,1,0,0,0,5
	1,0,0,3,0,0,0,1,0,0,0,1,1,1,1,1
	1,0,0,0,0,0,0,1,0,0,0,0,0,0,3,1
	1,1,1,1,0,0,0,1,0,0,0,0,0,0,0,1
	1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1
	1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1
	1,0,0,0,1,0,0,0,0,0,1,0,0,0,0,1
	1,3,0,0,1,0,0,3,0,0,1,0,0,0,0,1
	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
#-----------All Level 3 Data-----------
level3_TitleDisplay: .word
	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2   
	2,0,2,2,0,0,2,0,2,0,2,0,0,2,0,2
	2,0,2,2,0,2,2,0,2,0,2,0,2,2,0,2
	2,0,2,2,0,0,2,0,2,0,2,0,0,2,0,2
	2,0,2,2,0,2,2,0,2,0,2,0,2,2,0,2
	2,0,0,2,0,0,2,2,0,2,2,0,0,2,0,0
	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	2,2,2,2,2,2,0,0,0,0,2,2,2,2,2,2
	2,2,2,2,2,2,2,2,2,0,2,2,2,2,2,2
	2,2,2,2,2,2,2,2,2,0,2,2,2,2,2,2
	2,2,2,2,2,2,0,0,0,0,2,2,2,2,2,2
	2,2,2,2,2,2,2,2,2,0,2,2,2,2,2,2
	2,2,2,2,2,2,2,2,2,0,2,2,2,2,2,2
	2,2,2,2,2,2,0,0,0,0,2,2,2,2,2,2
	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
level3_PlayerX: .word 10
level3_PlayerY: .word 6
level3_EnemyX:	.word 10
level3_EnemyY:	.word 8
level3_GemCount:.word 10	
level3_Display:	.word   
	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	1,3,0,0,0,0,0,0,0,0,0,0,0,0,3,1
	1,0,1,1,0,0,3,1,1,1,1,0,0,1,0,1
	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1
	1,0,0,1,3,0,0,0,1,0,0,0,3,0,0,1
	1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1
	1,0,1,1,1,1,0,3,0,0,0,0,1,0,0,1
	1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1
	1,0,0,0,0,0,0,0,0,1,1,0,1,3,0,1
	1,0,0,1,0,0,0,0,0,0,0,0,1,0,0,1
	1,0,0,1,0,3,0,0,0,0,0,0,0,0,0,1
	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	1,0,0,1,0,1,1,0,0,0,1,1,1,3,0,1
	1,3,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	1,1,1,1,1,1,1,5,5,1,1,1,1,1,1,1
#-----------All Level 4 Data-----------
level4_TitleDisplay: .word
	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2   
	2,0,2,2,0,0,2,0,2,0,2,0,0,2,0,2
	2,0,2,2,0,2,2,0,2,0,2,0,2,2,0,2
	2,0,2,2,0,0,2,0,2,0,2,0,0,2,0,2
	2,0,2,2,0,2,2,0,2,0,2,0,2,2,0,2
	2,0,0,2,0,0,2,2,0,2,2,0,0,2,0,0
	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	2,2,2,2,2,2,0,2,2,0,2,2,2,2,2,2
	2,2,2,2,2,2,0,2,2,0,2,2,2,2,2,2
	2,2,2,2,2,2,0,2,2,0,2,2,2,2,2,2
	2,2,2,2,2,2,0,0,0,0,2,2,2,2,2,2
	2,2,2,2,2,2,2,2,2,0,2,2,2,2,2,2
	2,2,2,2,2,2,2,2,2,0,2,2,2,2,2,2
	2,2,2,2,2,2,2,2,2,0,2,2,2,2,2,2
	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
level4_PlayerX: .word 1
level4_PlayerY: .word 1
level4_EnemyX:	.word 1
level4_EnemyY:	.word 6
level4_GemCount:.word 11	
level4_Display:	.word   
	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	1,0,0,1,3,0,0,0,0,0,0,0,0,3,1,1
	1,0,0,1,0,0,0,0,1,0,0,0,0,0,0,1
	1,0,0,1,0,1,1,1,1,1,1,0,0,0,0,1
	1,0,0,0,0,0,0,0,0,3,1,0,0,0,0,1
	1,1,1,1,0,0,1,1,0,0,1,0,0,1,0,1
	1,0,0,0,0,0,3,1,0,0,1,0,0,1,0,1
	1,0,0,0,0,0,0,1,0,0,3,0,0,1,0,5
	1,0,0,0,0,0,0,1,0,0,0,0,0,1,0,1
	1,0,0,0,0,0,1,1,0,0,1,0,0,1,0,1
	1,3,0,0,0,0,3,0,0,0,1,0,0,0,0,1
	1,1,1,1,0,0,0,0,0,0,1,0,0,0,3,1
	1,0,0,0,0,0,0,0,0,0,1,0,1,1,1,1
	1,0,0,1,1,1,1,1,0,0,1,0,0,3,0,1
	1,3,0,0,0,0,0,3,0,0,0,0,0,0,0,1
	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
#-----------All Level 5 Data-----------
level5_TitleDisplay: .word
	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2   
	2,0,2,2,0,0,2,0,2,0,2,0,0,2,0,2
	2,0,2,2,0,2,2,0,2,0,2,0,2,2,0,2
	2,0,2,2,0,0,2,0,2,0,2,0,0,2,0,2
	2,0,2,2,0,2,2,0,2,0,2,0,2,2,0,2
	2,0,0,2,0,0,2,2,0,2,2,0,0,2,0,0
	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	2,2,2,2,2,2,0,0,0,0,2,2,2,2,2,2
	2,2,2,2,2,2,0,2,2,2,2,2,2,2,2,2
	2,2,2,2,2,2,0,2,2,2,2,2,2,2,2,2
	2,2,2,2,2,2,0,0,0,0,2,2,2,2,2,2
	2,2,2,2,2,2,2,2,2,0,2,2,2,2,2,2
	2,2,2,2,2,2,2,2,2,0,2,2,2,2,2,2
	2,2,2,2,2,2,0,0,0,0,2,2,2,2,2,2
	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
level5_PlayerX: .word 13
level5_PlayerY: .word 1
level5_EnemyX:	.word 10
level5_EnemyY:	.word 1
level5_GemCount:.word 16	
level5_Display:	.word   
	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	1,3,0,0,0,0,0,0,0,0,0,0,0,0,3,1
	1,0,0,0,0,0,3,1,1,3,0,0,0,0,0,1
	1,0,0,1,1,0,1,1,1,1,0,1,1,0,0,1
	1,0,0,1,0,0,0,0,0,0,0,0,1,0,0,1
	1,0,0,0,0,1,1,0,0,1,1,0,0,0,0,1
	1,0,3,1,0,1,3,0,0,3,1,0,1,3,0,1
	1,0,1,5,0,0,0,0,0,0,0,0,5,1,0,1
	1,0,1,5,0,0,0,0,0,0,0,0,5,1,0,1
	1,0,3,1,0,1,3,0,0,3,1,0,1,3,0,1
	1,0,0,0,0,1,1,0,0,1,1,0,0,0,0,1
	1,0,0,1,0,0,0,0,0,0,0,0,1,0,0,1
	1,0,0,1,1,0,1,1,1,1,0,1,1,0,0,1
	1,0,0,0,0,0,3,1,1,3,0,0,0,0,0,1
	1,3,0,0,0,0,0,0,0,0,0,0,0,0,3,1
	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	
#length of array also total pixel position 16x16=256			
displayLength:	.word   256
#colorScheme maps the numerical values in the 16x16 array to individual colors
#0=white, 1=black, 2=blue, 3=green, 4=red, 5=orange, 6=cyan, 7=yellow
colorScheme:	.word   WHITE, BLACK, BLUE, GREEN, RED, ORANGE


.text
main:
#LEVEL 1-----------------------------------------
	#display level 1 title screen
	la $a0, level1_TitleDisplay    		
	lw $a1, displayLength
	lw $a2, colorScheme	
	jal drawDisplay
	
	#pause to screen to see the title screen
	jal pauseDisplay
	
	#display leve1 1 map
	la $a0, level1_Display    		
	lw $a1, displayLength
	lw $a2, colorScheme	
	jal drawDisplay
	
	#set the position of the player (x,y) for level 1 and draw it
	lw $a0, level1_PlayerX			#$a0=x,$a1=y
	lw $a1, level1_PlayerY
	jal  drawPlayer
	#set the position of the enemy (x,y) for level 1 and draw it
	lw $a2,level1_EnemyX			#$a2=x,$a3=y
	lw $a3,level1_EnemyY
	jal drawEnemy
	#set the number of gem on level 1
	lw $s0, level1_GemCount			#$s0 = number of gems
	li $v0, 0				#set level complete flag to no
	jal startLevel
	
	li $t2, 1				#if level failed end game
	beq $v0, $t2, failed			
#LEVEL 2-----------------------------------------
	#display level 2 title screen
	la $a0, level2_TitleDisplay    		
	lw $a1, displayLength
	lw $a2, colorScheme	
	jal drawDisplay
	
	#pause to screen to see the title screen
	jal pauseDisplay
	
	#display leve1 2 map
	la $a0, level2_Display    		
	lw $a1, displayLength
	lw $a2, colorScheme	
	jal drawDisplay
	
	#set the position of the player (x,y) for level 2 and draw it
	lw $a0, level2_PlayerX			#$a0=x,$a1=y
	lw $a1, level2_PlayerY
	jal  drawPlayer
	#set the position of the enemy (x,y) for level 2 and draw it
	lw $a2,level2_EnemyX			#$a2=x,$a3=y
	lw $a3,level2_EnemyY
	jal drawEnemy
	#set the number of gem on level 2
	lw $s0, level2_GemCount			#$s0 = number of gems
	li $v0, 0				#set level complete flag to no
	jal startLevel
	
	li $t2, 1				#if level failed end game
	beq $v0, $t2, failed
#LEVEL 3-----------------------------------------
	#display level 3 title screen
	la $a0, level3_TitleDisplay    		
	lw $a1, displayLength
	lw $a2, colorScheme	
	jal drawDisplay
	
	#pause to screen to see the title screen
	jal pauseDisplay
	
	#display leve1 3 map
	la $a0, level3_Display    		
	lw $a1, displayLength
	lw $a2, colorScheme	
	jal drawDisplay
	
	#set the position of the player (x,y) for level 3 and draw it
	lw $a0, level3_PlayerX			#$a0=x,$a1=y
	lw $a1, level3_PlayerY
	jal  drawPlayer
	#set the position of the enemy (x,y) for level 3 and draw it
	lw $a2,level3_EnemyX			#$a2=x,$a3=y
	lw $a3,level3_EnemyY
	jal drawEnemy
	#set the number of gem on level 2
	lw $s0, level3_GemCount			#$s0 = number of gems
	li $v0, 0				#set level complete flag to no
	jal startLevel
	
	li $t2, 1				#if level failed end game
	beq $v0, $t2, failed
#LEVEL 4-----------------------------------------
	#display level 4 title screen
	la $a0, level4_TitleDisplay    		
	lw $a1, displayLength
	lw $a2, colorScheme	
	jal drawDisplay
	
	#pause to screen to see the title screen
	jal pauseDisplay
	
	#display leve1 4 map
	la $a0, level4_Display    		
	lw $a1, displayLength
	lw $a2, colorScheme	
	jal drawDisplay
	
	#set the position of the player (x,y) for level 4 and draw it
	lw $a0, level4_PlayerX			#$a0=x,$a1=y
	lw $a1, level4_PlayerY
	jal  drawPlayer
	#set the position of the enemy (x,y) for level 4 and draw it
	lw $a2,level4_EnemyX			#$a2=x,$a3=y
	lw $a3,level4_EnemyY
	jal drawEnemy
	#set the number of gem on level 2
	lw $s0, level4_GemCount			#$s0 = number of gems
	li $v0, 0				#set level complete flag to no
	jal startLevel
	
	li $t2, 1				#if level failed end game
	beq $v0, $t2, failed
#LEVEL 5-----------------------------------------
	#display level 5 title screen
	la $a0, level5_TitleDisplay    		
	lw $a1, displayLength
	lw $a2, colorScheme	
	jal drawDisplay
	
	#pause to screen to see the title screen
	jal pauseDisplay
	
	#display leve1 5 map
	la $a0, level5_Display    		
	lw $a1, displayLength
	lw $a2, colorScheme	
	jal drawDisplay
	
	#set the position of the player (x,y) for level 5 and draw it
	lw $a0, level5_PlayerX			#$a0=x,$a1=y
	lw $a1, level5_PlayerY
	jal  drawPlayer
	#set the position of the enemy (x,y) for level 5 and draw it
	lw $a2,level5_EnemyX			#$a2=x,$a3=y
	lw $a3,level5_EnemyY
	jal drawEnemy
	#set the number of gem on level 5
	lw $s0, level5_GemCount			#$s0 = number of gems
	li $v0, 0				#set level complete flag to no
	jal startLevel
	
	li $t2, 1				#if level failed end game
	beq $v0, $t2, failed
#------------------------------------------------
winner:	
	la $a0, winner_TitleDisplay    		#else player wins the game
	lw $a1, displayLength
	lw $a2, colorScheme	
	jal drawDisplay				#display winner screen
	jal pauseDisplay
	j exit
failed:
	la $a0, loser_TitleDisplay    		
	lw $a1, displayLength
	lw $a2, colorScheme	
	jal drawDisplay				#display loser screen
	jal pauseDisplay

quit:
#--------------------------End Program-------------------------
exit:	li   $v0, 10
	syscall

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#----------------------ALL FUNCTIONS BELOW---------------------
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#xxxxxxxxxxxxxxxxxxx START LEVEL FUNCTION xxxxxxxxxxxxxxxxxxxxx
#starts the given level until player completes it or fails
# $a0=x,$a1=y(player)  $a2=x,$a3=y(enemy)  $s0=number of gems
startLevel:
	addi $sp, $sp, -28			#push all function registers
	sw   $ra, ($sp)
	sw   $t0, 4($sp)
	sw   $t1, 8($sp)
	sw   $t2, 12($sp)
	sw   $t3, 16($sp)
	sw   $t4, 20($sp)
	sw   $s1, 24($sp)
		
	li  $v0, 0
	li  $t0, 0 				#initialize gem counter 
	add $t1, $0, $s0 			#set number of gems on given level 
	
	#loop level until the player has either completed it or lost
loopLevel:		
	#check for input
	lw  $t2, 0xFFFF0000
	beq $t2, $0, loopLevel
	#process input
	lw  $s1, 0xFFFF0004
	beq $s1, 32,  quit			#input space
	beq $s1, 119, up			#input w
	beq $s1, 115, down			#input s
	beq $s1, 97,  left			#input a
	beq $s1, 100, right			#input d
	#invalid input, ignore
	j loopLevel
	
#xxxxx-Keyboard Functions-xxxxx
up:
#======PLAYER UP MOVEMENTS=====
#------Check Next Pixel--------
	addi $a1, $a1, -1			#get next pixel (x,y-1)
	jal  checkColorPlayer			#get color of next pixel
	move $t3, $v0				#store color in $t3
	addi $a1, $a1, 1			#restore (x,y)
	beq  $t3, BLACK, dontMovePlayerUp	#check if next color is black
	beq  $t3, GREEN, getGemUp		#check if next color is green
	beq  $t3, ORANGE, checkGemCountUp	#check if next color is orange
	beq  $t3, RED, levelFailed		#check if next color is red
	j    ingnorePlayerUp			#next pixel is white so just move

checkGemCountUp:				#trying to landed on orange
	beq $t0, $t1, levelCompleteUp		#check if player collected all gems 
	j   dontMovePlayerUp			#not all gems collected can't land on orange

getGemUp:					#trying to land on green
	addi $t0, $t0, 1			#increment gem count

ingnorePlayerUp:				#if no issues, move up
#------Make Player Movement----
	jal  erasePlayer			#erase current pixel
	addi $a1, $a1, -1 #next pixel up	#move pixel address up 1
	jal  drawPlayer				#draw next player position
	j    enemyMoveUp			#loop for next input
#-----Final Player Movement----
levelCompleteUp:				#allow player to land on orange
	jal  erasePlayer			#erase current pixel
	addi $a1, $a1, -1 			#move pixel address up 1
	jal  drawPlayer				#draw next player position
	j    levelComplete			#end level function
#======ENEMY UP MOVEMENTS======
enemyMoveUp:
dontMovePlayerUp:
#------Check Next Pixel--------
	li $t4, 2				#counter for how many movements enemy makes
loopEnemyUp:
	beq  $t4, $0, dontMoveEnemyUp		#if enemy has made all its moves stop
	addi $a3, $a3, -1			#get next pixel (x,y-1)
	jal  checkColorEnemy			#get color of next pixel
	move $t3, $v0				#store color in $t3
	addi $a3, $a3, 1			#restore (x,y)
	beq  $t3, BLACK, dontMoveEnemyUp	#check if next color is black
	beq  $t3, ORANGE, dontMoveEnemyUp	#check if next color is orange
	beq  $t3, GREEN, dontMoveEnemyUp	#check if next color is green
	beq  $t3, BLUE,  levelFailed		#check if next color is blue
	j ignoreEnemyUp				#next pixel is white so just move

ignoreEnemyUp:
#------Make Enemy Movement-----
	jal eraseEnemy				#erase current pixel
	add $a3, $a3, -1			#move pixel address up 1
	jal drawEnemy				#draw next enemy position
	addi $t4, $t4, -1			#decrement movement count
	jal pauseEnemy				#pause to show movement
	j loopEnemyUp				#loop for next possible movement
dontMoveEnemyUp:
	j loopLevel				#loop for next input

								
down:
#=====PLAYER DOWN MOVEMENTS=====
#------Check Next Pixel---------
	addi $a1, $a1, 1			#get next pixel (x,y+1)
	jal  checkColorPlayer			#get color of next pixel
	move $t3, $v0				#store color in $t3
	addi $a1, $a1, -1			#restore (x,y)
	beq  $t3, BLACK, dontMovePlayerDown	#check if next color is black
	beq  $t3, GREEN, getGemDown		#check if next color is green
	beq  $t3, ORANGE, checkGemCountDown	#check if next color is orange	
	beq  $t3, RED, levelFailed		#check if next color is red
	j    ingnorePlayerDown			#next pixel is white so just move

checkGemCountDown:				#trying to landed on orange
	beq $t0, $t1, levelCompleteDown		#check if player collected all gems
	j   dontMovePlayerDown			#not all gems collected can't land on orange

getGemDown:					#trying to land on green
	addi $t0, $t0, 1			#increment gem count

ingnorePlayerDown:				#if no issues, move down
#------Make Player Movement----
	jal  erasePlayer			#erase current pixel
	addi $a1, $a1, 1  			#move pixel address down 1
	jal  drawPlayer				#draw next player position
	j    enemyMoveDown			#loop for next input
#-----Final Player Movement----
levelCompleteDown:				#allow player to land on orange
	jal  erasePlayer			#erase current pixel
	addi $a1, $a1, 1 			#move pixel address down 1
	jal  drawPlayer				#draw next player position
	j    levelComplete			#end level function
#======ENEMY DOWN MOVEMENTS====
enemyMoveDown:
dontMovePlayerDown:
#------Check Next Pixel--------
	li $t4, 2				#counter for how many movements enemy makes
loopEnemyDown:			
	beq  $t4, $0, dontMoveEnemyDown		#if enemy has made all its moves stop
	addi $a3, $a3, 1			#get next pixel (x,y+1)
	jal  checkColorEnemy			#get color of next pixel
	move $t3, $v0				#store color in $t3
	addi $a3, $a3, -1			#restore (x,y)
	beq  $t3, BLACK, dontMoveEnemyDown	#check if next color is black
	beq  $t3, ORANGE, dontMoveEnemyDown	#check if next color is orange
	beq  $t3, GREEN, dontMoveEnemyDown	#check if next color is green
	beq  $t3, BLUE,  levelFailed		#check if next color is blue
	j ignoreEnemyDown			#next pixel is white so just move

ignoreEnemyDown:
#------Make Enemy Movement-----
	jal eraseEnemy				#erase current pixel
	add $a3, $a3, 1				#move pixel address down 1
	jal drawEnemy				#draw next enemy position
	add $t4, $t4, -1			#decrement movement count
	jal pauseEnemy				#pause to show movement
	j loopEnemyDown				#loop for next possible movement
dontMoveEnemyDown:
	j loopLevel				#loop for next input
	

left:
#=====PLAYER LEFT MOVEMENTS====
#-------Check Next Pixel-------
	addi $a0, $a0, -1			#get next pixel (x-1,y)	
	jal  checkColorPlayer			#get color of next pixel
	move $t3, $v0				#store color in $t3
	addi $a0, $a0, 1			#restore (x,y)
	beq  $t3, BLACK, dontMovePlayerLeft	#check if next color is black
	beq  $t3, GREEN, getGemLeft		#check if next color is green
	beq  $t3, ORANGE, checkGemCountLeft	#check if next color is orange
	beq  $t3, RED, levelFailed		#check if next color is red
	j    ingnorePlayerLeft			#next pixel is white so just move

checkGemCountLeft:				#trying to landed on orange
	beq $t0, $t1, levelCompleteLeft		#check if player collected all gems
	j   dontMovePlayerLeft			#not all gems collected can't land on orange

getGemLeft:					#trying to land on green
	addi $t0, $t0, 1			#increment gem count

ingnorePlayerLeft:				#if no issues, move left
#------Make Player Movement----
	jal  erasePlayer			#erase current pixel
	addi $a0, $a0, -1 #next pixel left	#move pixel address left 1
	jal  drawPlayer				#draw next player position
	j    enemyMoveLeft				#loop for next input
#-----Final Player Movement----
levelCompleteLeft:				#allow player to land on orange
	jal  erasePlayer			#erase current pixel
	addi $a0, $a0, -1			#move pixel address left 1
	jal  drawPlayer				#draw next player position
	j    levelComplete			#end level function
#====ENEMY LEFT MOVEMENTS======
enemyMoveLeft:
dontMovePlayerLeft:
#------Check Next Pixel--------
	li  $t4, 2				#counter for how many movements enemy makes
loopEnemyLeft:
	beq  $t4, $0, dontMoveEnemyLeft		#if enemy has made all its moves stop
	addi $a2, $a2, -1			#get next pixel (x-1,y)
	jal  checkColorEnemy			#get color of next pixel
	move $t3, $v0				#store color in $t3
	addi $a2, $a2, 1			#restore (x,y)
	beq  $t3, BLACK, dontMoveEnemyLeft	#check if next color is black
	beq  $t3, ORANGE, dontMoveEnemyLeft	#check if next color is orange
	beq  $t3, GREEN, dontMoveEnemyLeft	#check if next color is green
	beq  $t3, BLUE,  levelFailed		#check if next color is blue
	j ignoreEnemyLeft			#next pixel is white so just move
	
ignoreEnemyLeft:
#------Make Enemy Movement-----
	jal eraseEnemy				#erase current pixel
	add $a2, $a2, -1			#move pixel address left 1
	jal drawEnemy				#draw next enemy position
	addi $t4, $t4, -1			#decrement movement count
	jal pauseEnemy				#pause to show movement
	j loopEnemyLeft				#loop for next possible movement
	
dontMoveEnemyLeft:
	j loopLevel				#loop for next input


right:
#=====ALL PLAYER MOVEMENTS======
#-------Check Next Pixel--------
	addi $a0, $a0, 1			#get next pixel (x+1,y)	
	jal  checkColorPlayer			#get color of next pixel
	move $t3, $v0				#store color in $t3
	addi $a0, $a0, -1			#restore (x,y)
	beq  $t3, BLACK, dontMovePlayerRight	#check if next color is black
	beq  $t3, GREEN, getGemRight		#check if next color is green
	beq  $t3, ORANGE, checkGemCountRight	#check if next color is orange
	beq  $t3, RED, levelFailed		#check if next color is red
	j    ingnorePlayerRight			#next pixel is white so just move

checkGemCountRight:				#trying to landed on orange
	beq $t0, $t1, levelCompleteRight	#check if player collected all gems
	j   dontMovePlayerRight			#not all gems collected can't land on orange

getGemRight:					#trying to land on green
	addi $t0, $t0, 1			#increment gem count

ingnorePlayerRight:				#if no issues, move right
#------Make Player Movement----
	jal  erasePlayer			#erase current pixel
	addi $a0, $a0, 1 			#move pixel address right 1
	jal  drawPlayer				#draw next player position
	j    enemyMoveRight				#loop for next input
#-----Final Player Movement----
levelCompleteRight:				#allow player to land on orange
	jal  erasePlayer			#erase current pixel		
	addi $a0, $a0, 1 			#move pixel address right 1
	jal  drawPlayer				#draw next player position
	j    levelComplete			#end level function
#
#======ENEMY DOWN MOVEMENTS====
enemyMoveRight:
dontMovePlayerRight:
#------Check Next Pixel--------
	li $t4, 2				#counter for how many movements enemy makes
loopEnemyRight:
	beq  $t4, $0, dontMoveEnemyRight	#if enemy has made all its moves stop
	addi $a2, $a2, 1			#get next pixel (x-1,y)
	jal  checkColorEnemy			#get color of next pixel
	move $t3, $v0				#store color in $t3
	addi $a2, $a2, -1			#restore (x,y)
	beq  $t3, BLACK, dontMoveEnemyRight	#check if next color is black
	beq  $t3, ORANGE, dontMoveEnemyRight	#check if next color is orange
	beq  $t3, GREEN, dontMoveEnemyRight	#check if next color is green
	beq  $t3, BLUE,  levelFailed		#check if next color is blue
	j ignoreEnemyRight			#next pixel is white so just move

ignoreEnemyRight:
#------Make Enemy Movement-----
	jal eraseEnemy				#erase current pixel
	add $a2, $a2, 1				#move pixel address right 1
	jal drawEnemy				#draw next enemy position
	addi $t4, $t4, -1			#decrement movement count
	jal pauseEnemy				#pause to show movement
	j loopEnemyRight			#loop for next possible movement
	
dontMoveEnemyRight:
	j loopLevel				#loop for next input


#----------
levelFailed:					
	li $v0, 1				#indicate that the player failed
	
levelComplete:					#player complete level leave function
	lw   $ra, ($sp)				#pop back all function register
	lw   $t0, 4($sp)
	lw   $t1, 8($sp)
	lw   $t2, 12($sp)
	lw   $t3, 16($sp)
	lw   $t4, 20($sp)
	lw   $s1, 24($sp)
	addi $sp, $sp, 28
	jr   $ra

#xxxxxxxxxxxxxxxxxxx END OF START LEVEL FUNCTION xxxxxxxxxxxxxxx
	
#xxxxxxxxxxxxxxxxxx START OF DRAW PLAYER FUNCTION xxxxxxxxxxxxxx	
# $a0 = X, $a1 = Y, (Formula from Instructions) $gp + 4*(x + y*width)
drawPlayer:
	addi $sp, $sp, -8			#push all function registers
	sw   $t0, ($sp)
	sw   $s1, 4($sp)
	
	li   $t0, BLUE				#Set the Color of the Player (Blue)
	mul  $s1, $a1, WIDTH   			# y * WIDTH
	add  $s1, $s1, $a0     			# add X
	mul  $s1, $s1, 4      		 	# multiply by 4 to get word offset
	add  $s1, $s1, $gp     			# add to base address
	sw   $t0, ($s1)	       			# store color blue at memory location
	
	lw   $t0, ($sp)				#pop all function registers
	lw   $s1, 4($sp)
	addi $sp, $sp, 8
	jr   $ra	
#xxxxxxxxxxxxxxxxxxx END OF DRAW PLAYER FUNCTION xxxxxxxxxxxxxxx	
		
#xxxxxxxxxxxxxxxxxx START OF DRAW ENEMY FUNCTION xxxxxxxxxxxxxxx	
# $a2 = X, $a3 = Y, (Formula from Instructions) $gp + 4*(x + y*width)
drawEnemy:
	addi $sp, $sp, -8			#push all function registers
	sw   $t0, ($sp)
	sw   $s1, 4($sp)
	
	li   $t0, RED				#Set the Color of the Enemy (Red)
	mul  $s1, $a3, WIDTH   			# y * WIDTH
	add  $s1, $s1, $a2    			# add X
	mul  $s1, $s1, 4       			# multiply by 4 to get word offset
	add  $s1, $s1, $gp     			# add to base address
	sw   $t0, ($s1)	       			# store color red at memory location
	
	lw   $t0, ($sp)				#pop all function registers
	lw   $s1, 4($sp)
	addi $sp, $sp, 8
	jr   $ra	
#xxxxxxxxxxxxxxxxxxx END OF DRAW ENEMY FUNCTION xxxxxxxxxxxxxxxx

#xxxxxxxxxxxxxxxxxx START OF DRAW GEM FUNCTION xxxxxxxxxxxxxxxxx	
# $a2 = X, $a3 = Y, (Formula from Instructions) $gp + 4*(x + y*width)
drawGem:
	addi $sp, $sp, -8			#push all function registers
	sw   $t0, ($sp)
	sw   $s1, 4($sp)
	
	li   $t0, GREEN				#Set the Color of the Gem (Green)
	mul  $s1, $a3, WIDTH   			# y * WIDTH
	add  $s1, $s1, $a2    			# add X
	mul  $s1, $s1, 4       			# multiply by 4 to get word offset
	add  $s1, $s1, $gp     			# add to base address
	sw   $t0, ($s1)	       			# store color green at memory location
	
	lw   $t0, ($sp)				#pop all function registers
	lw   $s1, 4($sp)
	addi $sp, $sp, 8
	jr   $ra	
#xxxxxxxxxxxxxxxxxxx END OF DRAW GEM FUNCTION xxxxxxxxxxxxxxxxxx
	
#xxxxxxxxxxxxxxxxx START OF ERASE PLAYER FUNCTION xxxxxxxxxxxxxx
# $a0 = X, $a1 = Y (Formula from Instructions) $gp + 4*(x + y*width)
erasePlayer:
	addi $sp, $sp, -8			#push all function registers
	sw   $t0, ($sp)
	sw   $s1, 4($sp)	
		
	li   $t0, WHITE				#Set the Color of the Background (White)
	mul  $s1, $a1, WIDTH   			# y * WIDTH
	add  $s1, $s1, $a0     			# add X
	mul  $s1, $s1, 4      			# multiply by 4 to get word offset
	add  $s1, $s1, $gp     			# add to base address
	sw   $t0, ($s1)	       			# store color white at memory location
	
	lw   $t0, ($sp)				#pop all function registers
	lw   $s1, 4($sp)
	addi $sp, $sp, 8
	jr   $ra		
#xxxxxxxxxxxxxxxxxx END OF ERASE PLAYER FUNCITON xxxxxxxxxxxxxxx	
	
#xxxxxxxxxxxxxxxxx START OF ERASE ENEMY FUNCTION xxxxxxxxxxxxxxx
# $a2 = X, $a3 = Y, (Formula from Instructions) $gp + 4*(x + y*width)
eraseEnemy:
	addi $sp, $sp, -8			#push all function registers
	sw   $t0, ($sp)
	sw   $s1, 4($sp)	
		
	li   $t0, WHITE				#Set the Color of the Background (White)
	mul  $s1, $a3, WIDTH   			# y * WIDTH
	add  $s1, $s1, $a2    		 	# add X
	mul  $s1, $s1, 4       			# multiply by 4 to get word offset
	add  $s1, $s1, $gp     			# add to base address
	sw   $t0, ($s1)	       			# store color White at memory location
	
	lw   $t0, ($sp)				#pop all function registers
	lw   $s1, 4($sp)
	addi $sp, $sp, 8
	jr   $ra
#xxxxxxxxxxxxxxxx END OF ERASE ENEMY FUNCTION xxxxxxxxxxxxxxxxx

#xxxxxxxxxxxxxx START OF DRAW DISPLAY FUNCTION xxxxxxxxxxxxxxxx
#$a0=address of display array, $a1=array length, $a2=colorScheme
drawDisplay:
	addi $sp, $sp, -16			#push all function registers
	sw   $t0, ($sp)
	sw   $t1, 4($sp)
	sw   $s1, 8($sp)
	sw   $s2, 12($sp)
		
	la $s1, ($gp)				#load the gp address into s1
	li $t0, 0				#initialize loop counter
forArray:			
	beq  $a1, $t0, exitLoop			#check if all array element (256 of them) were processed 

	la   $s2, ($a0) 			#load display array address
	mul  $t1, $t0,4				#get word offset
	add  $s2, $s2, $t1 			#get the address of the current array element
	lw   $a2,($s2) 				#$a2 contains number in array
	mul  $a2, $a2, 4			#multiply number by for to find ColorScheme offset
	lw   $a2,colorScheme($a2)		#load the color of the current number
	sw   $a2, ($s1)				#store the color into corresponding bitmap position
	addi $s1, $s1, 4			#increment for next bitmap pixel position
	addi $t0, $t0, 1			#increment loop counter
	j forArray  
exitLoop:

	lw   $t0, ($sp)				#pop all function registers
	lw   $t1, 4($sp)
	lw   $s1, 8($sp)
	lw   $s2, 12($sp)
	addi $sp, $sp, -16
	jr $ra	
#xxxxxxxxxxxxxxxx END OF DRAW DISPLAY FUNCTION xxxxxxxxxxxxxxxx

#xxxxxxxxxxxxx START OF CHECK COLOR PLAYER FUNCTION xxxxxxxxxxx
# $a0 = X, $a1 = Y
checkColorPlayer:
	addi $sp, $sp, -8			#push all function registers
	sw   $t0, ($sp)	
	sw   $s1, 4($sp)		
	
	mul  $s1, $a1, WIDTH   			# y * WIDTH
	add  $s1, $s1, $a0     			# add X
	mul  $s1, $s1, 4       			# multiply by 4 to get word offset
	add  $s1, $s1, $gp     			# add to base address
	 
	lw   $t0, ($s1)	       			# loads color at memory location
	move $v0, $t0				# move color to $v0 for return 
	
	lw   $t0, ($sp)				#pop all function registers	
	lw   $s1, 4($sp)
	addi $sp, $sp, 8
	jr   $ra
#xxxxxxxxxxxxxx END OF CHECK COLOR PLAYER FUNCTION xxxxxxxxxxxx

#xxxxxxxxxxxxxx START OF CHECK COLOR ENEMY FUNCTION xxxxxxxxxxx
# $a2 = X, $a3 = Y
checkColorEnemy:
	addi $sp, $sp, -8			#push all function registers
	sw   $t0, ($sp)	
	sw   $s1, 4($sp)		
	
	mul  $s1, $a3, WIDTH   			# y * WIDTH
	add  $s1, $s1, $a2     			# add X
	mul  $s1, $s1, 4       			# multiply by 4 to get word offset
	add  $s1, $s1, $gp     			# add to base address
	 
	lw   $t0, ($s1)	       			# loads color at memory location
	move $v0, $t0				# move color to $v0 for return 
	
	lw   $t0, ($sp)				#pop all function registers	
	lw   $s1, 4($sp)
	addi $sp, $sp, 8
	jr   $ra
#xxxxxxxxxxxxxxx END OF CHECK COLOR ENEMY FUNCTION xxxxxxxxxxxx

#xxxxxxxxxxxxxxx START OF PAUSE DISPLAY FUNCTION xxxxxxxxxxxxxx
pauseDisplay:
	addi $sp, $sp, -8			#push all function registers
	sw   $ra, ($sp)
	sw   $a0, 4($sp)
	
	li   $v0, 32				#syscall for pause
	li   $a0, 2000				#amount in ms
	syscall
	
	lw   $ra, ($sp)				#pop all function registers
	lw   $a0, 4($sp)
	addi $sp, $sp, 8
	jr   $ra
#xxxxxxxxxxxxxxxxx END OF PAUSE DISPLAY FUNCTION xxxxxxxxxxxxxx

#xxxxxxxxxxxxxxxxx START OF PAUSE ENEMY FUNCTION xxxxxxxxxxxxxx
pauseEnemy:
	addi $sp, $sp, -8			#push all function registers
	sw   $ra, ($sp)
	sw   $a0, 4($sp)
	
	li   $v0, 32				#syscall for pause
	li   $a0, 120				#amount in ms
	syscall
	
	lw   $ra, ($sp)				#pop all function registers
	lw   $a0, 4($sp)
	addi $sp, $sp, 8
	jr   $ra
#xxxxxxxxxxxxxxxxx END OF PAUSE ENEMY FUNCTION xxxxxxxxxxxxxxxx
