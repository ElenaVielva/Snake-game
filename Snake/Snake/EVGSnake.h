//
//  EVGSnake.h
//  Snake
//
//  Created by Elena Vielva on 22/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "chipmunk.h"

//#import "EVGCollisionDetector.h"

#define UP    0
#define DOWN  1
#define LEFT  2
#define RIGHT 3

#define SNAKEWIDTH   72
#define SNAKEHEIGHT  72
#define SNAKERADIOUS 36

@interface EVGSnake : CCNode {
    
    CCSprite *sprite;
    int direction;
    int points;
    
//    EVGCollisionDetector *checker;
    
}

@property (nonatomic, retain) CCSprite *sprite;

-(id) initWithPosition:(CGPoint) pos;

-(void) changeDirection:(int) newDir;

-(void) move;

-(void) increasePoints:(int)newPoints;

@end
