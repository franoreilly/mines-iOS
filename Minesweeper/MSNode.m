//
//  MSNode.m
//  Minesweeper
//
//  Created by Francis O'Reilly on 16/11/2012.
//  Copyright (c) 2012 Francis O'Reilly. All rights reserved.
//

#import "MSNode.h"
#import "MSGrid.h"

@implementation MSNode

@synthesize neighbours;
@synthesize numBombNeighbours;

- (id) init {
    self = [super init];
    if (self != nil) {
        float randNum = arc4random() % 100; // get random number between 0 and 99 incl
        int percent_bombs = 25;
        if (randNum < percent_bombs) {
            self.isBomb = true;
        }
        else {
            self.isBomb = false;
        }
        self.coveredState = 1;  //covered
        self.numBombNeighbours = 0;
        self->neighbours = [NSMutableSet set];
        self->rect = nil;
        self.posx = -1;
        self.posy = -1;
        
        [self addTarget:self action:@selector(nodeTapped:)
            forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(nodeDragged:)
            forControlEvents:UIControlEventTouchDragExit];
    }
    return self;
}

- (void) calculateBombNeighbours {
    NSInteger count = 0;
    for (MSNode *node in self->neighbours) {
        if (node.isBomb == true) {
            count++;
        }
    }
    self->numBombNeighbours = count;

    return;
}

- (void) nodeDragged: (id) sender{
    MSNode *clicked = (MSNode *) sender;
    NSLog(@"Dragged: %d,%d",clicked.posx, clicked.posy);
    if (self.coveredState == 1) {
        self.coveredState = 2;
        self.backgroundColor = [UIColor redColor];
    } else if (self.coveredState == 2) {
        self.coveredState = 1;
        self.backgroundColor = [UIColor greenColor];
    }
}

- (void) nodeTapped: (id) sender{
    MSNode *clicked = (MSNode *) sender;
    NSLog(@"Tapped: %d,%d",clicked.posx, clicked.posy);
    //only respond to touch if unmarked. It's locked until unmarked.
    if (self.coveredState == 1) {
        // ignoring marked as locked until unmarked, also ignore already uncovered nodes
        [self uncover:true];
    }
}

- (void) uncover: (BOOL) propagateToParent {
    if (self.isBomb) {
        if (self.coveredState != 3) {
            self.coveredState = 3;
            // only bother uncovering if not already uncovered
            self.backgroundColor = [UIColor blackColor];
            if (propagateToParent) {
                [self.parent bombWasTouched];
            }
        }
    } else {
        self.coveredState = 3;
        self.backgroundColor = [UIColor yellowColor];
        UILabel *numLabel = [[UILabel alloc] init];
        NSString *bn = [NSString stringWithFormat:@"%d",self.numBombNeighbours];
        NSLog(@"bn=%@",bn);
        [numLabel setText:bn];
        [numLabel setTextColor:[UIColor blackColor]];
        [numLabel setBackgroundColor:[UIColor yellowColor]];
        [self addSubview:numLabel];
        [numLabel sizeToFit];
        [numLabel setCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)];
    }
}

@end
