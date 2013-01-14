//
//  MSFlipsideViewController.h
//  Minesweeper
//
//  Created by Francis O'Reilly on 13/08/2012.
//  Copyright (c) 2012 Francis O'Reilly. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSFlipsideViewController;

@protocol MSFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(MSFlipsideViewController *)controller;
@end

@interface MSFlipsideViewController : UIViewController

@property (weak, nonatomic) id <MSFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
