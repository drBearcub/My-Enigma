//
//  SendMessageTableViewController.m
//  My Enigma
//
//  Created by David Chen on 9/20/15.
//  Copyright (c) 2015 DrBearcub Software. All rights reserved.
//

#import "SendMessageTableViewController.h"
#import <Parse/Parse.h>
@interface SendMessageTableViewController ()

@end

@implementation SendMessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.friendsRelation = [[PFUser currentUser] objectForKey:@"friendsRelation"];
    
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    PFQuery *query = [self.friendsRelation query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock: ^(NSArray *objects, NSError *error) {
        if(error) {
            NSLog(@"Error %@ %@", error, [error userInfo]);
        }
        else {
            self.friends = objects;
            [self.tableView reloadData];
        }
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.friends count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath:indexPath];
    
    PFUser *user = [self.friends objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath: indexPath animated:NO];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    PFUser *curUser = [self.friends objectAtIndex:indexPath.row];
    
    //PFRelation * friendsRelation = [self.currentUser relationForKey:@"friendsRelation"];
    
    PFObject *message = [PFObject objectWithClassName:@"Message"];
    message[@"MessageContent"] = self.EncryptedMessage;
    message[@"recipientObjectID"] = [curUser objectId];
    message[@"senderID"] = [[PFUser currentUser] objectId];
    message[@"senderName"] = [[PFUser currentUser] username];

    [message saveInBackgroundWithBlock: ^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
        } else {
            // There was a problem, check error.description
        }
    }];
}

@end
