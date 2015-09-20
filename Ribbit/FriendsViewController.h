//
//  FriendsViewController.h
//  Ribbit
//
//  Created by David Chen on 8/18/15.
//  Copyright (c) 2015 DrBearcub Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface FriendsViewController : UITableViewController

@property (nonatomic, strong) PFRelation *friendsRelation;
@property (nonatomic, strong) NSArray *friends;
@end
