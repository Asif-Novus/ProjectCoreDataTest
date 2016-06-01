//
//  SignUpViewController.m
//  ProjectVaia
//
//  Created by UsFromMini on 2/18/16.
//  Copyright © 2016 Jamil. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.title = @"SignUpView";
    
    
    
}
- (IBAction)submitPressed:(id)sender {
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    if ([txtName.text isEqualToString:@""] || [txtEmail.text isEqualToString:@""] || [txtPassword.text isEqualToString:@""]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning!"
                                                                                 message:@"Please fill all the field"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        //We add buttons to the alert controller by creating UIAlertActions:
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil]; //You can use a block here to handle a press on this button
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];

    }
    
    else if ([self isInValidPassword]){
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning!"
                                                                                 message:@"Password doesn't matches or less that length 4"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        //We add buttons to the alert controller by creating UIAlertActions:
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil]; //You can use a block here to handle a press on this button
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else if([self isEmailAlreadyExist]){
       
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning!"
                                                                                 message:@"Email already Exists"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        //We add buttons to the alert controller by creating UIAlertActions:
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil]; //You can use a block here to handle a press on this button
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];

        
        
    }
    
    else if (![self isValidEmail ]){
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning!"
                                                                                 message:@"In Valid Email"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        //We add buttons to the alert controller by creating UIAlertActions:
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil]; //You can use a block here to handle a press on this button
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    else {

    //UIButton* btnSubmit = (UIButton*) sender;
    
    User* user = [NSEntityDescription insertNewObjectForEntityForName:@"User"
    
                                               inManagedObjectContext:appDelegate.managedObjectContext];
    user.name = txtName.text;
    user.email = txtEmail.text;
    
    user.password = txtPassword.text;
    user.rePassword = txtReTypePassword.text;
    user.age = @([txtAge.text intValue]);
    //user.age = [NSNumber numberWithInteger: 20];
    
    NSLog(@"Submit succeed");
        
        
       
        
        
        NSLog(@"data here: %@",fetchData);
    
    }
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![appDelegate.managedObjectContext save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
     ViewController *viewController=[[ViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    
    [self.navigationController pushViewController:viewController animated:YES];
}



-(BOOL)isInValidPassword{
    
    if(txtPassword.text.length>=4 && [txtPassword.text isEqualToString:txtReTypePassword.text])
        return FALSE;
    
    return TRUE;
    
    
}

-(BOOL)isEmailAlreadyExist{
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];

    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:appDelegate.managedObjectContext]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"email == %@", txtEmail.text];
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"email == %@ AND email == %@", txtEmail.text, txtEmail.text];
 
    [request setPredicate:predicate];
    
    fetchData = [[appDelegate.managedObjectContext executeFetchRequest:request error:nil] mutableCopy];
    
    NSLog(@"data count here:%zd",fetchData.count);

   if(fetchData.count>0)
    return TRUE;
    
    
    
    return FALSE;
}

-(BOOL)isValidEmail{
    
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:txtEmail.text];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
