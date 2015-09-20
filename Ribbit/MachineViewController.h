//
//  MachineViewController.h
//  My Enigma
//
//  Created by David Chen on 9/19/15.
//  Copyright (c) 2015 DrBearcub Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface MachineViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *TestDisplay;

@property (weak, nonatomic) IBOutlet UITextField *TestInput;
@property (strong, nonatomic) NSString *TestInputCache; // this need to be strong for some reason

@property (weak, nonatomic) IBOutlet UILabel *RotorOneDisplay;
@property (weak, nonatomic) IBOutlet UILabel *RotorTwoDisplay;
@property (weak, nonatomic) IBOutlet UILabel *RotorThreeDisplay;

@property (nonatomic, strong) NSArray *RotorOneWiring;
@property (nonatomic, strong) NSArray *RotorTwoWiring;
@property (nonatomic, strong) NSArray *RotorThreeWiring;
@property (nonatomic, strong) NSArray *Reflector;

@property (nonatomic, nonatomic) NSInteger RotorOneIndex;
@property (nonatomic, nonatomic) NSInteger RotorTwoIndex;
@property (nonatomic, nonatomic) NSInteger RotorThreeIndex;

@property (nonatomic, nonatomic) NSInteger RotorOneHook;
@property (nonatomic, nonatomic) NSInteger RotorTwoHook;
@property (nonatomic, nonatomic) NSInteger RotorThreeHook;



- (IBAction)RotorOneRightShift:(id)sender;

- (IBAction)RotorTwoRightShift:(id)sender;

- (IBAction)RotorThreeRightShift:(id)sender;

- (IBAction)RotorOneLeftShift:(id)sender;

- (IBAction)RotorTwoLeftShift:(id)sender;

- (IBAction)RotorThreeLeftShift:(id)sender;

- (IBAction)InputTextFieldChanged:(id)sender;

- (IBAction)Reset:(id)sender;


@end
