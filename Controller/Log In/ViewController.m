//
//  ViewController.m
//  ProjectVaia
//
//  Created by UsFromMini on 2/18/16.
//  Copyright © 2016 Jamil. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Welcome";
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    NSLog(@"Width: %f",size.width);
    NSLog(@"Height: %f",size.height);
    
    NSLog(@"View Loaded");
    
    /*
    CGRect backButtonRect = CGRectMake(320, 450, 100, 40);
    UIButton* myBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [myBackButton setTitle:@"Back" forState:UIControlStateNormal];
    myBackButton.frame = backButtonRect;
    myBackButton.backgroundColor = [UIColor blackColor];
    [myBackButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myBackButton];
    */
    
}


- (IBAction)signUpPressed:(id)sender {
    
    NSLog(@"Sign up pressed");
    
   SignUpViewController *signUpViewController =  [[SignUpViewController alloc]initWithNibName:@"SignUpViewController" bundle:nil];
    [self.navigationController pushViewController:signUpViewController animated:NO];
    
    
}
- (IBAction)signInPressed:(id)sender {
    
    NSLog(@"Sign in pressed");
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];

    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:appDelegate.managedObjectContext]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"email == %@ AND password == %@", txtEmail.text, txtPass.text];
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"email == %@ AND email == %@", txtEmail.text, txtEmail.text];
    
    [request setPredicate:predicate];
    
   NSArray* fetchData = [[appDelegate.managedObjectContext executeFetchRequest:request error:nil] mutableCopy];
    
    if(fetchData.count>0){
      /*  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning!"
                                                                                 message:@"Logged In Successfully"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        //We add buttons to the alert controller by creating UIAlertActions:
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil]; //You can use a block here to handle a press on this button
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        */
        
        ListOfBooksViewController *listOfBooksViewController = [[ListOfBooksViewController alloc]initWithNibName:@"ListOfBooksViewController" bundle:nil];
        [self.navigationController pushViewController:listOfBooksViewController animated:YES];

    }
    else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning!"
                                                                                 message:@"Invalid Email or Password"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        //We add buttons to the alert controller by creating UIAlertActions:
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil]; //You can use a block here to handle a press on this button
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];

    }
    
    

    
}

- (IBAction)tableButtonPressed:(id)sender {
   
    UserListViewController *userListViewController = [[UserListViewController alloc]initWithNibName:@"UserListViewController" bundle:nil];
    [self.navigationController pushViewController:userListViewController animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
