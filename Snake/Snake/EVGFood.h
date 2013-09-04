//
//  EVGFood.h
//  Snake
//
//  Created by Elena Vielva on 22/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "chipmunk.h"

#define FOODWIDTH   20
#define FOODHEIGHT  19
#define FOODRADIOUS 10


@interface EVGFood : CCNode {
    
    CCSprite *sprite;
    int direction;    
}

@property (nonatomic, retain) CCSprite *sprite;


-(id) initWithPosition:(CGPoint) pos;

-(void) changePosition:(CGPoint) newPos;

-(BOOL) isPointOnMe:(CGPoint)pos;

@end
