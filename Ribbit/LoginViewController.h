//
//  LoginViewController.h
//  Ribbit
//
//  Created by David Chen on 7/18/15.
//  Copyright (c) 2015 DrBearcub Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

- (IBAction)createAccount:(UIButton *)sender;

- (IBAction)signin:(UIButton *)sender;

@end
