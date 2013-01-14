//
//  MSMainViewController.h
//  Minesweeper
//
//  Created by Francis O'Reilly on 13/08/2012.
//  Copyright (c) 2012 Francis O'Reilly. All rights reserved.
//

#import "MSFlipsideViewController.h"

@interface MSMainViewController : UIViewController <MSFlipsideViewControllerDelegate, UIPopoverControllerDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@end
