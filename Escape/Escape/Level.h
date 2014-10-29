//
//  Level.h
//  Tower Of Sorcerer
//
//  Created by Yue Xu on 25/05/2014.
//  Copyright (c) 2014 Yue Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Level : NSObject

@property NSMutableArray* content;

-(id)initWithNumber: (int)level;

@end
