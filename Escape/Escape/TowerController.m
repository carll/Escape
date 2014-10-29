//
//  TowerController.m
//  Tower Of Sorcerer
//
//  Created by Yue Xu on 22/05/14.
//  Copyright (c) 2014 Yue Xu. All rights reserved.
//

#import "TowerController.h"

@interface TowerController ()

@end


@implementation TowerController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //[self.navigationController setNavigationBarHidden:YES];
    
    [self chooseGameLevel];
    self.gameStatus = @"ChooseGameLevel";
    
    UIImageView* imageView = self.background;
    imageView.image = [UIImage imageNamed:@"BackGround.png"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//make the screen empty, ready for the next view
-(void)cleanScreen
{
    //clean the cave if any
    for (int i = 0; i < 11; i++)
        for (int j = 0; j < 11; j++)
        {
            UIImageView* imageView = [self.imageViews objectAtIndex:(11 * i + j)];
            imageView.image = [UIImage imageNamed:@"Blank.png"];
        }
    
    //clean magic pictures if any
    for (int i = 0; i < 5; i++)
    {
        UIImageView* imageView = [self.magics objectAtIndex:i];
        imageView.image = [UIImage imageNamed:@"Blank.png"];
    }
    
    //clean magic level pictures if any
    for (int i = 0; i < 3; i++)
    {
        UIImageView* imageView = [self.magicLevels objectAtIndex:i];
        imageView.image = [UIImage imageNamed:@"Blank.png"];
    }
    
    // clean other pictures
    self.startImage.image = [UIImage imageNamed:@"Blank.png"];
    self.leftChoice.image = [UIImage imageNamed:@"Blank.png"];
    self.rightChoice.image = [UIImage imageNamed:@"Blank.png"];
    self.explainLabel.text = @"";
    self.nextExplain.image = [UIImage imageNamed:@"Blank.png"];
    self.skipTutorial.image = [UIImage imageNamed:@"Blank.png"];
    self.startTutorial.image = [UIImage imageNamed:@"Blank.png"];
    
    self.moveLimit.image = [UIImage imageNamed:@"Blank.png"];
    self.magicLimit.image = [UIImage imageNamed:@"Blank.png"];
    self.moveTen.image = [UIImage imageNamed:@"Blank.png"];
    self.moveOne.image = [UIImage imageNamed:@"Blank.png"];
    self.magicTen.image = [UIImage imageNamed:@"Blank.png"];
    self.magicOne.image = [UIImage imageNamed:@"Blank.png"];
    
    [player stop];
}

/*
 This method will display all the levels for player to choose
 */
-(void)chooseGameLevel
{
    [self cleanScreen];
    
    NSURL* soundFile = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"background" ofType:@"mp3"]];
    
    NSError* error;
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFile error:&error];
    [player prepareToPlay];
    [player play];
    
    UIImageView* imageView = self.startImage;
    imageView.image = [UIImage imageNamed:@"ChooseGameLevel.png"];
    
    imageView = [self.imageViews objectAtIndex:89];
    imageView.image = [UIImage imageNamed:@"One.png"];
    imageView = [self.imageViews objectAtIndex:91];
    imageView.image = [UIImage imageNamed:@"Two.png"];
    imageView = [self.imageViews objectAtIndex:93];
    imageView.image = [UIImage imageNamed:@"Three.png"];
    imageView = [self.imageViews objectAtIndex:95];
    imageView.image = [UIImage imageNamed:@"Four.png"];
    imageView = [self.imageViews objectAtIndex:97];
    imageView.image = [UIImage imageNamed:@"Five.png"];
    imageView = [self.imageViews objectAtIndex:111];
    imageView.image = [UIImage imageNamed:@"Six.png"];
    imageView = [self.imageViews objectAtIndex:113];
    imageView.image = [UIImage imageNamed:@"Seven.png"];
    imageView = [self.imageViews objectAtIndex:115];
    imageView.image = [UIImage imageNamed:@"Eight.png"];
    imageView = [self.imageViews objectAtIndex:117];
    imageView.image = [UIImage imageNamed:@"Nine.png"];
    imageView = [self.imageViews objectAtIndex:119];
    imageView.image = [UIImage imageNamed:@"Ten.png"];
    self.startTutorial.image = [UIImage imageNamed:@"StartTutorial.png"];
}

/*
 This method display all the pictures in the view when the game was first loaded
 */

-(void)startGame
{
    [self cleanScreen];
    
    NSURL* soundFile = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"gameRunning" ofType:@"mp3"]];
    
    NSError* error;
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFile error:&error];
    player.numberOfLoops = -1;
    [player prepareToPlay];
    [player play];
    
    self.magicTypeChosen = @"No";
    self.magicLevelChosen = 0;
    self.player = [[Player alloc] initWithName:@"Kael" andLocationX:10 andLocationY:0 andDirection:@"Right" andStatus:@"Normal" andHidenTimes:0];
    //self.levelNumber = 1;
    self.cave = [[Level alloc] initWithNumber:self.levelNumber].content;
    
    for (int i = 0; i < 11; i++)
    {
        for (int j = 0; j < 11; j++)
        {
            int index = i * 11 + j;
            NSString* imageContent = [[self.cave objectAtIndex:i] objectAtIndex:j];
            NSString* imageName = [NSString stringWithFormat:@"%@.png", imageContent];
            UIImageView* imageView = [self.imageViews objectAtIndex:index];
            imageView.image = [UIImage imageNamed:imageName];
        }
    }
    
    NSString* imageContent = [[self.cave objectAtIndex:10] objectAtIndex:0];
    NSString* imageName = [NSString stringWithFormat:@"Hero%@%@.png", imageContent, self.player.facingDirection];
	UIImageView* imageView = [self.imageViews objectAtIndex:(10 * 11 + 0)];
    
    imageView.image = [UIImage imageNamed:imageName];
    
    self.moveLimit.image = [UIImage imageNamed:@"MoveLeft.png"];
    self.magicLimit.image = [UIImage imageNamed:@"MagicLeft.png"];
    
    self.moveLeft = self.levelNumber + 15;
    self.magicLeft = 10;
    
    [self updateCurrentLimitation];
    
    [self displayFiveTypesOfMagics];
    
    [self hideThreeLevelsOfMagic:@"Fire"];
}

//This method will update the move left or magic left once an action was done
-(void)updateCurrentLimitation
{
    NSString* imageName = [NSString stringWithFormat:@"%d.png", (self.moveLeft / 10)];
    self.moveTen.image = [UIImage imageNamed:imageName];
    imageName = [NSString stringWithFormat:@"%d.png", (self.moveLeft % 10)];
    self.moveOne.image = [UIImage imageNamed:imageName];
    imageName = [NSString stringWithFormat:@"%d.png", (self.magicLeft / 10)];
    self.magicTen.image = [UIImage imageNamed:imageName];
    imageName = [NSString stringWithFormat:@"%d.png", (self.magicLeft % 10)];
    self.magicOne.image = [UIImage imageNamed:imageName];
}

//This method will display the view of game over
-(void)gameOver
{
    [self cleanScreen];
    
    UIImageView* imageView = self.startImage;
    imageView.image = [UIImage imageNamed:@"GameOver.png"];
    imageView = self.leftChoice;
    imageView.image = [UIImage imageNamed:@"PlayAgain.png"];
    imageView = self.rightChoice;
    imageView.image = [UIImage imageNamed:@"BackToMenu.png"];
}

//This method will display the view for win game
-(void)gameWin
{
    [self cleanScreen];
    
    if (self.levelNumber < 10)
    {
        UIImageView* imageView = self.startImage;
        imageView.image = [UIImage imageNamed:@"GameWin"];
        imageView = self.leftChoice;
        imageView.image = [UIImage imageNamed:@"GoToNextLevel.png"];
    }
    else
    {
        UIImageView* imageView = self.startImage;
        imageView.image = [UIImage imageNamed:@"Congratulations.png"];
        imageView = self.leftChoice;
        imageView.image = [UIImage imageNamed:@"PlayAgain.png"];
    }
    UIImageView* imageView = self.rightChoice;
    imageView.image = [UIImage imageNamed:@"BackToMenu.png"];
}

//This method implement the tutorial section
-(void)displayTutorial
{
    [self cleanScreen];
    
    self.nextExplain.image = [UIImage imageNamed:@"Next.png"];
    self.skipTutorial.image = [UIImage imageNamed:@"Skip.png"];
    
    self.explainLabel.text = @"";
    
    if (self.index == 1)  //display hero
    {
        UIImageView* imageView = [self.imageViews objectAtIndex:(2 * 11 + 2)];
        imageView.image = [UIImage imageNamed:@"HeroGrassUp.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 4)];
        imageView.image = [UIImage imageNamed:@"HeroGrassDown.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 6)];
        imageView.image = [UIImage imageNamed:@"HeroGrassLeft.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 8)];
        imageView.image = [UIImage imageNamed:@"HeroGrassRight.png"];
        
        self.explainLabel.text = @"This is the hero in the game, you can touch the screen to move it, or choose magic to use.";
    }
    else if (self.index == 2) //display grass, ground and ice
    {
        UIImageView* imageView = [self.imageViews objectAtIndex:(2 * 11 + 3)];
        imageView.image = [UIImage imageNamed:@"Grass.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 5)];
        imageView.image = [UIImage imageNamed:@"Ground.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 7)];
        imageView.image = [UIImage imageNamed:@"Ice.png"];
        
        self.explainLabel.text = @"These three places stands for grass, ground and ice, which the hero can move to.";
    }
    else if (self.index == 3) //display tree and rock
    {
        UIImageView* imageView = [self.imageViews objectAtIndex:(2 * 11 + 4)];
        imageView.image = [UIImage imageNamed:@"Tree.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 6)];
        imageView.image = [UIImage imageNamed:@"Rock.png"];
        
        self.explainLabel.text = @"These two places stands for trees and rocks, which the hero can't move to.";
    }
    else if (self.index == 4) //display river and pit
    {
        UIImageView* imageView = [self.imageViews objectAtIndex:(2 * 11 + 4)];
        imageView.image = [UIImage imageNamed:@"River.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 6)];
        imageView.image = [UIImage imageNamed:@"Pit.png"];
        
        self.explainLabel.text = @"These two places stands for rivers and pits, which the hero can move to, but will die in these places.";
    }
    else if (self.index == 5) //display monster
    {
        UIImageView* imageView = [self.imageViews objectAtIndex:(2 * 11 + 5)];
        imageView.image = [UIImage imageNamed:@"Monster.png"];
        
        self.explainLabel.text = @"This place is owned by a monster, if you walk around the monster, you will be ate by it, and thus lose the game.";
    }
    else if (self.index == 6) //display exit
    {
        UIImageView* imageView = [self.imageViews objectAtIndex:(2 * 11 + 5)];
        imageView.image = [UIImage imageNamed:@"Exit.png"];
        
        self.explainLabel.text = @"This place is the exit room, if you enter this place, you win this game.";
    }
    else if (self.index == 7) //display fire magic
    {
        UIImageView* imageView = [self.imageViews objectAtIndex:(2 * 11 + 4)];
        imageView.image = [UIImage imageNamed:@"FireOff.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 6)];
        imageView.image = [UIImage imageNamed:@"FireOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 3)];
        imageView.image = [UIImage imageNamed:@"FireOneOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 5)];
        imageView.image = [UIImage imageNamed:@"FireTwoOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 7)];
        imageView.image = [UIImage imageNamed:@"FireThreeOn.png"];
        
        self.explainLabel.text = @"The first two images stands for fire magic, when the magic was chosen, it will be lighted, otherwise it's gray. After you choosed the fire magic, the three level of fire magic will light on, then you can press one of the three images in the second line to use it.";
    }
    else if (self.index == 8) //display fire magic level 1
    {
        
        UIImageView* imageView = [self.imageViews objectAtIndex:(2 * 11 + 2)];
        imageView.image = [UIImage imageNamed:@"HeroGrassRight.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 3)];
        imageView.image = [UIImage imageNamed:@"Tree.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 5)];
        imageView.image = [UIImage imageNamed:@"FireOneOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 7)];
        imageView.image = [UIImage imageNamed:@"HeroGrassRight.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 8)];
        imageView.image = [UIImage imageNamed:@"Ground.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 2)];
        imageView.image = [UIImage imageNamed:@"HeroGrassRight.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 3)];
        imageView.image = [UIImage imageNamed:@"Grass.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 5)];
        imageView.image = [UIImage imageNamed:@"FireOneOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 7)];
        imageView.image = [UIImage imageNamed:@"HeroGrassRight.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 8)];
        imageView.image = [UIImage imageNamed:@"Ground.png"];
        
        self.explainLabel.text = @"If you use level 1 fire magic, the grass or tree next to you will be burned, thus turn to a normal ground.";

    }
    else if (self.index == 9) //display fire magic level 2
    {
        UIImageView* imageView = [self.imageViews objectAtIndex:(2 * 11 + 1)];
        imageView.image = [UIImage imageNamed:@"HeroGrassRight.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 2)];
        imageView.image = [UIImage imageNamed:@"Tree.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 3)];
        imageView.image = [UIImage imageNamed:@"Tree.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 5)];
        imageView.image = [UIImage imageNamed:@"FireTwoOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 7)];
        imageView.image = [UIImage imageNamed:@"HeroGrassRight.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 8)];
        imageView.image = [UIImage imageNamed:@"Ground.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 9)];
        imageView.image = [UIImage imageNamed:@"Ground.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 1)];
        imageView.image = [UIImage imageNamed:@"HeroGrassRight.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 2)];
        imageView.image = [UIImage imageNamed:@"Grass.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 3)];
        imageView.image = [UIImage imageNamed:@"Grass.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 5)];
        imageView.image = [UIImage imageNamed:@"FireTwoOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 7)];
        imageView.image = [UIImage imageNamed:@"HeroGrassRight.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 8)];
        imageView.image = [UIImage imageNamed:@"Ground.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 9)];
        imageView.image = [UIImage imageNamed:@"Ground.png"];
        
        self.explainLabel.text = @"If you use level 2 fire magic, the grass and tree in the next 2 places will be burned, thus turn to a normal ground. But you can use it only when there are 2 places next to you.";
    }
    else if (self.index == 10) //display fire magic level 3
    {
        UIImageView* imageView = [self.imageViews objectAtIndex:(1 * 11 + 1)];
        imageView.image = [UIImage imageNamed:@"Tree.png"];
        
        imageView = [self.imageViews objectAtIndex:(1 * 11 + 2)];
        imageView.image = [UIImage imageNamed:@"Tree.png"];
        
        imageView = [self.imageViews objectAtIndex:(1 * 11 + 3)];
        imageView.image = [UIImage imageNamed:@"Tree.png"];
        
        imageView = [self.imageViews objectAtIndex:(1 * 11 + 5)];
        imageView.image = [UIImage imageNamed:@"FireThreeOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(1 * 11 + 7)];
        imageView.image = [UIImage imageNamed:@"Ground.png"];
        
        imageView = [self.imageViews objectAtIndex:(1 * 11 + 8)];
        imageView.image = [UIImage imageNamed:@"Ground.png"];
        
        imageView = [self.imageViews objectAtIndex:(1 * 11 + 9)];
        imageView.image = [UIImage imageNamed:@"Ground.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 2)];
        imageView.image = [UIImage imageNamed:@"HeroGrassUp.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 8)];
        imageView.image = [UIImage imageNamed:@"HeroGrassUp.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 1)];
        imageView.image = [UIImage imageNamed:@"Grass.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 2)];
        imageView.image = [UIImage imageNamed:@"Grass.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 3)];
        imageView.image = [UIImage imageNamed:@"Grass.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 5)];
        imageView.image = [UIImage imageNamed:@"FireThreeOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 7)];
        imageView.image = [UIImage imageNamed:@"Ground.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 8)];
        imageView.image = [UIImage imageNamed:@"Ground.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 9)];
        imageView.image = [UIImage imageNamed:@"Ground.png"];
        
        imageView = [self.imageViews objectAtIndex:(5 * 11 + 2)];
        imageView.image = [UIImage imageNamed:@"HeroGrassUp.png"];
        
        imageView = [self.imageViews objectAtIndex:(5 * 11 + 8)];
        imageView.image = [UIImage imageNamed:@"HeroGrassUp.png"];
        
        self.explainLabel.text = @"If you use level 3 fire magic, the place A next to your current place, and the two places next to place A will get burned. You can use it only when these three places exist.";
    }
    else if (self.index == 11) //display ice magic
    {
        UIImageView* imageView = [self.imageViews objectAtIndex:(2 * 11 + 4)];
        imageView.image = [UIImage imageNamed:@"IceOff.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 6)];
        imageView.image = [UIImage imageNamed:@"IceOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 3)];
        imageView.image = [UIImage imageNamed:@"IceOneOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 5)];
        imageView.image = [UIImage imageNamed:@"IceTwoOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 7)];
        imageView.image = [UIImage imageNamed:@"IceThreeOn.png"];
        
        self.explainLabel.text = @"The first two images stands for ice magic, when the magic was chosen, it will be lighted, otherwise it's gray. /nAfter you choosed the ice magic, the three level of ice magic will light on, then you can press one of the three images in the second line to use it.";
    }
    else if (self.index == 12) //display ice magic level 1
    {
        UIImageView* imageView = [self.imageViews objectAtIndex:(3 * 11 + 2)];
        imageView.image = [UIImage imageNamed:@"HeroGrassRight.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 3)];
        imageView.image = [UIImage imageNamed:@"River.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 5)];
        imageView.image = [UIImage imageNamed:@"IceOneOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 7)];
        imageView.image = [UIImage imageNamed:@"HeroGrassRight.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 8)];
        imageView.image = [UIImage imageNamed:@"Ice.png"];
        
        self.explainLabel.text = @"If you use level 1 ice magic, the river next to you will be frozen, thus turn to a iced place.";
    }
    else if (self.index == 13) //display ice magic level 2
    {
        UIImageView* imageView = [self.imageViews objectAtIndex:(3 * 11 + 1)];
        imageView.image = [UIImage imageNamed:@"HeroGrassRight.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 2)];
        imageView.image = [UIImage imageNamed:@"River.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 3)];
        imageView.image = [UIImage imageNamed:@"River.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 5)];
        imageView.image = [UIImage imageNamed:@"IceTwoOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 7)];
        imageView.image = [UIImage imageNamed:@"HeroGrassRight.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 8)];
        imageView.image = [UIImage imageNamed:@"Ice.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 9)];
        imageView.image = [UIImage imageNamed:@"Ice.png"];
        
        self.explainLabel.text = @"If you use level 2 ice magic, the river in the next 2 places will be frozen, thus turn to a iced place. But you can use it only when there are 2 places next to you.";
    }
    else if (self.index == 14) //display ice magic level 3
    {
        UIImageView* imageView = [self.imageViews objectAtIndex:(2 * 11 + 1)];
        imageView.image = [UIImage imageNamed:@"River.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 2)];
        imageView.image = [UIImage imageNamed:@"River.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 3)];
        imageView.image = [UIImage imageNamed:@"River.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 5)];
        imageView.image = [UIImage imageNamed:@"IceThreeOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 7)];
        imageView.image = [UIImage imageNamed:@"Ice.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 8)];
        imageView.image = [UIImage imageNamed:@"Ice.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 9)];
        imageView.image = [UIImage imageNamed:@"Ice.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 2)];
        imageView.image = [UIImage imageNamed:@"HeroGrassUp.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 8)];
        imageView.image = [UIImage imageNamed:@"HeroGrassUp.png"];
        
        self.explainLabel.text = @"If you use level 3 ice magic, the place A next to your current place, and the two places next to place A will be frozen, thus turn to a iced place. You can use it only when these three places exist.";
    }
    else if (self.index == 15) //display electric magic
    {
        UIImageView* imageView = [self.imageViews objectAtIndex:(2 * 11 + 4)];
        imageView.image = [UIImage imageNamed:@"ElectricOff.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 6)];
        imageView.image = [UIImage imageNamed:@"ElectricOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 3)];
        imageView.image = [UIImage imageNamed:@"ElectricOneOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 5)];
        imageView.image = [UIImage imageNamed:@"ElectricTwoOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 7)];
        imageView.image = [UIImage imageNamed:@"ElectricThreeOn.png"];
        
        self.explainLabel.text = @"The first two images stands for electric magic, when the magic was chosen, it will be lighted, otherwise it's gray. After you choosed the electric magic, the three level of fire magic will light on, then you can press one of the three images in the second line to use it.";
    }
    else if (self.index == 16) //display electric magic level 1
    {
        UIImageView* imageView = [self.imageViews objectAtIndex:(3 * 11 + 2)];
        imageView.image = [UIImage imageNamed:@"HeroGrassRight.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 3)];
        imageView.image = [UIImage imageNamed:@"Rock.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 5)];
        imageView.image = [UIImage imageNamed:@"ElectricOneOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 7)];
        imageView.image = [UIImage imageNamed:@"HeroGrassRight.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 8)];
        imageView.image = [UIImage imageNamed:@"Grass.png"];
        
        self.explainLabel.text = @"If you use level 1 electric magic, the rock next to you will be destroied, thus turn to grass.";
    }
    else if (self.index == 17) //display electric magic level 2
    {
        UIImageView* imageView = [self.imageViews objectAtIndex:(3 * 11 + 1)];
        imageView.image = [UIImage imageNamed:@"HeroGrassRight.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 2)];
        imageView.image = [UIImage imageNamed:@"Rock.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 3)];
        imageView.image = [UIImage imageNamed:@"Rock.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 5)];
        imageView.image = [UIImage imageNamed:@"ElectricTwoOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 7)];
        imageView.image = [UIImage imageNamed:@"HeroGrassRight.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 8)];
        imageView.image = [UIImage imageNamed:@"Grass.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 9)];
        imageView.image = [UIImage imageNamed:@"Grass.png"];
        
        self.explainLabel.text = @"If you use level 2 electric magic, the rock in the next 2 places will be destroied, thus turn to grass. But you can use it only when there are 2 places next to you.";
    }
    else if (self.index == 18) //display electric magic level 3
    {
        UIImageView* imageView = [self.imageViews objectAtIndex:(2 * 11 + 1)];
        imageView.image = [UIImage imageNamed:@"Rock.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 2)];
        imageView.image = [UIImage imageNamed:@"Rock.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 3)];
        imageView.image = [UIImage imageNamed:@"Rock.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 5)];
        imageView.image = [UIImage imageNamed:@"ElectricThreeOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 7)];
        imageView.image = [UIImage imageNamed:@"Grass.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 8)];
        imageView.image = [UIImage imageNamed:@"Grass.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 9)];
        imageView.image = [UIImage imageNamed:@"Grass.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 2)];
        imageView.image = [UIImage imageNamed:@"HeroGrassUp.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 8)];
        imageView.image = [UIImage imageNamed:@"HeroGrassUp.png"];
        
        self.explainLabel.text = @"If you use level 3 electric magic, the rock in place A next to your current place, and rock in the two places next to place A will be destroied, thus turn to grass. You can use it only when these three places exist.";
    }
    else if (self.index == 19) //display hiden magic
    {
        UIImageView* imageView = [self.imageViews objectAtIndex:(1 * 11 + 4)];
        imageView.image = [UIImage imageNamed:@"HideOff.png"];
        
        imageView = [self.imageViews objectAtIndex:(1 * 11 + 6)];
        imageView.image = [UIImage imageNamed:@"HideOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 3)];
        imageView.image = [UIImage imageNamed:@"HideOneOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 5)];
        imageView.image = [UIImage imageNamed:@"HideTwoOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 7)];
        imageView.image = [UIImage imageNamed:@"HideThreeOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(5 * 11 + 4)];
        imageView.image = [UIImage imageNamed:@"HeroGrassRight.png"];
        
        imageView = [self.imageViews objectAtIndex:(5 * 11 + 6)];
        imageView.image = [UIImage imageNamed:@"InvisibleHeroGrassRight.png"];
        
        self.explainLabel.text = @"The first two images stands for hide magic, when the magic was chosen, it will be lighted, otherwise it's gray. After you choosed the fire magic, the three level of fire magic will light on, then you can press one of the three images in the second line to use it. After you use hide magic, you will become invisible, then you can walk around the monster. But can't use other magic when you are invisible.";
    }
    else if (self.index == 20) //display jump magic
    {
        UIImageView* imageView = [self.imageViews objectAtIndex:(2 * 11 + 4)];
        imageView.image = [UIImage imageNamed:@"JumpOff.png"];
        
        imageView = [self.imageViews objectAtIndex:(2 * 11 + 6)];
        imageView.image = [UIImage imageNamed:@"JumpOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 3)];
        imageView.image = [UIImage imageNamed:@"JumpOneOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 5)];
        imageView.image = [UIImage imageNamed:@"JumpTwoOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(4 * 11 + 7)];
        imageView.image = [UIImage imageNamed:@"JumpThreeOn.png"];
        
        self.explainLabel.text = @"The first two images stands for jump magic, when the magic was chosen, it will be lighted, otherwise it's gray. After you choosed the fire magic, the three level of fire magic will light on, then you can press one of the three images in the second line to use it.";
    }
    else if (self.index == 21) //display jump magic level 1
    {
        UIImageView* imageView = [self.imageViews objectAtIndex:(3 * 11 + 1)];
        imageView.image = [UIImage imageNamed:@"HeroGrassRight.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 2)];
        imageView.image = [UIImage imageNamed:@"Rock.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 3)];
        imageView.image = [UIImage imageNamed:@"Grass.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 5)];
        imageView.image = [UIImage imageNamed:@"JumpOneOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 7)];
        imageView.image = [UIImage imageNamed:@"Grass.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 8)];
        imageView.image = [UIImage imageNamed:@"Rock.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 9)];
        imageView.image = [UIImage imageNamed:@"HeroGrassRight.png"];
        
        self.explainLabel.text = @"If you use level 1 jump magic, you will jump to the place next to the place next to you, you can't jump to a place with has tree, rock or monster.";
    }
    else if (self.index == 22) //display jump magic level 2
    {
        UIImageView* imageView = [self.imageViews objectAtIndex:(3 * 11 + 0)];
        imageView.image = [UIImage imageNamed:@"HeroGrassRight.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 1)];
        imageView.image = [UIImage imageNamed:@"Rock.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 2)];
        imageView.image = [UIImage imageNamed:@"Grass.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 3)];
        imageView.image = [UIImage imageNamed:@"Grass.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 5)];
        imageView.image = [UIImage imageNamed:@"JumpTwoOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 7)];
        imageView.image = [UIImage imageNamed:@"Grass.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 8)];
        imageView.image = [UIImage imageNamed:@"Rock.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 9)];
        imageView.image = [UIImage imageNamed:@"Grass.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 10)];
        imageView.image = [UIImage imageNamed:@"HeroGrassRight.png"];
        
        self.explainLabel.text = @"If you use level 2 jump magic, you will jump to the place 2 squares away from you, but you can't jump to a place with has tree, rock or monster.";
    }
    else if (self.index == 23) //display jump magic level 3
    {
        UIImageView* imageView = [self.imageViews objectAtIndex:(3 * 11 + 0)];
        imageView.image = [UIImage imageNamed:@"HeroGrassRight.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 1)];
        imageView.image = [UIImage imageNamed:@"Rock.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 2)];
        imageView.image = [UIImage imageNamed:@"Rock.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 3)];
        imageView.image = [UIImage imageNamed:@"Rock.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 4)];
        imageView.image = [UIImage imageNamed:@"Grass.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 5)];
        imageView.image = [UIImage imageNamed:@"JumpThreeOn.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 6)];
        imageView.image = [UIImage imageNamed:@"Grass.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 7)];
        imageView.image = [UIImage imageNamed:@"Rock.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 8)];
        imageView.image = [UIImage imageNamed:@"Rock.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 9)];
        imageView.image = [UIImage imageNamed:@"Rock.png"];
        
        imageView = [self.imageViews objectAtIndex:(3 * 11 + 10)];
        imageView.image = [UIImage imageNamed:@"HeroGrassRight.png"];
        
        self.explainLabel.text = @"If you use level 3 jump magic, you will jump to the place 3 squares away from you, but you can't jump to a place with has tree, rock or monster.";
    }
    else if (self.index == 24)
    {
        self.index = 0;
        self.gameStatus = @"ChooseGameLevel";
        [self chooseGameLevel];
    }
}

/*
 This method handles the event that player touched the screen
 It can be either move, choose magic type, and use magic
 But when a magic was used, before it's finished, any touch action is not working
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.gameStatus isEqualToString:@"GameRunning"])
    {
        if (!self.magicInProcess)
        {
            UITouch* touch = [touches anyObject];
            CGPoint touchPoint = [touch locationInView:self.view];
            UIImageView* imageView = [[UIImageView alloc] init];
            BOOL touchedCave = NO, touchedMagics = NO, touchedMagic = NO;
            
            int index = 0, x = 0, y = 0;
            
            for (int i = 0; i < [self.imageViews count]; i++)
            {
                imageView = [self.imageViews objectAtIndex:i];
                if(CGRectContainsPoint(imageView.frame, touchPoint))
                {
                    touchedCave = YES;
                    index = i;
                    break;
                }
            }
            
            for (int i = 0; i < 5; i++)
            {
                imageView = [self.magics objectAtIndex:i];
                if (CGRectContainsPoint(imageView.frame, touchPoint))
                {
                    touchedMagics = YES;
                    index = i;
                    break;
                }
            }
            
            for (int i = 0; i < 3; i++)
            {
                imageView = [self.magicLevels objectAtIndex:i];
                if (CGRectContainsPoint(imageView.frame, touchPoint))
                {
                    touchedMagic = YES;
                    index = i;
                    break;
                }
            }
            
            if (touchedCave)  // When user touches the cave, player will move
            {
                x = index / 11;
                y = index % 11;
                [self move:x andPositionY:y];
            }
            else if (touchedMagics) // When user touches the magics, it will open or close subfunctions
                [self chooseMagicType:index];
            else if (touchedMagic) // When user click a subfunction of magic, nothing will happen or the magic level will be chosen
                [self useMagic:index];
        }
    }
    else if ([self.gameStatus isEqualToString:@"ChooseGameLevel"])
    {
        UITouch* touch = [touches anyObject];
        CGPoint touchPoint = [touch locationInView:self.view];
        UIImageView* imageView1 = [self.imageViews objectAtIndex:89];
        UIImageView* imageView2 = [self.imageViews objectAtIndex:91];
        UIImageView* imageView3 = [self.imageViews objectAtIndex:93];
        UIImageView* imageView4 = [self.imageViews objectAtIndex:95];
        UIImageView* imageView5 = [self.imageViews objectAtIndex:97];
        UIImageView* imageView6 = [self.imageViews objectAtIndex:111];
        UIImageView* imageView7 = [self.imageViews objectAtIndex:113];
        UIImageView* imageView8 = [self.imageViews objectAtIndex:115];
        UIImageView* imageView9 = [self.imageViews objectAtIndex:117];
        UIImageView* imageView10 = [self.imageViews objectAtIndex:119];
        
        if (CGRectContainsPoint(imageView1.frame, touchPoint))
        {
            self.levelNumber = 1;
            self.gameStatus = @"GameRunning";
            [self startGame];
        }
        else if (CGRectContainsPoint(imageView2.frame, touchPoint))
        {
            self.levelNumber = 2;
            self.gameStatus = @"GameRunning";
            [self startGame];
        }
        else if (CGRectContainsPoint(imageView3.frame, touchPoint))
        {
            self.levelNumber = 3;
            self.gameStatus = @"GameRunning";
            [self startGame];
        }
        else if (CGRectContainsPoint(imageView4.frame, touchPoint))
        {
            self.levelNumber = 4;
            self.gameStatus = @"GameRunning";
            [self startGame];
        }
        else if (CGRectContainsPoint(imageView5.frame, touchPoint))
        {
            self.levelNumber = 5;
            self.gameStatus = @"GameRunning";
            [self startGame];
        }
        else if (CGRectContainsPoint(imageView6.frame, touchPoint))
        {
            self.levelNumber = 6;
            self.gameStatus = @"GameRunning";
            [self startGame];
        }
        else if (CGRectContainsPoint(imageView7.frame, touchPoint))
        {
            self.levelNumber = 7;
            self.gameStatus = @"GameRunning";
            [self startGame];
        }
        else if (CGRectContainsPoint(imageView8.frame, touchPoint))
        {
            self.levelNumber = 8;
            self.gameStatus = @"GameRunning";
            [self startGame];
        }
        else if (CGRectContainsPoint(imageView9.frame, touchPoint))
        {
            self.levelNumber = 9;
            self.gameStatus = @"GameRunning";
            [self startGame];
        }
        else if (CGRectContainsPoint(imageView10.frame, touchPoint))
        {
            self.levelNumber = 10;
            self.gameStatus = @"GameRunning";
            [self startGame];
        }
        else if (CGRectContainsPoint(self.startTutorial.frame, touchPoint))
        {
            self.index = 1;
            self.gameStatus = @"TutorialRunning";
            [self displayTutorial];
        }
    }
    else if ([self.gameStatus isEqualToString:@"GameWin"] && self.levelNumber != 10)
    {
        UITouch* touch = [touches anyObject];
        CGPoint touchPoint = [touch locationInView:self.view];
        
        UIImageView* imageView1 = self.leftChoice;
        UIImageView* imageView2 = self.rightChoice;
        
        if (CGRectContainsPoint(imageView1.frame, touchPoint))
        {
            self.gameStatus = @"GameRunning";
            self.levelNumber++;
            [self startGame];
        }
        if (CGRectContainsPoint(imageView2.frame, touchPoint))
        {
            self.gameStatus = @"ChooseGameLevel";
            [self chooseGameLevel];
        }

    }
    else if ([self.gameStatus isEqualToString:@"TutorialRunning"])
    {
        UITouch* touch = [touches anyObject];
        CGPoint touchPoint = [touch locationInView:self.view];
        
        if (CGRectContainsPoint(self.nextExplain.frame, touchPoint))
        {
            self.index++;
            [self displayTutorial];
        }
        if (CGRectContainsPoint(self.skipTutorial.frame, touchPoint))
        {
            self.index = 0;
            self.gameStatus = @"ChooseGameLevel";
            [self chooseGameLevel];
        }
    }
    else   // [self.gameStatus isEqualToString:@"GameEnd"] or the last level
    {
        UITouch* touch = [touches anyObject];
        CGPoint touchPoint = [touch locationInView:self.view];
        
        UIImageView* imageView1 = self.leftChoice;
        UIImageView* imageView2 = self.rightChoice;
        
        
        
        if (CGRectContainsPoint(imageView1.frame, touchPoint))
        {
            self.gameStatus = @"GameRunning";
            [self startGame];
        }
        if (CGRectContainsPoint(imageView2.frame, touchPoint))
        {
            self.gameStatus = @"ChooseGameLevel";
            [self chooseGameLevel];
        }
    }
}



/*
 Below this comment, the following method is designed for moving action
 For moving action, there are 3 results, success, fail, and dead
 For details of these 3 results, please refers to the document
 1. Success: change the current picture to the original one, change the next picture to player, and update player location.
 2. Fail: just change the direction of player.
 3. Dead: Game over
 */

//This method provide the distance between two number
-(int)getDistance:(int)a B:(int)b
{
    if (a > b)
        return a - b;
    else
        return b - a;
}

//This method will check whether there is any monster around this place
-(BOOL)isMonsterAround:(int)x andY:(int)y
{
    //Check the upside and downside places
    int neighX = x - 1, neighY = y;
    if ((neighX >= 0) && (neighX <= 10) && (neighY >= 0) && (neighY <= 10))
    {
        NSString* pic = [[self.cave objectAtIndex:neighX] objectAtIndex:neighY];
        if ([pic isEqualToString:@"Monster"])
            return YES;
    }
    neighX = x + 1;
    if ((neighX >= 0) && (neighX <= 10) && (neighY >= 0) && (neighY <= 10))
    {
        NSString* pic = [[self.cave objectAtIndex:neighX] objectAtIndex:neighY];
        if ([pic isEqualToString:@"Monster"])
            return YES;
    }
    //Check the left and right side places
    neighX = x;
    neighY = y - 1;
    if ((neighX >= 0) && (neighX <= 10) && (neighY >= 0) && (neighY <= 10))
    {
        NSString* pic = [[self.cave objectAtIndex:neighX] objectAtIndex:neighY];
        if ([pic isEqualToString:@"Monster"])
            return YES;
    }
    neighY = y + 1;
    if ((neighX >= 0) && (neighX <= 10) && (neighY >= 0) && (neighY <= 10))
    {
        NSString* pic = [[self.cave objectAtIndex:neighX] objectAtIndex:neighY];
        if ([pic isEqualToString:@"Monster"])
            return YES;
    }
    return NO;
}

/*
 This method used to check the result of a moving action, it can either be Success, Fail or Dead.
 Success means this action can be done, and game continue.
 Fail means this action can't be done, and game continue.
 //Dead means this action can be done, and game over.
 Other things means this action can be done, but the game will over, and the returned string is the dead type
 */
-(NSString*)resultOfMoving:(int)x andY:(int)y
{
    //Get the content of this place, i.e. the picture name
    NSString* place = [[self.cave objectAtIndex:x] objectAtIndex:y];
    
    //Two possibilities, player invisible or not
    if ([self.player.status isEqualToString:@"Normal"] || self.player.hidenTimes == 1)
    {
        if ([place isEqualToString:@"Ice"] || [place isEqualToString:@"Grass"] || [place isEqualToString:@"Ground"])
        {
            if ([self isMonsterAround:x andY:y])
                return @"AteByMonster";
            else
                return @"Success";
        }
        else if ([place isEqualToString:@"Tree"] || [place isEqualToString:@"Rock"] || [place isEqualToString:@"Monster"])
            return @"Fail";    //Tree, Rock and Monster are inavailable places
        else if ([place isEqualToString:@"Exit"])
            return @"Win";
        else
            return place;      //River and Pit can cause the death of player, the death type will be returned
    }
    else   // Player is invisible, can walk around monsters without be eaten
    {
        if ([place isEqualToString:@"Ice"] || [place isEqualToString:@"Grass"] || [place isEqualToString:@"Ground"])
            return @"Success";
        else if ([place isEqualToString:@"Tree"] || [place isEqualToString:@"Rock"] || [place isEqualToString:@"Monster"])
            return @"Fail";
        else if ([place isEqualToString:@"Exit"])
            return @"Win";
        else
            return place;
    }
}

/*
 This method handles the moving action of player.
 x, y are the positions of the touched place.
 */
-(void)move:(int)x andPositionY:(int)y
{
    //Position X and postion y records the current place
    int nextX = 0, nextY = 0, currentIndex = 0;
    int currentX = self.player.locationX;
    int currentY = self.player.locationY;
    //Find out the current index of player picture in collection of imageViews
    currentIndex = 11 * currentX + currentY;
    NSString* direction = @"";
    
    if (!([self getDistance:x B:currentX] == [self getDistance:y B:currentY]))
    {
        nextX = currentX;
        nextY = currentY;
        
        //First get the direction of moving, and record the next place's location
        if ([self getDistance:currentX B:x] > [self getDistance:currentY B:y])
        {
            if (x > currentX)
            {
                nextX++;
                direction = @"Down";
            }
            else
            {
                nextX--;
                direction = @"Up";
            }
        }
        else
        {
            if (y > currentY)
            {
                nextY++;
                direction = @"Right";
            }
            else
            {
                nextY--;
                direction = @"Left";
            }
        }
        
        // Now we have the location of next place, and the direction of player, check the result of this moving action
        if ([[self resultOfMoving:nextX andY:nextY] isEqualToString:@"Success"])
            [self updateImagesForSuccessfulMoving:nextX andY:nextY andDirection:direction];
        else if ([[self resultOfMoving:nextX andY:nextY] isEqualToString:@"Fail"])
            [self updateImagesForFailedMoving:direction];
        else if ([[self resultOfMoving:nextX andY:nextY] isEqualToString:@"Win"])
        {
            self.gameStatus = @"GameWin";
            [self gameWin];
        }
        else
            [self updateImagesForEndGame:nextX andY:nextY];
    }
}

// This method implement the changes of images when a moving action is successfully done.
-(void)updateImagesForSuccessfulMoving:(int)x andY:(int)y andDirection:(NSString*)direction
{
    int currentIndex = 11 * self.player.locationX + self.player.locationY;
    int nextIndex = 11 * x + y;
    
    //If player was invisible, after a successful moving action, the hidenTimes should decrease by 1
    if ([self.player.status isEqualToString:@"Invisible"])
    {
        if (self.player.hidenTimes > 1)
            self.player.hidenTimes--;
        else
        {
            self.player.hidenTimes = 0;
            self.player.status = @"Normal";
            [self displayFiveTypesOfMagics];
        }
    }
    
    //Find out the original image of the current place, change the current place to the original image
    UIImageView* imageView = [self.imageViews objectAtIndex:currentIndex];
    NSString* orgImage = [[self.cave objectAtIndex:self.player.locationX] objectAtIndex:self.player.locationY];
    imageView.image = [UIImage imageNamed:orgImage];
    
    //Change the picture in next place to "Hero"
    imageView = [self.imageViews objectAtIndex:nextIndex];
	NSString* nextImage = [[self.cave objectAtIndex:x] objectAtIndex:y];
    NSString* heroImage = @"";
    if ([self.player.status isEqualToString:@"Normal"])
        heroImage = [NSString stringWithFormat:@"Hero%@%@.png", nextImage, direction];
    else
        heroImage = [NSString stringWithFormat:@"InvisibleHero%@%@.png", nextImage, direction];
    
    imageView.image = [UIImage imageNamed:heroImage];
    
    //Update player location
    [self.player updateLocation:x andLocationY:y andDirection:direction];
    
    self.moveLeft--;
    
    [self updateCurrentLimitation];
    
    if (self.moveLeft == 0)
    {
        self.gameStatus = @"GameEnd";
        [self gameOver];
    }
}

//This method implements the change of images when a moving action is not allowed
-(void)updateImagesForFailedMoving:(NSString*)direction
{
    int currentIndex = 11 * self.player.locationX + self.player.locationY;
    self.player.facingDirection = direction;
    UIImageView* imageView = [self.imageViews objectAtIndex:currentIndex];
    NSString* heroImage = @"";
	NSString* thisImage = [[self.cave objectAtIndex:self.player.locationX] objectAtIndex:self.player.locationY];
    if ([self.player.status isEqualToString:@"Normal"])
        heroImage = [NSString stringWithFormat:@"Hero%@%@.png", thisImage, direction];
    else
        heroImage = [NSString stringWithFormat:@"InvisibleHero%@%@.png", thisImage, direction];
    imageView.image = [UIImage imageNamed:heroImage];
}

//This method implements the view of game ending after a player died
-(void)updateImagesForEndGame:(int)x andY:(int)y
{
    self.index = 0;
    NSString* orgPic = [[self.cave objectAtIndex:self.player.locationX] objectAtIndex:self.player.locationY];
    NSString* orgPicName = [NSString stringWithFormat:@"%@.png", orgPic];
    UIImageView* imageView = [self.imageViews objectAtIndex:(11 * self.player.locationX + self.player.locationY)];
    imageView.image = [UIImage imageNamed:orgPicName];
    
    self.player.locationX = x;
    self.player.locationY = y;
    self.magicInProcess = YES;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(displayTomb) userInfo:nil repeats:YES];
}

-(void)displayTomb
{
    if (self.index < 21)
        self.index++;
    
    if (self.index < 21)
    {
        int x = self.player.locationX, y = self.player.locationY;
        UIImageView* imageView = [self.imageViews objectAtIndex:(11 * x + y)];
        NSString* imageName = [NSString stringWithFormat:@"Tomb%d.png", self.index];
        imageView.image = [UIImage imageNamed:imageName];
    }
    else
    {
        self.gameStatus = @"GameEnd";
        self.magicInProcess = NO;
        [self gameOver];
        [self.timer invalidate];
        self.timer = nil;
    }
}


//Now, all methods for moving action are done


/*
 Below this comment, the following methods are designed for choosing a magic type
 */


/*
 When a type of magic is chosen
 if the current chosen magic is No, the three pictures that stands for different levels of the new chosen magic show up(light version)
 if the current chosen magic is not No, change the three pictures to dark version
 When player is using Hide magic, all magics and magic level pictures will keep in dark version
 */
-(void)chooseMagicType:(int)index
{
    if (self.magicLeft > 0)
    {
        if ([self.player.status isEqualToString:@"Normal"])
        {
            if ([self.magicTypeChosen isEqualToString:@"No"])
            {
                switch (index)
                {
                    case 0:
                        self.magicTypeChosen = @"Fire";
                        [self displayThreeLevelsOfMagic:@"Fire"];
                        break;
                    case 1:
                        self.magicTypeChosen = @"Ice";
                        [self displayThreeLevelsOfMagic:@"Ice"];
                        break;
                    case 2:
                        self.magicTypeChosen = @"Electric";
                        [self displayThreeLevelsOfMagic:@"Electric"];
                        break;
                    case 3:
                        self.magicTypeChosen = @"Hide";
                        [self displayThreeLevelsOfMagic:@"Hide"];
                        break;
                    case 4:
                        self.magicTypeChosen = @"Jump";
                        [self displayThreeLevelsOfMagic:@"Jump"];
                        break;
                    default:
                        break;
                }
            }
            else
            {
                [self hideThreeLevelsOfMagic:self.magicTypeChosen];
                self.magicTypeChosen = @"No";
            }
        }
    }
}

-(void)displayThreeLevelsOfMagic:(NSString*)magicType
{
    UIImageView* imageView = [self.magicLevels objectAtIndex:0];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@OneOn.png", magicType]];
    imageView = [self.magicLevels objectAtIndex:1];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@TwoOn.png", magicType]];
    imageView = [self.magicLevels objectAtIndex:2];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@ThreeOn.png", magicType]];
}

-(void)hideThreeLevelsOfMagic:(NSString*)magicType
{
    UIImageView* imageView = [self.magicLevels objectAtIndex:0];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@OneOff.png", magicType]];
    imageView = [self.magicLevels objectAtIndex:1];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@TwoOff.png", magicType]];
    imageView = [self.magicLevels objectAtIndex:2];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@ThreeOff.png", magicType]];
}

-(void)displayFiveTypesOfMagics
{
    UIImageView* imageView = [self.magics objectAtIndex:0];
    imageView.image = [UIImage imageNamed:@"FireOn.png"];
    imageView = [self.magics objectAtIndex:1];
    imageView.image = [UIImage imageNamed:@"IceOn.png"];
    imageView = [self.magics objectAtIndex:2];
    imageView.image = [UIImage imageNamed:@"ElectricOn.png"];
    imageView = [self.magics objectAtIndex:3];
    imageView.image = [UIImage imageNamed:@"HideOn.png"];
    imageView = [self.magics objectAtIndex:4];
    imageView.image = [UIImage imageNamed:@"JumpOn.png"];
}

-(void)hideFiveTypesOfMagic
{
    UIImageView* imageView = [self.magics objectAtIndex:0];
    imageView.image = [UIImage imageNamed:@"FireOff.png"];
    imageView = [self.magics objectAtIndex:1];
    imageView.image = [UIImage imageNamed:@"IceOff.png"];
    imageView = [self.magics objectAtIndex:2];
    imageView.image = [UIImage imageNamed:@"ElectricOff.png"];
    imageView = [self.magics objectAtIndex:3];
    imageView.image = [UIImage imageNamed:@"HideOff.png"];
    imageView = [self.magics objectAtIndex:4];
    imageView.image = [UIImage imageNamed:@"JumpOff.png"];
}



//Now, all methods designed for choosing magic action are done.


/*
 Below this comment, the following methods are designed for using magic action.
 There are five types of magic: Fire, Ice, Electric, Hide, Jump.
 Fire, Ice, Electric, Jump will be used when it's clicked, a short video will be shown using timer.
 When the video is acting, no actions can be done.
 Hide will be used when it's clicked, a short video will be shown using timer, hide the player in () seconds.
 Then the player's state change to Invisible, until the player run out of hiding times
 */

// Before we use a magic, we need to confirm whether the magic type was chosen or not
/*
 If player is Invisible, he can't use any magic.
 If player is visible, i.e. is in Normal status, whether he can use magic or not is depends on his location.
 1. He can use Hide magic anywhere he want.
 2. He can use Fire and Electric and Ice when the next place of his facing direction exist.
 3. He can use Jump when the place he will be jumped to exist, and level will be considered only for Jump magic.
 */
-(BOOL)canUseMagic
{
    if (self.magicLeft > 0)
    {
        if ([self.player.status isEqualToString:@"Invisible"])  //Can't use magic when player is invisible
            return NO;
        else
        {
            if ([self.magicTypeChosen isEqualToString:@"Hide"])   //Hide can be use when player is visible
                return YES;
            else if ([self.magicTypeChosen isEqualToString:@"No"])
                return NO;
            else if ([self.magicTypeChosen isEqualToString:@"Jump"])
            {
                int x = self.player.locationX, y = self.player.locationY;
                //We need to find out the next place that the player will be jumped to according to his direction and level
                if ([self.player.facingDirection isEqualToString:@"Up"])
                {
                    if (self.magicLevelChosen == 1) x -= 2;
                    else if (self.magicLevelChosen == 2) x -= 3;
                    else x-= 4;
                }
                else if ([self.player.facingDirection isEqualToString:@"Down"])
                {
                    if (self.magicLevelChosen == 1) x += 2;
                    else if (self.magicLevelChosen == 2) x += 3;
                    else x += 4;
                }
                else if ([self.player.facingDirection isEqualToString:@"Left"])
                {
                    if (self.magicLevelChosen == 1) y -= 2;
                    else if (self.magicLevelChosen == 2) y -= 3;
                    else y -= 4;
                }
                else
                {
                    if (self.magicLevelChosen == 1) y += 2;
                    else if (self.magicLevelChosen == 2) y += 3;
                    else y += 4;
                }
                //Now we get next place's location, if this location is in the range of images, then he can jump
                if (x >= 0 && x <= 10 && y >= 0 && y <= 10)
                {
                    if (![[self resultOfMoving:x andY:y] isEqualToString:@"Fail"])
                        return YES;
                    else
                        return NO;
                }
                else
                    return NO;
            }
            else
            {
                if (self.magicLevelChosen == 1)
                {
                    int x = self.player.locationX, y = self.player.locationY;
                    if ([self.player.facingDirection isEqualToString:@"Up"]) x--;
                    else if ([self.player.facingDirection isEqualToString:@"Down"]) x++;
                    else if ([self.player.facingDirection isEqualToString:@"Left"]) y--;
                    else y++;
                    
                    if (x >= 0 && x <= 10 && y >= 0 && y <= 10)
                        return YES;
                    else
                        return NO;
                }
                else if (self.magicLevelChosen == 2)
                {
                    int x = self.player.locationX, y = self.player.locationY;
                    if ([self.player.facingDirection isEqualToString:@"Up"]) x -= 2;
                    else if ([self.player.facingDirection isEqualToString:@"Down"]) x += 2;
                    else if ([self.player.facingDirection isEqualToString:@"Left"]) y -= 2;
                    else y += 2;
                    
                    if (x >= 0 && x <= 10 && y >= 0 && y <= 10)
                        return YES;
                    else
                        return NO;
                }
                else
                {
                    int x = self.player.locationX, y = self.player.locationY;
                    if ([self.player.facingDirection isEqualToString:@"Up"])
                    {
                        if (x > 0 && x <= 10 && y > 0 && y < 10)
                            return YES;
                        else
                            return NO;
                    }
                    else if ([self.player.facingDirection isEqualToString:@"Down"])
                    {
                        if (x >= 0 && x < 10 && y > 0 && y < 10)
                            return YES;
                        else
                            return NO;
                    }
                    else if ([self.player.facingDirection isEqualToString:@"Left"])
                    {
                        if (x > 0 && x < 10 && y > 0 && y <= 10)
                            return YES;
                        else
                            return NO;
                    }
                    else
                    {
                        if (x > 0 && x < 10 && y >= 0 && y < 10)
                            return YES;
                        else
                            return NO;
                    }
                }
            }
        }
    }
    else
        return NO;
}

/*
 This method is designed for magic using action.
 First we need to check whether we can use magic or not.
 If we can, then make a magic in use, update the images, then set the magic chosen type to No.
 If we can't, print a message, you can't use this magic right now.
 */
-(void)useMagic:(int)index
{
    self.magicLevelChosen = index + 1;
    if ([self canUseMagic])
    {
        self.magicLeft--;
        [self updateCurrentLimitation];
        if (self.magicLeft == 0)
        {
            [self hideFiveTypesOfMagic];
            [self hideThreeLevelsOfMagic:@"Fire"];
        }
        
        self.magicInProcess = YES;
        [self updateImagesForUsingMagic];
    }
    else
        self.magicLevelChosen = 0;
}

-(void)updateImagesForUsingMagic
{
    if ([self.magicTypeChosen isEqualToString:@"Jump"])
    {
        //Reset the index of the displayed image, so the picture will be displayed in this order
        self.index = 0;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(displayJumpMagic) userInfo:nil repeats:YES];
        [self hideThreeLevelsOfMagic:@"Jump"];
    }
    else if ([self.magicTypeChosen isEqualToString:@"Hide"])
    {
        self.index = 0;
        self.player.status = @"Invisible";
        self.player.hidenTimes = self.magicLevelChosen + 1;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(displayHideMagic) userInfo:nil repeats:YES];
        [self hideFiveTypesOfMagic];
        [self hideThreeLevelsOfMagic:@"Hide"];
    }
    else if ([self.magicTypeChosen isEqualToString:@"Fire"])
    {
        self.index = 0;
        NSURL* soundFile = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Fire" ofType:@"wav"]];
        
        NSError* error;
        magic = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFile error:&error];
        [magic prepareToPlay];
        [magic play];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(displayFireMagic) userInfo:nil repeats:YES];
        [self hideThreeLevelsOfMagic:@"Fire"];
    }
    else if ([self.magicTypeChosen isEqualToString:@"Electric"])
    {
        self.index = 0;
        NSURL* soundFile = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Electric" ofType:@"mp3"]];
        
        NSError* error;
        magic = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFile error:&error];
        [magic prepareToPlay];
        [magic play];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(displayElectricMagic) userInfo:nil repeats:YES];
        [self hideThreeLevelsOfMagic:@"Electric"];
    }
    else  // Magic type is Ice
    {
        self.index = 0;
        NSURL* soundFile = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Ice" ofType:@"mp3"]];
        
        NSError* error;
        magic = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFile error:&error];
        [magic prepareToPlay];
        [magic play];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(displayIceMagic) userInfo:nil repeats:YES];
        [self hideThreeLevelsOfMagic:@"Ice"];
    }
    self.magicTypeChosen = @"No";
}

-(void)displayIceMagic
{
    if (self.index < 7)
        self.index++;
    
    if (self.magicLevelChosen == 1)
    {
        int x = self.player.locationX, y = self.player.locationY;
        if ([self.player.facingDirection isEqualToString:@"Up"])
            x--;
        else if ([self.player.facingDirection isEqualToString:@"Down"])
            x++;
        else if ([self.player.facingDirection isEqualToString:@"Left"])
            y--;
        else
            y++;
        [self updateRiverImages:x andY:y];
    }
    
    if (self.magicLevelChosen == 2)
    {
        //(x1, y1) records the next place, (x2, y2) records the place next to the next place
        int x1 = self.player.locationX, y1 = self.player.locationY, x2 = self.player.locationX, y2 = self.player.locationY;
        if ([self.player.facingDirection isEqualToString:@"Up"])
        {
            x1--;
            x2 -= 2;
        }
        else if ([self.player.facingDirection isEqualToString:@"Down"])
        {
            x1++;
            x2 += 2;
        }
        else if ([self.player.facingDirection isEqualToString:@"Left"])
        {
            y1--;
            y2 -= 2;
        }
        else
        {
            y1++;
            y2 += 2;
        }
        [self updateRiverImages:x1 andY:y1];
        [self updateRiverImages:x2 andY:y2];
    }
    
    if (self.magicLevelChosen == 3)
    {
        // (x1, y1) records the information of the upside picture
        // (x2, y2) records the information of the left side of upside picture
        // (x3, y3) records the information of the right side of upside picture
        int x1 = self.player.locationX, y1 = self.player.locationY;
        int x2 = x1, x3 = x1, y2 = y1, y3 = y1;
        if ([self.player.facingDirection isEqualToString:@"Up"])
        {
            x1--;
            x2 = x1;
            x3 = x1;
            y2--;
            y3++;
        }
        else if ([self.player.facingDirection isEqualToString:@"Down"])
        {
            x1++;
            x2 = x1;
            x3 = x1;
            y2--;
            y3++;
        }
        else if ([self.player.facingDirection isEqualToString:@"Left"])
        {
            y1--;
            y2 = y1;
            y3 = y1;
            x2--;
            x3++;
        }
        else
        {
            y1++;
            y2 = y1;
            y3 = y1;
            x2--;
            x3++;
        }
        [self updateRiverImages:x1 andY:y1];
        [self updateRiverImages:x2 andY:y2];
        [self updateRiverImages:x3 andY:y3];
    }
    
    // When the magic is done, stop timer, make the chosen magic type back to No, make the level of magic to 0
    if (self.index == 7)
    {
        self.index = 0;
        [self.timer invalidate];
        self.magicInProcess = NO;
        self.magicLevelChosen = 0;
        [magic stop];
    }
}

//This method is designed to avoid duplicated operation in the displayIceMagic method
-(void)updateRiverImages:(int)x andY:(int)y
{
    UIImageView* imageView = [self.imageViews objectAtIndex:(11 * x + y)];
    NSString* imageContent = [[self.cave objectAtIndex:x] objectAtIndex:y];
    NSString* imageName = @"";
    if ([imageContent isEqualToString:@"River"])
    {
        if (self.index == 7)
        {
            imageName = @"Ice.png";
            [[self.cave objectAtIndex:x] replaceObjectAtIndex:y withObject:@"Ice"];
        }
        else
            imageName = [NSString stringWithFormat:@"Ice%d.png", self.index];
        
        imageView.image = [UIImage imageNamed:imageName];
    }
}


-(void)displayFireMagic
{
    if (self.index < 14)
        self.index++;
    
    if (self.magicLevelChosen == 1)
    {
        int x = self.player.locationX, y = self.player.locationY;
        if ([self.player.facingDirection isEqualToString:@"Up"])
            x--;
        else if ([self.player.facingDirection isEqualToString:@"Down"])
            x++;
        else if ([self.player.facingDirection isEqualToString:@"Left"])
            y--;
        else
            y++;
        [self updateBuringImages:x andY:y];
    }
    
    if (self.magicLevelChosen == 2)
    {
        //(x1, y1) records the next place, (x2, y2) records the place next to the next place
        int x1 = self.player.locationX, y1 = self.player.locationY, x2 = self.player.locationX, y2 = self.player.locationY;
        if ([self.player.facingDirection isEqualToString:@"Up"])
        {
            x1--;
            x2 -= 2;
        }
        else if ([self.player.facingDirection isEqualToString:@"Down"])
        {
            x1++;
            x2 += 2;
        }
        else if ([self.player.facingDirection isEqualToString:@"Left"])
        {
            y1--;
            y2 -= 2;
        }
        else
        {
            y1++;
            y2 += 2;
        }
        [self updateBuringImages:x1 andY:y1];
        [self updateBuringImages:x2 andY:y2];
    }
    
    if (self.magicLevelChosen == 3)
    {
        // (x1, y1), (x2, y2), (x3, y3) record three places that the magic will be used
        int x1 = self.player.locationX, y1 = self.player.locationY;
        int x2 = x1, x3 = x1, y2 = y1, y3 = y1;
        if ([self.player.facingDirection isEqualToString:@"Up"])
        {
            x1--;
            x2 = x1;
            x3 = x1;
            y2--;
            y3++;
        }
        else if ([self.player.facingDirection isEqualToString:@"Down"])
        {
            x1++;
            x2 = x1;
            x3 = x1;
            y2--;
            y3++;
        }
        else if ([self.player.facingDirection isEqualToString:@"Left"])
        {
            y1--;
            y2 = y1;
            y3 = y1;
            x2--;
            x3++;
        }
        else
        {
            y1++;
            y2 = y1;
            y3 = y1;
            x2--;
            x3++;
        }
        [self updateBuringImages:x1 andY:y1];
        [self updateBuringImages:x2 andY:y2];
        [self updateBuringImages:x3 andY:y3];
    }
    
    // When the magic is done, stop timer, make the chosen magic type back to No, make the level of magic to 0
    if (self.index == 14)
    {
        self.index = 0;
        [self.timer invalidate];
        self.magicInProcess = NO;
        self.magicLevelChosen = 0;
        [magic stop];
    }
}

-(void)updateBuringImages:(int)x andY:(int)y
{
    UIImageView* imageView = [self.imageViews objectAtIndex:(11 * x + y)];
    NSString* imageContent = [[self.cave objectAtIndex:x] objectAtIndex:y];
    NSString* imageName = @"";
    if ([imageContent isEqualToString:@"Tree"] || [imageContent isEqualToString:@"Grass"])
    {
        if (self.index == 14)
        {
            imageName = @"Ground.png";
            [[self.cave objectAtIndex:x] replaceObjectAtIndex:y withObject:@"Ground"];
        }
        else
            imageName = [NSString stringWithFormat:@"Fire%d.png", self.index];
        imageView.image = [UIImage imageNamed:imageName];
    }
}

-(void)displayElectricMagic
{
    if (self.index < 10)
        self.index++;
    
    if (self.magicLevelChosen == 1)
    {
        int x = self.player.locationX, y = self.player.locationY;
        if ([self.player.facingDirection isEqualToString:@"Up"])
            x--;
        else if ([self.player.facingDirection isEqualToString:@"Down"])
            x++;
        else if ([self.player.facingDirection isEqualToString:@"Left"])
            y--;
        else
            y++;
        [self updateRockImages:x andY:y];
    }
    
    if (self.magicLevelChosen == 2)
    {
        //(x1, y1) records the next place, (x2, y2) records the place next to the next place
        int x1 = self.player.locationX, y1 = self.player.locationY, x2 = self.player.locationX, y2 = self.player.locationY;
        if ([self.player.facingDirection isEqualToString:@"Up"])
        {
            x1--;
            x2 -= 2;
        }
        else if ([self.player.facingDirection isEqualToString:@"Down"])
        {
            x1++;
            x2 += 2;
        }
        else if ([self.player.facingDirection isEqualToString:@"Left"])
        {
            y1--;
            y2 -= 2;
        }
        else
        {
            y1++;
            y2 += 2;
        }
        [self updateRockImages:x1 andY:y1];
        [self updateRockImages:x2 andY:y2];
    }
    
    if (self.magicLevelChosen == 3)
    {
        // (x1, y1), (x2, y2), (x3, y3) record three places that the magic will be used
        int x1 = self.player.locationX, y1 = self.player.locationY;
        int x2 = x1, x3 = x1, y2 = y1, y3 = y1;
        if ([self.player.facingDirection isEqualToString:@"Up"])
        {
            x1--;
            x2 = x1;
            x3 = x1;
            y2--;
            y3++;
        }
        else if ([self.player.facingDirection isEqualToString:@"Down"])
        {
            x1++;
            x2 = x1;
            x3 = x1;
            y2--;
            y3++;
        }
        else if ([self.player.facingDirection isEqualToString:@"Left"])
        {
            y1--;
            y2 = y1;
            y3 = y1;
            x2--;
            x3++;
        }
        else
        {
            y1++;
            y2 = y1;
            y3 = y1;
            x2--;
            x3++;
        }
        [self updateRockImages:x1 andY:y1];
        [self updateRockImages:x2 andY:y2];
        [self updateRockImages:x3 andY:y3];
    }
    
    // When the magic is done, stop timer, make the chosen magic type back to No, make the level of magic to 0
    if (self.index == 10)
    {
        self.index = 0;
        [self.timer invalidate];
        self.magicInProcess = NO;
        self.magicLevelChosen = 0;
        [magic stop];
    }
}

-(void)updateRockImages:(int)x andY:(int)y
{
    UIImageView* imageView = [self.imageViews objectAtIndex:(11 * x + y)];
    NSString* imageContent = [[self.cave objectAtIndex:x] objectAtIndex:y];
    NSString* imageName = @"";
    if ([imageContent isEqualToString:@"Rock"])
    {
        if (self.index == 10)
        {
            imageName = @"Grass.png";
            [[self.cave objectAtIndex:x] replaceObjectAtIndex:y withObject:@"Grass"];
        }
        else
            imageName = [NSString stringWithFormat:@"Electric%d.png", self.index];
        
        imageView.image = [UIImage imageNamed:imageName];
    }
    
}

-(void)displayJumpMagic
{
    if (self.index < 11)
        self.index++;
    int currentX = self.player.locationX, currentY = self.player.locationY;
    int nextX = 0, nextY = 0, distance = 0;
    
    if (self.magicLevelChosen == 1)
        distance = 2;
    else if (self.magicLevelChosen == 2)
        distance = 3;
    else if (self.magicLevelChosen == 3)
        distance = 4;
    
    if ([self.player.facingDirection isEqualToString:@"Up"])
    {
        nextX = currentX - distance;
        nextY = currentY;
    }
    else if ([self.player.facingDirection isEqualToString:@"Down"])
    {
        nextX = currentX + distance;
        nextY = currentY;
    }
    else if ([self.player.facingDirection isEqualToString:@"Left"])
    {
        nextY = currentY - distance;
        nextX = currentX;
    }
    else
    {
        nextY = currentY + distance;
        nextX = currentX;
    }
    
    UIImageView* imageView1 = [self.imageViews objectAtIndex:(currentY + 11 * currentX)];
    UIImageView* imageView2 = [self.imageViews objectAtIndex:(nextX * 11 + nextY)];
    
    NSString* orgPic = [[self.cave objectAtIndex:currentX] objectAtIndex:currentY];
    NSString* nextPic = [[self.cave objectAtIndex:nextX] objectAtIndex:nextY];
    NSString* nextViewOfImageInTheOrgPlace = @"";
    NSString* nextViewOfImageInTheNextPlace = @"";
    
    if (self.index > 0 && self.index <= 4)
    {
        nextViewOfImageInTheOrgPlace = [NSString stringWithFormat:@"Jump%d.png", self.index];
        imageView1.image = [UIImage imageNamed:nextViewOfImageInTheOrgPlace];
    }
    else if (self.index == 5)
    {
        imageView1.image = [UIImage imageNamed:orgPic];
        imageView2.image = [UIImage imageNamed:@"Jump5.png"];
    }
    else if (self.index > 5 && self.index < 11)
    {
        nextViewOfImageInTheNextPlace = [NSString stringWithFormat:@"Jump%d.png", self.index];
        imageView2.image = [UIImage imageNamed:nextViewOfImageInTheNextPlace];
    }
    else  //self.index = 11
    {
		imageView2.image = [UIImage imageNamed:([NSString stringWithFormat:@"Hero%@%@.png", nextPic, self.player.facingDirection])];
        
        [self.player updateLocation:nextX andLocationY:nextY andDirection:self.player.facingDirection];
        
        self.index = 0;
        [self.timer invalidate];
        self.magicInProcess = NO;
        self.magicLevelChosen = 0;
        if (![[self resultOfMoving:nextX andY:nextY] isEqualToString:@"Success"])
        {
            if ([[self resultOfMoving:nextX andY:nextY] isEqualToString:@"Win"])
            {
                self.gameStatus = @"GameWin";
                [self gameWin];
            }
            else
                [self updateImagesForEndGame:nextX andY:nextY];
        }
    }
}

-(void)displayHideMagic
{
    if (self.index < 7)
        self.index++;
    
    NSString* thisImage = [[self.cave objectAtIndex:self.player.locationX] objectAtIndex:self.player.locationY];
    NSString* heroImage = @"";
    if (self.index == 7)
        heroImage = [NSString stringWithFormat:@"InvisibleHero%@%@.png", thisImage, self.player.facingDirection];
    else
        heroImage = [NSString stringWithFormat:@"Hide%d.png", self.index];
    
    UIImageView* imageView = [self.imageViews objectAtIndex:(11 * self.player.locationX + self.player.locationY)];
    imageView.image = [UIImage imageNamed:heroImage];
    
    if (self.index == 7)
    {
        self.index = 0;
        [self.timer invalidate];
        self.magicInProcess = NO;
        self.magicLevelChosen = 0;
    }
}

//Now, all methods designed for using magic are finished



@end