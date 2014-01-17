//
//  GroupViewController.h
//  JSONtestApp
//
//  Created by Remus Cicu on 17/01/14.
//  Copyright (c) 2014 Agro52 Aps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupsViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *GroupsTableView;
@property (strong,nonatomic) NSArray *groupJsonWrapper;
@property (strong,nonatomic) NSArray *groupTableArray;

@end
