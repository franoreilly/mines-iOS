//
//  MSGrid.h
//  Minesweeper
//
//  Created by Francis O'Reilly on 16/11/2012.
//  Copyright (c) 2012 Francis O'Reilly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSNode.h"

@interface MSGrid : NSObject {
    NSMutableArray *theArray;
    
}
- (MSNode*)getGridRefByRow:(int)x andCol:(int)y;
- (id) initWithView:(UIView*) theView;
- (void) bombWasTouched;

@end
