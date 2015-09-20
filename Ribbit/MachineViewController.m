//
//  MachineViewController.m
//  My Enigma
//
//  Created by David Chen on 9/19/15.
//  Copyright (c) 2015 DrBearcub Software. All rights reserved.
//

#import "MachineViewController.h"
#import "SendMessageTableViewController.h"

@interface MachineViewController ()

@end

@implementation MachineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.RotorOneWiring = @[@5,@17,@0,@25,@23, @8,@21,@12,@9,@14, @20,@1,@3,@15,@4, @18,@19,@6,@10,@7, @11,@2,@13,@16,@22, @24];
    self.RotorTwoWiring = @[@18,@10,@4,@0,@9, @15,@1,@19,@25,@8, @20,@14,@13,@7,@12, @5,@3,@21,@24,@17, @11,@22,@2,@16,@6, @23];
    self.RotorThreeWiring = @[@13,@6,@20,@24,@10, @16,@23,@9,@7,@5, @19,@12,@0,@22,@3, @18,@11,@4,@17,@21, @15,@1,@2,@8,@25, @14];
    self.Reflector = @[@8,@18,@7,@15,@9, @24,@10,@2,@0,@4, @6,@16,@17,@21,@25, @3,@11,@12,@1,@22, @23,@13,@19,@20,@5,@14];
    
    self.RotorOneIndex = 0;
    self.RotorTwoIndex = 0;
    self.RotorThreeIndex = 0;
    
    self.TestInputCache = @"";
    self.TestInput.text = @"";
    [self UpdateLabels];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)PressKey : (NSString *) key { // upper case only
    int cur = [key characterAtIndex:0];
    cur -= 65;
    NSLog(@"Parsed: %d", cur);
    cur = [self.RotorThreeWiring[(self.RotorThreeIndex + cur) % 26] integerValue];
    NSLog(@"after rotor3: %d", cur);
    cur = [self.RotorTwoWiring[(self.RotorTwoIndex + cur) % 26] integerValue];
    NSLog(@"after rotor2: %d", cur);
    cur = [self.RotorOneWiring[(self.RotorOneIndex + cur) % 26] integerValue];
    NSLog(@"after rotor1: %d", cur);
    cur = [self.Reflector[cur] intValue];
     NSLog(@"after reflector: %d", cur);
    for(int i = 0; i < 26; ++i){
        if(cur == [self.RotorOneWiring[i] intValue]){
            cur = i - (int)(self.RotorOneIndex);
            if(cur < 0){
                cur = 26 + cur;
            }
            break;
        }
    }
    
    for(int i = 0; i < 26; ++i){
        if(cur == [self.RotorTwoWiring[i] intValue]){
            cur = i - (int)(self.RotorTwoIndex);
            if(cur < 0){
                cur = 26 + cur;
            }
            break;
        }
    }
    
    for(int i = 0; i < 26; ++i){
        if(cur == [self.RotorThreeWiring[i] intValue]){
            cur = i - (int)(self.RotorThreeIndex);
            if(cur < 0){
                cur = 26 + cur;
            }
            break;
        }
    }
        NSLog( @"cur %d", cur);
    
    cur += 65;
    

    
    NSString *newChar =  [NSString stringWithFormat:@"%c", cur];
    NSMutableString *temp = [NSMutableString stringWithCapacity:100];
    temp = [self.TestDisplay.text mutableCopy];
    [temp appendString:newChar];
    self.TestDisplay.text = temp;
    
    self.RotorThreeIndex  = (self.RotorThreeIndex + 1) % 26;
    if(self.RotorThreeIndex == 0) {
        self.RotorTwoIndex = (self.RotorTwoIndex + 1) % 26;
        if(self.RotorTwoIndex == 0) {
            self.RotorOneIndex =  (self.RotorOneIndex + 1) % 26;
        }
    }
    
    [self UpdateLabels];
    
   // cur = plugboardMasking[cur];
   // cur =  *(rotorPosition[2] + (rotorConfiguration[2] + cur)% 26);
   // cur =  *(rotorPosition[1] + (rotorConfiguration[1] + cur)% 26);
   // cur =  *(rotorPosition[0] + (rotorConfiguration[0] + cur)% 26);
   // cur = reflector[cur];
}

- (void) UpdateLabels {
    NSMutableString *result = [NSMutableString stringWithCapacity:100];
    NSString *temp;
    {
    int value;
    int realIndex;
    for(int i = (int)(self.RotorOneIndex - 5.0); i <= (int)(self.RotorOneIndex + 6.0); i++) {
        if(i < 0) {
            realIndex = 26 + i;
        } else {
            realIndex = i%26;
        }
        value = [self.RotorOneWiring[realIndex] integerValue];
        value += 65;
        temp = [NSString stringWithFormat:@"%c", value];
        [result appendString:temp];
    }
    self.RotorOneDisplay.text = result;
    }
    
    {
    result = [NSMutableString stringWithCapacity:100];
        int value;
        int realIndex;
        for(int i = (int)(self.RotorTwoIndex - 5.0); i <= (int)(self.RotorTwoIndex + 6.0); i++) {
            if(i < 0) {
                realIndex = 26 + i;
            } else {
                realIndex = i%26;
            }
            value = [self.RotorTwoWiring[realIndex] integerValue];
            value += 65;
            temp = [NSString stringWithFormat:@"%c", value];
            [result appendString:temp];
        }
        self.RotorTwoDisplay.text = result;
    }
    {
        result = [NSMutableString stringWithCapacity:100];
        int value;
        int realIndex;
        for(int i = (int)(self.RotorThreeIndex - 5.0); i <= (int)(self.RotorThreeIndex + 6.0); i++) {
            if(i < 0) {
                realIndex = 26 + i;
            } else {
                realIndex = i%26;
            }
            value = [self.RotorThreeWiring[realIndex] integerValue];
            value += 65;
            temp = [NSString stringWithFormat:@"%c", value];
            [result appendString:temp];
        }
        self.RotorThreeDisplay.text = result;
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)RotorOneRightShift:(id)sender {
    self.RotorOneIndex = self.RotorOneIndex-1;
    if(self.RotorOneIndex == -1) {
        self.RotorOneIndex = 25;
    }
    [self UpdateLabels];
}

- (IBAction)RotorTwoRightShift:(id)sender {
    self.RotorTwoIndex = self.RotorTwoIndex-1;
    if(self.RotorTwoIndex == -1) {
        self.RotorTwoIndex = 25;
    }
    
    [self UpdateLabels];
}

- (IBAction)RotorThreeRightShift:(id)sender {
    self.RotorThreeIndex = self.RotorThreeIndex-1;
    if(self.RotorThreeIndex == -1) {
        self.RotorThreeIndex = 25;
    }
    
    [self UpdateLabels];
}

- (IBAction)RotorOneLeftShift:(id)sender {
    self.RotorOneIndex = (self.RotorOneIndex+1)%26;
    [self UpdateLabels];
}

- (IBAction)RotorTwoLeftShift:(id)sender {
    self.RotorTwoIndex = (self.RotorTwoIndex+1)%26;
    [self UpdateLabels];
}

- (IBAction)RotorThreeLeftShift:(id)sender {
    self.RotorThreeIndex = (self.RotorThreeIndex+1)%26;
    [self UpdateLabels];
}

/*
 
         EditFriendTableViewController *viewController = (EditFriendTableViewController*) segue.destinationViewController;
 
 */
- (IBAction)InputTextFieldChanged:(id)sender {

    if(self.TestInputCache.length == self.TestInput.text.length - 1) { // new char
        NSString * newString = [self.TestInput.text substringWithRange:NSMakeRange(self.TestInput.text.length-1, 1)];
        [self PressKey: newString];
        //self.TestInputCache = self.TestInput.text;
        
        
        
    } else if (self.TestInputCache.length == self.TestInput.text.length + 1) { // deleted char
        
    }
    else {
        //error, do nothing atm
    }
    
    self.TestInputCache = self.TestInput.text;

}

- (IBAction)Reset:(id)sender {
    self.TestInputCache = @"";
    self.TestInput.text = @"";
    self.TestDisplay.text = @"";
    self.RotorOneIndex = 0;
    self.RotorTwoIndex = 0;
    self.RotorThreeIndex = 0;
    [self UpdateLabels];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"SendEncryptedMessage"]) {
        
    SendMessageTableViewController *viewController = (SendMessageTableViewController*) segue.destinationViewController;
        viewController.EncryptedMessage = self.TestDisplay.text;
    }
}

@end
