//
//  SendMessageTableViewController.h
//  My Enigma
//
//  Created by David Chen on 9/20/15.
//  Copyright (c) 2015 DrBearcub Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SendMessageTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *friends;

@property (nonatomic, strong) PFRelation *friendsRelation;

@property (nonatomic, strong) NSObject *recipientID;

@property (nonatomic, strong) NSString *EncryptedMessage;

@end
