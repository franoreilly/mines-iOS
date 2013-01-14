//
//  MSGrid.m
//  Minesweeper
//
//  Created by Francis O'Reilly on 16/11/2012.
//  Copyright (c) 2012 Francis O'Reilly. All rights reserved.
//

#import "MSGrid.h"
#import "MSNode.h"

@implementation MSGrid

- (MSNode*)getGridRefByRow:(int)x andCol:(int)y  {
    
    if (x < 0 || y < 0 || x > 5 || y > 5) {
        return nil;
    }
    
    NSMutableArray* rowArray = [self->theArray objectAtIndex:x];
    return (MSNode*)[rowArray objectAtIndex:y];
}

- (id) initWithView:(UIView*) theView {
    self = [super init];
    if (self != nil) {
        
        theArray = [NSMutableArray array];
        for(int i = 0; i < 6; i++)
        {
            NSMutableArray *row = [NSMutableArray array];
            for (int j = 0; j < 6; j++) {
                MSNode *node = [[MSNode alloc] init];
                node.parent = self;  // track which grid this node is a member of
                [row addObject:node];
            }
            [self->theArray addObject:row];
        }
        
        //initialise num neighbours and CGRect
        for(int i=0; i<6; i++){
            for (int j=0; j<6; j++){
                MSNode* n = [self getGridRefByRow:i andCol:j];
                n.rect = CGRectMake(20+40*i, 20+40*j, 35, 35);
                n.posx = i;
                n.posy = j;
                n.backgroundColor = [UIColor greenColor];
                [n setFrame:n.rect];
                [theView addSubview:n];
                
                MSNode* m = [self getGridRefByRow:i-1 andCol:j-1];
                if (m != nil) {
                    [n.neighbours addObject:m];
                }
                m = [self getGridRefByRow:i andCol:j-1];
                if (m != nil) {
                    [n.neighbours addObject:m];
                }
                m = [self getGridRefByRow:i+1 andCol:j-1];
                if (m != nil) {
                    [n.neighbours addObject:m];
                }
                m = [self getGridRefByRow:i-1 andCol:j];
                if (m != nil) {
                    [n.neighbours addObject:m];
                }
                m = [self getGridRefByRow:i+1 andCol:j];
                if (m != nil) {
                    [n.neighbours addObject:m];
                }
                m = [self getGridRefByRow:i-1 andCol:j+1];
                if (m != nil) {
                    [n.neighbours addObject:m];
                }
                m = [self getGridRefByRow:i andCol:j+1];
                if (m != nil) {
                    [n.neighbours addObject:m];
                }
                m = [self getGridRefByRow:i+1 andCol:j+1];
                if (m != nil) {
                    [n.neighbours addObject:m];
                }
            }
        }
        
        //calculate the number of neighbours
        for (int i=0; i<6; i++){
            for (int j=0; j<6; j++){
                MSNode *n = [self getGridRefByRow:i andCol:j];
                [n calculateBombNeighbours];
                if (n.isBomb) {
                    NSLog(@"%d,%d: bomb:YES, %d",i,j,n.numBombNeighbours);
                } else {
                    NSLog(@"%d,%d: bomb:NO, %d",i,j,n.numBombNeighbours);
                }
            }
        }
    }
    return self;
}

- (void) bombWasTouched {
    for (int i=0; i<6; i++) {
        for (int j=0; j<6; j++) {
            MSNode* n = [self getGridRefByRow:i andCol:j];
            [n uncover:false];
        }
    }
    
    //give the user the bad news
    UIAlertView* badnews = [[UIAlertView alloc] initWithTitle:@"BANG!" message:@"Uh oh. Clicked on a bomb. Game over!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [badnews show];
}

@end
