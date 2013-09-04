//
//  EVGCollisionDetector.h
//  Snake
//
//  Created by Elena Vielva on 22/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EVGFood.h"
#import "EVGSnake.h"

@interface EVGCollisionDetector : NSObject {
    
     EVGFood *food;
    
}


-(id) initWithFood:(EVGFood*)aFood;
-(BOOL) check:(CGPoint)pos;
-(void) placeFood:(CGPoint)pos;

@end
