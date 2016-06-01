//
//  UserListViewController.m
//  ProjectVaia
//
//  Created by UsFromMini on 2/22/16.
//  Copyright © 2016 Jamil. All rights reserved.
//

#import "UserListViewController.h"

@interface UserListViewController ()
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *myArray;

@end

@implementation UserListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"List Of Books";
    //self.myArray  = @[ @"First",@"Second"];
    
    UIBarButtonItem* barButtonEmail = [[UIBarButtonItem alloc] initWithTitle:@"Email" style:UIBarButtonItemStylePlain target:self
                                                                      action:@selector(doEmail:)];
    self.navigationItem.rightBarButtonItem = barButtonEmail;
    
    
    self.tableView = [self makeTableView];
    [self.view addSubview:self.tableView];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self get];
}

- (void)get
{
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    NSArray *fetchData = [[appdelegate.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    NSLog(@" array here: %@",fetchData);
    
    if (fetchData.count) {
        self.myArray=[NSArray arrayWithArray:fetchData];
        //[self.tableView reloadData];
        
    }
    
}

-(UITableView *)makeTableView
{
    CGFloat x = 0;
    CGFloat y = 120;
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - 50;
    CGRect tableFrame = CGRectMake(x, y, width, height);
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
    
    tableView.rowHeight = 45;
    tableView.userInteractionEnabled = YES;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    return tableView;
}


- (IBAction)addBookSPressed:(id)sender {
    
    AddBookViewController* addBookViewController = [[AddBookViewController alloc]initWithNibName:@"AddBookViewController" bundle:nil];
    [self.navigationController pushViewController:addBookViewController animated:YES];
    
}


-(void) doEmail:(id) sender{
    NSLog(@"Email Pressed");
    
    EmailViewController* emailViewController = [[EmailViewController alloc] initWithNibName:@"EmailViewController" bundle:nil];
    [self.navigationController pushViewController:emailViewController animated:YES];
    
}

-(NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  [self.myArray count];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"newCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    User *usr=[self.myArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [ NSString stringWithFormat:@"Name: %@ Email:%@ Age:%@ Password:%@",usr.name,usr.email,usr.age,usr.password ];
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
