//
//  ListOfBooksViewController.m
//  ProjectVaia
//
//  Created by UsFromMini on 2/18/16.
//  Copyright © 2016 Jamil. All rights reserved.
//

#import "ListOfBooksViewController.h"

@interface ListOfBooksViewController ()
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *myArray;

@end

@implementation ListOfBooksViewController

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
    NSLog(@"in view will appear");
    [self get];
    [self.tableView reloadData];
}

- (void)get
{
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
   /*
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Books"];
    NSArray *fetchData = [[appdelegate.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    NSLog(@" array here: %@",fetchData);
    */
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Books"];
    fetchRequest.resultType = NSDictionaryResultType;
    
    NSArray *results    = [appdelegate.managedObjectContext executeFetchRequest:fetchRequest
                                                                   error:nil];
    NSLog(@"array 1:%@",results);
    
    NSArray* fetchData = [results valueForKey:@"title"];

    NSLog(@"array 2:%@",fetchData);

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
    
   Books *books=[self.myArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [ NSString stringWithFormat:@"%@",books ];
    
    return cell;
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
