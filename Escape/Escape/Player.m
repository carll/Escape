//
//  Player.m
//  Tower Of Sorcerer
//
//  Created by Yue Xu on 22/05/14.
//  Copyright (c) 2014 Yue Xu. All rights reserved.
//

#import "Player.h"

@implementation Player

-(id)init
{
    if (self = [super init])
    {
        self.name = @"Kael";
        self.locationX = 0;
        self.locationY = 0;
        self.isAlive = YES;
        self.facingDirection = @"right";
        self.status = @"Normal";
        self.hidenTimes = 0;
    }
    return self;
}

-(id)initWithName:(NSString *)name andLocationX:(int)x andLocationY:(int)y andDirection:(NSString*)direction andStatus:(NSString *)status andHidenTimes:(int)hidenTimes
{
    if (self = [super init])
    {
        self.name = name;
        self.locationX = x;
        self.locationY = y;
        self.isAlive = NO;
        self.facingDirection = direction;
        self.status = status;
        self.hidenTimes = hidenTimes;
    }
    return self;
}

-(void)updateLocation:(int)x andLocationY:(int)y andDirection:(NSString*)direction
{
    self.locationX = x;
    self.locationY = y;
    self.facingDirection = direction;
}




@end
