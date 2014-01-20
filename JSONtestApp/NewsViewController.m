//
//  NewsViewController.m
//  JSONtestApp
//
//  Created by Lasse Wingreen on 02/01/14.
//  Copyright (c) 2014 Agro52 Aps. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsDetailedViewController.h"
#import "NSString+StripHTMLwithRegEX.h"

@interface NewsViewController ()


@end

@implementation NewsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"News";

    
  //  [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    
    {
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL * url = [NSURL URLWithString:@"http://playnation.eu/beta/hacks/getItem.php"];
        NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
        NSString * params =@"tableName=news";
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        
        NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                                           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                               
                                                               
                                                               NSLog(@"Response:%@ %@\n", response, error);
                                                               
                                                               
                                                               if(error == nil)
                                                               {
                                                                   NSString * text = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
                                                                   //NSLog(@"Data = %@",text);
                                                               
                                                                   
                                                                   NSString* mystring = text;
                                                                   NSString* stripped = [mystring stripHTMLwithRegEX];
                                                                   
//                                                                   NSLog(@"Stripped Data = %@",stripped);
                                                                   
                                                                   NSData* strippedJsonData = [stripped dataUsingEncoding:NSUTF8StringEncoding];
                                                                   
                                                                   
                                                                   NSError *jsonNewsError = nil;
                                                                   
                                                                   newsJsonWrapper = [NSJSONSerialization
                                                                                         JSONObjectWithData:strippedJsonData
                                                                                         options:NSJSONReadingAllowFragments
                                                                                         error:&jsonNewsError];
                                                                   
                                                                   if (!newsJsonWrapper) {
                                                                            NSLog(@"Error parsing JSON: %@", jsonNewsError);
                                                                   }
                                                                   
                                                                   else {
                                                                       NSLog(@"NewsJsonList: %@", newsJsonWrapper);
                                                                
                                                                       [NewsTableView reloadData];
                                                                       
                                                                   newsTableArray = newsJsonWrapper;
                                                                       
                                                                   }
                                                                }
                                                              
                                                           }];
        [dataTask resume];
    
            
        
        
    }
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [newsJsonWrapper count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsCell"];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"newsCell"];
    }
    
    cell.textLabel.text = [[newsTableArray objectAtIndex:indexPath.row] objectForKey:@"Headline"];
    cell.detailTextLabel.text = [[newsTableArray objectAtIndex:indexPath.row] objectForKey:@"DisplayName"];
    
    return cell;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showNewsDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NewsViewController *newsDestViewController = segue.destinationViewController;
        newsDestViewController.headline = [[newsTableArray objectAtIndex:indexPath.row] objectForKey:@"Headline"];
        newsDestViewController.newsText = [[newsTableArray objectAtIndex:indexPath.row] objectForKey:@"NewsText"];
        
    }
}


@end
