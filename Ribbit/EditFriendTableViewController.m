//
//  EditFriendsController.m
//  Ribbit
//
//  Created by David Chen on 8/17/15.
//  Copyright (c) 2015 DrBearcub Software. All rights reserved.
//

#import "EditFriendTableViewController.h"
#import <Parse/Parse.h>

@implementation EditFriendTableViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    PFQuery *query = [PFUser query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        else {
            self.allUsers = objects;
            [self.tableView reloadData];
        }
    }];
    
    self.currentUser = [PFUser currentUser];
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allUsers count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    PFUser *user = [self.allUsers objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;

    if([self isFriend: user]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath: indexPath animated:NO];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    PFUser *user = [self.allUsers objectAtIndex:indexPath.row];
    PFRelation * friendsRelation = [self.currentUser relationForKey:@"friendsRelation"];

    
    if([self isFriend: user]) {
        cell.accessoryType = UITableViewCellAccessoryNone; //remove checkmark
        
        for(PFUser *friend in self.friends) {
            if([friend.objectId isEqualToString:user.objectId]) {
                [self.friends removeObject: friend];
                break;
            }
        }
        [friendsRelation removeObject:user];
        [self.currentUser saveInBackgroundWithBlock: ^(BOOL succeeded, NSError *error) {
            if(error) {
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            } //should we keep the friend inside the array if there is an error occured?
        }];
        
    } else {
        
        [self.friends addObject: user];
        [friendsRelation addObject:user];
        
        [self.currentUser saveInBackgroundWithBlock: ^(BOOL succeeded, NSError *error) {
            if(error) {
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }
    
}

#pragma mark - Helper methods

- (BOOL) isFriend: (PFUser *) user {
    for(PFUser *friend in self.friends) {
        if([friend.objectId isEqualToString:user.objectId]) {
            return YES;
        }
    }
    return NO;
}


@end
