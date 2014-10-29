//
//  Level.m
//  Tower Of Sorcerer
//
//  Created by Yue Xu on 25/05/2014.
//  Copyright (c) 2014 Yue Xu. All rights reserved.
//

#import "Level.h"

@implementation Level

-(id)initWithNumber:(int)level
{
    if (self = [super init])
    {
        self.content = [[NSMutableArray alloc] initWithCapacity:11];
        NSMutableArray* row1 = [[NSMutableArray alloc] init];
        NSMutableArray* row2 = [[NSMutableArray alloc] init];
        NSMutableArray* row3 = [[NSMutableArray alloc] init];
        NSMutableArray* row4 = [[NSMutableArray alloc] init];
        NSMutableArray* row5 = [[NSMutableArray alloc] init];
        NSMutableArray* row6 = [[NSMutableArray alloc] init];
        NSMutableArray* row7 = [[NSMutableArray alloc] init];
        NSMutableArray* row8 = [[NSMutableArray alloc] init];
        NSMutableArray* row9 = [[NSMutableArray alloc] init];
        NSMutableArray* row10 = [[NSMutableArray alloc] init];
        NSMutableArray* row11 = [[NSMutableArray alloc] init];
        
        if (level == 1)
        {
            row1 = [NSMutableArray arrayWithObjects:@"River", @"River", @"River", @"Tree", @"Grass", @"Tree", @"Tree", @"Tree", @"Grass", @"Tree", @"Exit", nil];
            row2 = [NSMutableArray arrayWithObjects:@"River", @"River", @"Tree", @"Tree", @"Tree", @"Tree", @"Tree", @"Tree", @"Grass", @"Tree", @"Tree", nil];
            row3 = [NSMutableArray arrayWithObjects:@"River", @"Tree", @"Grass", @"Grass", @"Tree", @"Grass", @"Grass", @"Tree", @"Tree", @"Grass", @"Tree", nil];
            row4 = [NSMutableArray arrayWithObjects:@"River", @"Rock", @"Tree", @"Tree", @"Tree", @"Grass", @"Grass", @"Tree", @"Grass", @"Tree", @"Grass", nil];
            row5 = [NSMutableArray arrayWithObjects:@"River", @"River", @"Tree", @"Grass", @"Grass", @"Tree", @"Tree", @"Tree", @"Grass", @"Tree", @"Grass", nil];
            row6 = [NSMutableArray arrayWithObjects:@"River", @"River", @"Tree", @"Grass", @"Tree", @"Tree", @"Grass", @"Tree", @"Grass", @"Tree", @"River", nil];
            row7 = [NSMutableArray arrayWithObjects:@"Tree", @"Tree", @"Tree", @"Tree", @"Grass", @"Grass", @"Tree", @"Grass", @"Tree", @"River", @"River", nil];
            row8 = [NSMutableArray arrayWithObjects:@"Tree", @"Tree", @"Grass", @"Tree", @"Grass", @"Grass", @"Grass", @"Tree", @"River", @"River", @"River", nil];
            row9 = [NSMutableArray arrayWithObjects:@"Tree", @"Tree", @"Grass", @"Tree", @"Tree", @"Tree", @"Tree", @"Tree", @"River", @"River", @"River", nil];
            row10 = [NSMutableArray arrayWithObjects:@"Tree", @"Tree", @"Grass", @"Tree", @"Grass", @"Grass", @"Tree", @"Tree", @"River", @"River", @"River", nil];
            row11 = [NSMutableArray arrayWithObjects:@"Ground", @"Ground", @"Ground", @"Tree", @"Grass", @"Grass", @"Tree", @"Tree", @"Rock", @"River", @"River", nil];
        }
        else if (level == 2)
        {
            row1 = [NSMutableArray arrayWithObjects:@"Tree", @"Tree", @"River", @"River", @"River", @"River", @"River", @"River", @"River", @"Grass", @"Exit", nil];
            row2 = [NSMutableArray arrayWithObjects:@"Tree", @"Tree", @"River", @"River", @"River", @"River", @"River", @"River", @"River", @"Grass", @"Grass", nil];
            row3 = [NSMutableArray arrayWithObjects:@"River", @"Tree", @"Tree", @"River", @"River", @"River", @"River", @"River", @"River", @"Tree", @"Tree", nil];
            row4 = [NSMutableArray arrayWithObjects:@"River", @"Grass", @"Tree", @"Tree", @"River", @"River", @"River", @"River", @"River", @"Tree", @"Tree", nil];
            row5 = [NSMutableArray arrayWithObjects:@"River", @"Grass", @"Tree", @"Tree", @"River", @"River", @"Tree", @"Tree", @"River", @"River", @"Tree", nil];
            row6 = [NSMutableArray arrayWithObjects:@"River", @"Tree", @"Grass", @"Grass", @"River", @"River", @"Tree", @"Tree", @"River", @"River", @"River", nil];
            row7 = [NSMutableArray arrayWithObjects:@"River", @"River", @"River", @"River", @"River", @"River", @"River", @"River", @"River", @"Tree", @"Tree", nil];
            row8 = [NSMutableArray arrayWithObjects:@"River", @"River", @"River", @"River", @"River", @"Tree", @"Tree", @"Tree", @"River", @"Tree", @"Tree", nil];
            row9 = [NSMutableArray arrayWithObjects:@"Grass", @"River", @"River", @"River", @"River", @"River", @"Tree", @"Tree", @"River", @"Tree", @"Tree", nil];
            row10 = [NSMutableArray arrayWithObjects:@"Grass", @"Grass", @"River", @"River", @"River", @"River", @"River", @"River", @"River", @"Tree", @"Tree", nil];
            row11 = [NSMutableArray arrayWithObjects:@"Ground", @"Grass", @"Grass", @"River", @"River", @"River", @"Rock", @"Rock", @"Rock", @"Tree", @"Tree", nil];
        }
        else if (level == 3)
        {
            row1 = [NSMutableArray arrayWithObjects:@"River", @"Tree", @"Rock", @"Rock", @"Grass", @"Grass", @"Grass", @"Rock", @"Grass", @"Rock", @"Exit", nil];
            row2 = [NSMutableArray arrayWithObjects:@"River", @"Tree", @"Grass", @"Grass", @"Grass", @"Rock", @"Rock", @"Rock", @"Grass", @"Rock", @"Tree", nil];
            row3 = [NSMutableArray arrayWithObjects:@"River", @"River", @"Rock", @"Rock", @"Tree", @"River", @"River", @"River", @"Rock", @"Rock", @"River", nil];
            row4 = [NSMutableArray arrayWithObjects:@"River", @"River", @"Grass", @"Rock", @"Tree", @"River", @"River", @"River", @"River", @"River", @"River", nil];
            row5 = [NSMutableArray arrayWithObjects:@"River", @"Grass", @"Grass", @"Rock", @"Grass", @"Ground", @"Tree", @"River", @"River", @"Rock", @"River", nil];
            row6 = [NSMutableArray arrayWithObjects:@"River", @"Grass", @"Rock", @"Rock", @"Rock", @"Ground", @"Rock", @"River", @"River", @"Tree", @"River", nil];
            row7 = [NSMutableArray arrayWithObjects:@"Grass", @"Grass", @"Rock", @"Grass", @"Rock", @"Rock", @"Grass", @"Rock", @"Rock", @"Tree", @"River", nil];
            row8 = [NSMutableArray arrayWithObjects:@"Rock", @"Rock", @"Grass", @"Grass", @"Rock", @"Rock", @"Grass", @"Rock", @"Tree", @"River", @"River", nil];
            row9 = [NSMutableArray arrayWithObjects:@"River", @"River", @"Rock", @"Grass", @"Rock", @"Rock", @"Grass", @"Rock", @"River", @"River", @"River", nil];
            row10 = [NSMutableArray arrayWithObjects:@"River", @"River", @"River", @"Rock", @"Rock", @"Grass", @"Grass", @"Grass", @"River", @"River", @"River", nil];
            row11 = [NSMutableArray arrayWithObjects:@"Ground", @"Ground", @"River", @"River", @"Rock", @"Grass", @"Grass", @"Rock", @"Tree", @"River", @"River", nil];
        }
        else if (level == 4)
        {
            row1 = [NSMutableArray arrayWithObjects:@"Monster", @"Ground", @"Ground", @"Ground", @"Ground", @"Ground", @"Monster", @"Ground", @"Ground", @"Ground", @"Exit", nil];
            row2 = [NSMutableArray arrayWithObjects:@"River", @"Ground", @"Ground", @"Monster", @"Ground", @"Monster", @"Ground", @"Ground", @"Monster", @"Ground", @"Monster", nil];
            row3 = [NSMutableArray arrayWithObjects:@"River", @"Ground", @"Monster", @"Ground", @"Ground", @"Ground", @"Ground", @"Ground", @"Tree", @"Ground", @"Tree", nil];
            row4 = [NSMutableArray arrayWithObjects:@"River", @"River", @"Ground", @"Monster", @"Ground", @"Ground", @"Monster", @"Ground", @"Ground", @"Monster", @"River", nil];
            row5 = [NSMutableArray arrayWithObjects:@"River", @"River", @"River", @"River", @"River", @"River", @"River", @"River", @"Ground", @"River", @"River", nil];
            row6 = [NSMutableArray arrayWithObjects:@"River", @"River", @"River", @"River", @"River", @"River", @"River", @"River", @"River", @"River", @"River", nil];
            row7 = [NSMutableArray arrayWithObjects:@"River", @"River", @"Monster", @"River", @"River", @"River", @"River", @"Monster", @"River", @"River", @"River", nil];
            row8 = [NSMutableArray arrayWithObjects:@"Rock", @"Monster", @"Ground", @"Rock", @"River", @"Monster", @"Ground", @"River", @"River", @"Ground", @"Ground", nil];
            row9 = [NSMutableArray arrayWithObjects:@"Monster", @"Ground", @"Ground", @"Ground", @"Rock", @"Ground", @"Ground", @"River", @"River", @"River", @"Monster", nil];
            row10 = [NSMutableArray arrayWithObjects:@"Ground", @"Ground", @"Monster", @"Ground", @"Ground", @"Ground", @"Ground", @"Rock", @"River", @"River", @"River", nil];
            row11 = [NSMutableArray arrayWithObjects:@"Ground", @"Ground", @"Ground", @"Ground", @"Monster", @"Ground", @"Ground", @"River", @"River", @"River", @"River", nil];
        }
        else if (level == 5)
        {
            row1 = [NSMutableArray arrayWithObjects:@"Grass", @"Grass", @"Pit", @"Tree", @"Tree", @"Tree", @"River", @"River", @"Pit", @"River", @"Exit", nil];
            row2 = [NSMutableArray arrayWithObjects:@"Grass", @"Grass", @"Pit", @"Tree", @"Tree", @"Rock", @"Ground", @"Pit", @"Grass", @"Grass", @"Pit", nil];
            row3 = [NSMutableArray arrayWithObjects:@"Grass", @"Grass", @"Pit", @"Grass", @"Pit", @"Tree", @"Rock", @"Pit", @"Grass", @"Grass", @"Pit", nil];
            row4 = [NSMutableArray arrayWithObjects:@"Pit", @"Grass", @"Pit", @"Pit", @"Pit", @"Ground", @"Pit", @"Pit", @"Pit", @"Tree", @"Ground", nil];
            row5 = [NSMutableArray arrayWithObjects:@"Grass", @"Grass", @"Pit", @"Pit", @"Ground", @"Ground", @"Ground", @"Pit", @"Pit", @"Tree", @"Ground", nil];
            row6 = [NSMutableArray arrayWithObjects:@"Rock", @"Ground", @"Ground", @"Pit", @"Tree", @"Tree", @"Ground", @"Pit", @"Pit", @"Ground", @"River", nil];
            row7 = [NSMutableArray arrayWithObjects:@"Ground", @"Ground", @"Ground", @"Pit", @"Tree", @"Tree", @"Ground", @"Ground", @"Rock", @"Ground", @"River", nil];
            row8 = [NSMutableArray arrayWithObjects:@"Pit", @"Pit", @"Pit", @"Tree", @"River", @"River", @"River", @"River", @"Rock", @"River", @"River", nil];
            row9 = [NSMutableArray arrayWithObjects:@"Pit", @"Pit", @"Pit", @"River", @"River", @"River", @"River", @"River", @"Rock", @"River", @"River", nil];
            row10 = [NSMutableArray arrayWithObjects:@"Pit", @"Ground", @"Pit", @"River", @"River", @"River", @"River", @"River", @"Rock", @"Rock", @"River", nil];
            row11 = [NSMutableArray arrayWithObjects:@"Ground", @"Ground", @"Pit", @"Tree", @"Tree", @"Tree", @"River", @"River", @"Rock", @"Ground", @"Ground", nil];
        }
        else if (level == 6)
        {
            row1 = [NSMutableArray arrayWithObjects:@"River", @"River", @"Ground", @"Grass", @"Monster", @"Grass", @"Grass", @"Tree", @"Ground", @"Ground", @"Exit", nil];
            row2 = [NSMutableArray arrayWithObjects:@"River", @"River", @"Rock", @"Rock", @"Rock", @"Ground", @"Ground", @"Tree", @"Pit", @"Grass", @"Tree", nil];
            row3 = [NSMutableArray arrayWithObjects:@"Tree", @"Tree", @"Ground", @"Ground", @"Tree", @"Monster", @"Pit", @"Tree", @"Grass", @"Grass", @"Grass", nil];
            row4 = [NSMutableArray arrayWithObjects:@"Tree", @"River", @"River", @"Ground", @"Grass", @"Ground", @"Tree", @"Tree", @"Rock", @"Rock", @"Rock", nil];
            row5 = [NSMutableArray arrayWithObjects:@"Grass", @"River", @"River", @"Ground", @"Grass", @"Pit", @"Grass", @"Rock", @"Grass", @"Grass", @"Tree", nil];
            row6 = [NSMutableArray arrayWithObjects:@"Tree", @"River", @"River", @"Monster", @"Grass", @"Ground", @"Ground", @"Ground", @"River", @"Tree", @"Tree", nil];
            row7 = [NSMutableArray arrayWithObjects:@"River", @"River", @"Grass", @"Tree", @"Pit", @"Monster", @"Grass", @"Grass", @"River", @"Tree", @"Tree", nil];
            row8 = [NSMutableArray arrayWithObjects:@"River", @"River", @"Grass", @"Grass", @"Grass", @"Ground", @"Ground", @"Grass", @"River", @"River", @"Tree", nil];
            row9 = [NSMutableArray arrayWithObjects:@"River", @"Tree", @"Grass", @"Rock", @"Rock", @"Ground", @"Grass", @"Grass", @"River", @"River", @"River", nil];
            row10 = [NSMutableArray arrayWithObjects:@"Tree", @"Tree", @"Ground", @"Rock", @"Monster", @"Ground", @"Grass", @"Pit", @"Grass", @"Grass", @"Grass", nil];
            row11 = [NSMutableArray arrayWithObjects:@"Ground", @"Ground", @"Ground", @"Ground", @"Pit", @"Ground", @"Tree", @"Monster", @"Ground", @"Grass", @"Grass", nil];
        }
        else if (level == 7)
        {
            row1 = [NSMutableArray arrayWithObjects:@"Pit", @"Tree", @"River", @"Pit", @"Pit", @"Exit", @"Pit", @"Pit", @"River", @"River", @"River", nil];
            row2 = [NSMutableArray arrayWithObjects:@"Grass", @"Grass", @"Tree", @"River", @"Pit", @"Pit", @"Pit", @"River", @"Tree", @"Rock", @"Rock", nil];
            row3 = [NSMutableArray arrayWithObjects:@"Rock", @"Grass", @"Grass", @"Monster", @"River", @"Pit", @"River", @"Monster", @"Grass", @"Grass", @"Monster", nil];
            row4 = [NSMutableArray arrayWithObjects:@"Grass", @"Monster", @"Grass", @"Grass", @"River", @"River", @"River", @"Grass", @"Grass", @"Grass", @"Tree", nil];
            row5 = [NSMutableArray arrayWithObjects:@"Grass", @"Grass", @"Monster", @"Grass", @"Rock", @"River", @"Rock", @"Grass", @"Grass", @"Tree", @"River", nil];
            row6 = [NSMutableArray arrayWithObjects:@"Rock", @"Tree", @"Grass", @"Grass", @"Rock", @"River", @"Rock", @"Monster", @"Rock", @"River", @"River", nil];
            row7 = [NSMutableArray arrayWithObjects:@"Monster", @"Grass", @"Grass", @"Monster", @"Tree", @"River", @"Tree", @"Grass", @"Rock", @"River", @"River", nil];
            row8 = [NSMutableArray arrayWithObjects:@"Rock", @"Tree", @"Grass", @"Ground", @"Tree", @"River", @"Tree", @"Grass", @"Rock", @"River", @"River", nil];
            row9 = [NSMutableArray arrayWithObjects:@"Ground", @"Tree", @"Ground", @"Monster", @"River", @"River", @"River", @"Monster", @"Grass", @"Tree", @"River", nil];
            row10 = [NSMutableArray arrayWithObjects:@"Ground", @"Tree", @"Tree", @"Ground", @"River", @"River", @"River", @"Grass", @"Grass", @"Monster", @"Tree", nil];
            row11 = [NSMutableArray arrayWithObjects:@"Ground", @"Ground", @"Ground", @"Monster", @"River", @"River", @"River", @"Monster", @"Grass", @"Grass", @"Tree", nil];
        }
        else if (level == 8)
        {
            row1 = [NSMutableArray arrayWithObjects:@"Ground", @"Ground", @"Grass", @"River", @"River", @"River", @"River", @"Ground", @"Monster", @"Tree", @"Exit", nil];
            row2 = [NSMutableArray arrayWithObjects:@"Ground", @"Rock", @"Grass", @"Rock", @"River", @"River", @"Grass", @"Ground", @"Ground", @"Tree", @"Rock", nil];
            row3 = [NSMutableArray arrayWithObjects:@"Ground", @"Monster", @"Grass", @"Tree", @"River", @"River", @"Monster", @"Ground", @"Monster", @"Tree", @"Rock" , nil];
            row4 = [NSMutableArray arrayWithObjects:@"Rock", @"Grass", @"Grass", @"Tree", @"River", @"River", @"Grass", @"Pit", @"Ground", @"River", @"River", nil];
            row5 = [NSMutableArray arrayWithObjects:@"Rock", @"Grass", @"Grass", @"Rock", @"River", @"River", @"Grass", @"Grass", @"Ground", @"River", @"River", nil];
            row6 = [NSMutableArray arrayWithObjects:@"Monster", @"Grass", @"Monster", @"Rock", @"River", @"River", @"Monster", @"Rock", @"Grass", @"Grass", @"Grass", nil];
            row7 = [NSMutableArray arrayWithObjects:@"Rock", @"Ground", @"Grass", @"River", @"River", @"River", @"Grass", @"Grass", @"Pit", @"Tree", @"Grass", nil];
            row8 = [NSMutableArray arrayWithObjects:@"Rock", @"Ground", @"Grass", @"River", @"River", @"Tree", @"Grass", @"Grass", @"Tree", @"Tree", @"Rock", nil];
            row9 = [NSMutableArray arrayWithObjects:@"Grass", @"Pit", @"Tree", @"River", @"River", @"River", @"Grass", @"Rock", @"Monster", @"Tree", @"Grass", nil];
            row10 = [NSMutableArray arrayWithObjects:@"Grass", @"Pit", @"Tree", @"River", @"River", @"River", @"Grass", @"Rock", @"River", @"River", @"Grass", nil];
            row11 = [NSMutableArray arrayWithObjects:@"Ground", @"Grass", @"Monster", @"Tree", @"River", @"River", @"River", @"Monster", @"River", @"River", @"River", nil];
        }
        else if (level == 9)
        {
            row1 = [NSMutableArray arrayWithObjects:@"River", @"River", @"River", @"Rock", @"Grass", @"River", @"Grass", @"Rock", @"Tree", @"Tree", @"Exit", nil];
            row2 = [NSMutableArray arrayWithObjects:@"River", @"River", @"Tree", @"Grass", @"Monster", @"River", @"Monster", @"Grass", @"Ground", @"Monster", @"Tree", nil];
            row3 = [NSMutableArray arrayWithObjects:@"River", @"Tree", @"Rock", @"Tree", @"River", @"River", @"River", @"Tree", @"Rock", @"Ground", @"Tree", nil];
            row4 = [NSMutableArray arrayWithObjects:@"Rock", @"Monster", @"Grass", @"Grass", @"River", @"River", @"River", @"Grass", @"Rock", @"Grass", @"Ground", nil];
            row5 = [NSMutableArray arrayWithObjects:@"Grass", @"Grass", @"Grass", @"Monster", @"River", @"River", @"River", @"Monster", @"Grass", @"Grass", @"Monster", nil];
            row6 = [NSMutableArray arrayWithObjects:@"Ground", @"Rock", @"Pit", @"River", @"River", @"River", @"River", @"River", @"Pit", @"Rock", @"Grass", nil];
            row7 = [NSMutableArray arrayWithObjects:@"Ground", @"Monster", @"Tree", @"Monster", @"River", @"River", @"River", @"Monster", @"Grass", @"Grass", @"Rock", nil];
            row8 = [NSMutableArray arrayWithObjects:@"Rock", @"Ground", @"Ground", @"Grass", @"River", @"River", @"River", @"Grass", @"Grass", @"Grass", @"Rock", nil];
            row9 = [NSMutableArray arrayWithObjects:@"Rock", @"Tree", @"Ground", @"Tree", @"River", @"River", @"River", @"Tree", @"Rock", @"Tree", @"River", nil];
            row10 = [NSMutableArray arrayWithObjects:@"Tree", @"Tree", @"Ground", @"Grass", @"Monster", @"River", @"Monster", @"Grass", @"Tree", @"River", @"River", nil];
            row11 = [NSMutableArray arrayWithObjects:@"Ground", @"Ground", @"Ground", @"Rock", @"Grass", @"River", @"Grass", @"Rock", @"River", @"River", @"River", nil];
        }
        else if (level == 10)   //level == 10
        {
            row1 = [NSMutableArray arrayWithObjects:@"Tree", @"Grass", @"Rock", @"River", @"River", @"River", @"Grass", @"Grass", @"Monster", @"River", @"River", nil];
            row2 = [NSMutableArray arrayWithObjects:@"Grass", @"Pit", @"Grass", @"River", @"River", @"River", @"Grass", @"Pit", @"Grass", @"River", @"Pit", nil];
            row3 = [NSMutableArray arrayWithObjects:@"Grass", @"River", @"Monster", @"River", @"River", @"River", @"Grass", @"Grass", @"Grass", @"River", @"Exit", nil];
            row4 = [NSMutableArray arrayWithObjects:@"Monster", @"River", @"River", @"River", @"Monster", @"River", @"River", @"Monster", @"River", @"River", @"Pit", nil];
            row5 = [NSMutableArray arrayWithObjects:@"River", @"River", @"Monster", @"Grass", @"Grass", @"Grass", @"River", @"River", @"River", @"River", @"River", nil];
            row6 = [NSMutableArray arrayWithObjects:@"River", @"River", @"River", @"Grass", @"Pit", @"Grass", @"Monster", @"River", @"River", @"River", @"River", nil];
            row7 = [NSMutableArray arrayWithObjects:@"Rock", @"Tree", @"River", @"Grass", @"Grass", @"Grass", @"River", @"River", @"Monster", @"River", @"Monster", nil];
            row8 = [NSMutableArray arrayWithObjects:@"Rock", @"Tree", @"River", @"River", @"River", @"River", @"River", @"Grass", @"Grass", @"Grass", @"Grass", nil];
            row9 = [NSMutableArray arrayWithObjects:@"Grass", @"Monster", @"Grass", @"Tree", @"Rock", @"River", @"River", @"Monster", @"Grass", @"Grass", @"Grass", nil];
            row10 = [NSMutableArray arrayWithObjects:@"Grass", @"Grass", @"Grass", @"Grass", @"Monster", @"River", @"River", @"Grass", @"Grass", @"Grass", @"Tree", nil];
            row11 = [NSMutableArray arrayWithObjects:@"Ground", @"Grass", @"Pit", @"Rock", @"Grass", @"River", @"River", @"Pit", @"Pit", @"Grass", @"Tree", nil];
        }
        
        [self.content insertObject:row1 atIndex:0];
        [self.content insertObject:row2 atIndex:1];
        [self.content insertObject:row3 atIndex:2];
        [self.content insertObject:row4 atIndex:3];
        [self.content insertObject:row5 atIndex:4];
        [self.content insertObject:row6 atIndex:5];
        [self.content insertObject:row7 atIndex:6];
        [self.content insertObject:row8 atIndex:7];
        [self.content insertObject:row9 atIndex:8];
        [self.content insertObject:row10 atIndex:9];
        [self.content insertObject:row11 atIndex:10];
    }
    
    return self;
}

@end
