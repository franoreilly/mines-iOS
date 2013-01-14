//
//  MSNode.h
//  Minesweeper
//
//  Created by Francis O'Reilly on 16/11/2012.
//  Copyright (c) 2012 Francis O'Reilly. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MSNode;
@class MSGrid;

@interface MSNode : UIButton {
    BOOL bomb;
    //TODO: use proper constants below
    NSInteger coveredState;  //1:covered 2:marked 3:uncovered
    NSInteger numBombNeighbours;
    NSMutableSet* neighbours;
    CGRect* rect;
    NSInteger posx;
    NSInteger posy;
    MSGrid* parent;
}

- (void) calculateBombNeighbours;
- (void) nodeTapped : (id) sender;
- (void) nodeDragged : (id) sender;
- (void) uncover: (BOOL) propagateToParent;

@property (nonatomic, assign) BOOL isBomb;
@property (nonatomic) NSInteger coveredState;
@property (nonatomic) NSInteger numBombNeighbours;
@property (nonatomic) NSInteger posx;
@property (nonatomic) NSInteger posy;
@property (nonatomic, retain) NSMutableSet* neighbours;
@property (nonatomic, retain) MSGrid* parent;
@property (nonatomic) CGRect rect;

@end


