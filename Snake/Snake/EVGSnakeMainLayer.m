//
//  HelloWorldLayer.m
//  Snake
//
//  Created by Elena Vielva on 22/01/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "EVGSnakeMainLayer.h"
#import "EVGCollisionDetector.h"
#import <CCLayer.h>

enum {
	kTagBatchNode = 1,
};

static void
eachShape(void *ptr, void* unused) {
	cpShape *shape = (cpShape*) ptr;
	CCSprite *sprite = shape->data;
	if( sprite ) {
		cpBody *body = shape->body;
		
		// TIP: cocos2d and chipmunk uses the same struct to store it's position
		// chipmunk uses: cpVect, and cocos2d uses CGPoint but in reality the are the same
		// since v0.7.1 you can mix them if you want.		
		[sprite setPosition: body->p];
		
		[sprite setRotation: (float) CC_RADIANS_TO_DEGREES( -body->a )];
	}
}

// HelloWorldLayer implementation
@implementation EVGSnakeMainLayer

+(CCScene *) scene {
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	EVGSnakeMainLayer *layer = [EVGSnakeMainLayer node];
	
    CCLayerColor *colorLayer = [CCLayerColor layerWithColor:ccc4(230, 255, 220, 200)];
    [scene addChild:colorLayer z:0];

	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init {
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
        level = EASY;
        
		self.isTouchEnabled = YES;
		self.isAccelerometerEnabled = YES;
		
		wins = [[CCDirector sharedDirector] winSize];
		cpInitChipmunk();
        
        
        snake = [[EVGSnake alloc] initWithPosition:ccp(wins.width/2, wins.height/2)];
        food = [[EVGFood alloc] initWithPosition: [self getRandomPosition] ];
        detector = [[EVGCollisionDetector alloc] initWithFood:food];
        
        prevAccX = 0;
        prevAccY = 0;
        

        [self addChild:snake.sprite z:2];
        [self addChild:food.sprite z:1];
        
        switch (level) {
            case EASY:
                [self schedule:@selector(move) interval:0.08f];
                break;
            case MEDIUM:
                [self schedule:@selector(move) interval:0.04f];
                break;
            case HARD:
                [self schedule:@selector(move) interval:0.02f];
                break;
                
            default:
                break;
        }
        

	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc {
	// in case you have something to dealloc, do it in this method
	cpSpaceFree(space);
	space = NULL;
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

-(void) onEnter {
	[super onEnter];
	
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / 60)];
}

-(void) step: (ccTime) delta {
	int steps = 2;
	CGFloat dt = delta/(CGFloat)steps;
	
	for(int i=0; i<steps; i++){
		cpSpaceStep(space, dt);
	}
	cpSpaceHashEach(space->activeShapes, &eachShape, nil);
	cpSpaceHashEach(space->staticShapes, &eachShape, nil);
}


- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    NSLog(@"Touches ended");
}

- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration {	
    
//    NSLog(@"Acceleration: %f %f", acceleration.x, acceleration.y);

    if ([detector check:snake.position]) {
        NSLog(@"Se ha comido la fruta");
        [detector placeFood:[self getRandomPosition]];
        switch (level) {
            case EASY:
                [snake increasePoints:2];
                break;
            case MEDIUM:
                [snake increasePoints:5];
                break;
            case HARD:
                [snake increasePoints:10];
                break;
            default:
                break;
        }
        
    }
    
    if (acceleration.x < 0.2f) {
        [snake changeDirection:UP];
        return;
    }
    
    if (acceleration.x > 0.36f) {
        [snake changeDirection:DOWN];
        return;
    }
    if (acceleration.y < -0.08f) {
        [snake changeDirection:LEFT];
        return;
    }
    
    if (acceleration.y > 0.08f) {
        [snake changeDirection:RIGHT];
        return;
    }
    

}

-(void) move {
    [snake move];
}

-(void) eatingDetected {
    CGPoint pos = [self getRandomPosition];
    [food changePosition:pos];
    return;
}



-(CGPoint) getRandomPosition{
    float randomX = ( ( (float) (arc4random()%((unsigned)RAND_MAX + 1)) / RAND_MAX)*wins.width);
    float randomY = ( ( (float) (arc4random()%((unsigned)RAND_MAX + 1)) / RAND_MAX)*wins.height);

    return ccp(randomX, randomY);
}


@end
