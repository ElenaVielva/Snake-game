//
//  EVGCollisionDetector.m
//  Snake
//
//  Created by Elena Vielva on 22/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EVGCollisionDetector.h"

@implementation EVGCollisionDetector

-(id) initWithFood:(EVGFood*) aFood {
    food = aFood;
    return self;
}

- (BOOL) check:(CGPoint) pos {
    
    CGPoint pos2 = food.position;
    
    float distance = sqrtf( (pos.x - pos2.x)*(pos.x - pos2.x) + (pos.y - pos2.y)*(pos.y - pos2.y) );
    
    if (distance < FOODRADIOUS/4 + SNAKERADIOUS) {
        return YES;
    }
    return NO;
}

-(void) placeFood:(CGPoint) pos {
    [food changePosition:pos];
}

@end
