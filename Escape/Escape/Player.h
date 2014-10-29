//
//  Player.h
//  Tower Of Sorcerer
//
//  Created by Yue Xu on 22/05/14.
//  Copyright (c) 2014 Yue Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property NSString* name;
@property int locationX;
@property int locationY;
@property NSString* facingDirection;
@property BOOL isAlive;
//status can be Invisiable, and Normal
@property NSString* status;
@property int hidenTimes;

-(id)init;
-(id)initWithName:(NSString *)name andLocationX:(int)x andLocationY:(int)y andDirection:(NSString*)direction andStatus:(NSString*)status andHidenTimes:(int)hidenTimes;
-(void)updateLocation:(int)x andLocationY:(int)y andDirection:(NSString*)direction;



@end
