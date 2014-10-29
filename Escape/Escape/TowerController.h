#import <UIKit/UIKit.h>
#import "Player.h"
#import "Level.h"
#import <AVFoundation/AVFoundation.h>

@interface TowerController : UIViewController <AVAudioPlayerDelegate>
{
    AVAudioPlayer* player;
    AVAudioPlayer* magic;
}

@property NSManagedObjectContext* managedObjectContext;
@property Player* player;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViews;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *magics;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *magicLevels;


@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UIImageView *startImage;
@property (weak, nonatomic) IBOutlet UIImageView *leftChoice;
@property (weak, nonatomic) IBOutlet UIImageView *rightChoice;


@property (weak, nonatomic) IBOutlet UILabel *explainLabel;
@property (weak, nonatomic) IBOutlet UIImageView *nextExplain;
@property (weak, nonatomic) IBOutlet UIImageView *skipTutorial;
@property (weak, nonatomic) IBOutlet UIImageView *startTutorial;

@property (weak, nonatomic) IBOutlet UIImageView *moveLimit;
@property (weak, nonatomic) IBOutlet UIImageView *magicLimit;
@property (weak, nonatomic) IBOutlet UIImageView *moveTen;
@property (weak, nonatomic) IBOutlet UIImageView *moveOne;
@property (weak, nonatomic) IBOutlet UIImageView *magicTen;
@property (weak, nonatomic) IBOutlet UIImageView *magicOne;

//These following two properties records how many times left for player to move and use magic
@property int moveLeft;
@property int magicLeft;

@property NSMutableArray* cave;
@property int levelNumber;
//If a magic type was chosen, change this property to the name of the magic
//If a magic is in use, change this property to @"UsingMagic"
//After a magic is used, change this property to @"Normal"
@property NSString* magicTypeChosen;
//This property records the chosen level of magic
@property int magicLevelChosen;

//This property is used to count the index of picture displayed by the timer, make the picture dynamic
@property int index;
@property NSTimer* timer;

//When a magic is in processing, no action can be done
@property BOOL magicInProcess;

//Here are three types of game status. ChooseGameLevel, GameRunning, GameEnd, TutorialRunning
@property NSString* gameStatus;

@end