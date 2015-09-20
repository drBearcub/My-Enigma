//
//  InboxViewController.h
//  Ribbit
//
//  Created by David Chen on 7/18/15.
//  Copyright (c) 2015 DrBearcub Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InboxViewController : UITableViewController
- (IBAction)logout:(id)sender;

@property (nonatomic, strong) NSArray *messages;
@end
