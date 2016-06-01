//
//  AddBookViewController.h
//  ProjectVaia
//
//  Created by UsFromMini on 2/18/16.
//  Copyright © 2016 Jamil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Books.h"
#import "AppDelegate.h"
@interface AddBookViewController : UIViewController<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource >{
    
    IBOutlet UITextField *txtName;
    IBOutlet UITextField *txtTitle;
    IBOutlet UITextField *txtAuthor;
    IBOutlet UITextField *txtCategory;
    
    NSArray* categoryData;
    NSString* selectedCategory;
    UITableView* categoryTableView;

}

@end
