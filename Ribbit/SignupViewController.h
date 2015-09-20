//
//  SignupViewController.h
//  Ribbit
//
//  Created by David Chen on 7/18/15.
//  Copyright (c) 2015 DrBearcub Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameField;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UITextField *emailField;


- (IBAction)createAccount:(UIButton *)sender;


@end
