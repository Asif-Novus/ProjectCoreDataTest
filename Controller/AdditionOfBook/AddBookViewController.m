//
//  AddBookViewController.m
//  ProjectVaia
//
//  Created by UsFromMini on 2/18/16.
//  Copyright © 2016 Jamil. All rights reserved.
//

#import "AddBookViewController.h"

@interface AddBookViewController ()

@end

@implementation AddBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Add Books";
    categoryData = @[@"Adventure", @"Journey", @"Novel", @"Poetry", @"Detective", @"Thriller"];
        //pickerCategory.hidden = YES;
    
    txtAuthor.delegate=self;
    
    categoryTableView = [self makeTableView];
    [self.view addSubview:categoryTableView];
    categoryTableView.hidden=YES;
    
    
}

- (IBAction)submitButtonPressed:(id)sender {
    NSLog(@"submit pressed");
    AppDelegate* appDelegate = (AppDelegate*)[ [UIApplication sharedApplication] delegate];
    

    Books* books = [NSEntityDescription insertNewObjectForEntityForName:@"Books" inManagedObjectContext:appDelegate.managedObjectContext];
    
    books.name = txtName. text;
    books.title = txtTitle.text;
    books.author = txtAuthor.text;
    books.category = txtCategory.text;
    
    
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![appDelegate.managedObjectContext save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    ListOfBooksViewController*  listOfBooksViewController = [[ListOfBooksViewController alloc]initWithNibName:@"ListOfBooksViewController" bundle:nil];
    [self.navigationController pushViewController:listOfBooksViewController animated:YES];
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if ([textField isEqual:txtCategory]) {
       
        NSLog(@"here category pressed");
        categoryTableView.hidden = NO;
        
    }
    
    
    return  YES;
    
}


-(UITableView *)makeTableView
{
    CGFloat x = 228;
    CGFloat y = 520;
    CGFloat width = 290;
    CGFloat height = 200;
    CGRect tableFrame = CGRectMake(x, y, width, height);
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
    
    tableView.rowHeight = 40;
    tableView.userInteractionEnabled = YES;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    return tableView;
}

#pragma Category TableView Delegate

-(NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  [categoryData count];
}

-(UITableViewCell*)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"newCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = categoryData [indexPath.row];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //selectedCategory = cell.textLabel.text;
    txtCategory.text = cell.textLabel.text;
    categoryTableView.hidden = YES;
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //string the literal we add each timwe
    
    if([txtCategory isEqual:textField]){
        
        NSString* tempString = textField.text;
        
        if(string.length==0)
            tempString = [tempString substringToIndex:tempString.length-1];
        else
            tempString = [tempString stringByAppendingString:string];

        if( [tempString length]== 0)
            categoryTableView.hidden = NO;
    }
   
    
    return YES;
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
