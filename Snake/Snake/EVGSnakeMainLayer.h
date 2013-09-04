//
//  HelloWorldLayer.h
//  Snake
//
//  Created by Elena Vielva on 22/01/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "EVGSnake.h"
#import "EVGFood.h"
#import "EVGCollisionDetector.h"

#define EASY   0
#define MEDIUM 1
#define HARD   2

// Importing Chipmunk headers
//#import "chipmunk.h"

// HelloWorldLayer
@interface EVGSnakeMainLayer : CCLayer {
	cpSpace *space;
    EVGSnake *snake;
    EVGFood *food;
    
    EVGCollisionDetector *detector;
    
    CGSize wins;

    float prevAccX;
    float prevAccY;
    
    int level;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
-(void) step: (ccTime) dt;
-(void) move;
-(void) eatingDetected;
-(CGPoint) getRandomPosition;

@end
