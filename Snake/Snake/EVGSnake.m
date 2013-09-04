//
//  EVGSnake.m
//  Snake
//
//  Created by Elena Vielva on 22/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EVGSnake.h"

@implementation EVGSnake
@synthesize sprite = sprite;

/* TODO:
 *      Poner la cola de la serpiente
 *      - método:   usar imagencitas de tamaño ds * altura (o altura * ds para las giradas)
 *                  guardar un array dinámico de cada parte
 *                  eliminar la última a cada paso
 *                  Añadir una nueva en la posición que dejó la cabeza de serpiente
 */
-(id) init {
    return [self initWithPosition:ccp(20, 20)];
}

-(id) initWithPosition:(CGPoint) pos {
    
    points = 0;
    direction = LEFT;
    sprite = [CCSprite spriteWithFile:@"snake_head.png"];
    [sprite setPosition:pos];
    [self setPosition:pos];
    
    return self;
}

-(void) changeDirection:(int) newDir {

    /* Forbidden or irrelevant movements:
     *   - if the snake is going in one direction, it's not necessary to tell her 
     *     to go in this direction
     *   - if the snake is going in one direction, it is not possible to make her
     *     to go in the opposite one
     */
    if (newDir == direction)
        return;
    if (((newDir == UP) && (direction == DOWN) ) ||
        ((newDir == DOWN) && (direction == UP) ) )
        return;
    if (((newDir == LEFT) && (direction == RIGHT) ) ||
        ((newDir == RIGHT) && (direction == LEFT) ) )
        return;

    
    switch (newDir) {
        case LEFT:
            [sprite setRotation:0];
            break;
            
        case RIGHT:
            [sprite setRotation:180];
            [sprite flipY];
            break;
            
        case UP:
            [sprite setRotation:90];
            break;
            
        case DOWN:
            [sprite setRotation:270];
            break;

        default:
            break;
    }
    
    direction = newDir;
}

-(void) move {
    
    switch (direction) {
        case UP:
            [sprite setPosition:ccp(sprite.position.x, sprite.position.y+5)];
            break;
        case DOWN:
            [sprite setPosition:ccp(sprite.position.x, sprite.position.y-5)];
            break;
        case LEFT:
            [sprite setPosition:ccp(sprite.position.x-5, sprite.position.y)];
            break;
        case RIGHT:
            [sprite setPosition:ccp(sprite.position.x+5, sprite.position.y)];
            break;
        default:
            break;
    }
    [self setPosition:sprite.position];

}

/*
 It will be called if the snake hits a fruit
 */
-(void) increasePoints:(int)newPoings {
    points += newPoings;
}

@end
