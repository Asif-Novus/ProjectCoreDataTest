//
//  SignUpViewController.h
//  ProjectVaia
//
//  Created by UsFromMini on 2/18/16.
//  Copyright © 2016 Jamil. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "User.h"

@interface SignUpViewController : UIViewController{
    
    IBOutlet UITextField *txtName;
    IBOutlet UITextField *txtEmail;
    IBOutlet UITextField *txtAge;
    IBOutlet UITextField *txtPassword;
    IBOutlet UITextField *txtReTypePassword;
    
    NSArray *fetchData;
    
  
}


@end
