//
//  EVGFood.m
//  Snake
//
//  Created by Elena Vielva on 22/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EVGFood.h"

@implementation EVGFood

@synthesize sprite = sprite;


-(id) init {
    return [self initWithPosition:ccp(60, 60)];
}

-(id) initWithPosition:(CGPoint) pos {
    
    sprite = [CCSprite spriteWithFile:@"snake_food.png"];
    [sprite setPosition:pos];
    [self setPosition:pos];
    
    return self;
}

-(void) changePosition:(CGPoint) newPos {
    [sprite setPosition:newPos];
    [self setPosition:newPos];
    
    return;
}

-(BOOL) isPointOnMe:(CGPoint)pos {
    
    if (pos.x < sprite.position.x - FOODWIDTH/2)
        return NO;
    if (pos.x > sprite.position.x + FOODWIDTH/2)
        return NO;
    if (pos.y < sprite.position.y - FOODHEIGHT/2)
        return NO;
    if (pos.y > sprite.position.y + FOODHEIGHT/2)
        return NO;
    
    return YES;
}


@end
