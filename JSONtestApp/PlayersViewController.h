//
//  PlayerViewController.h
//  JSONtestApp
//
//  Created by Remus Cicu on 17/01/14.
//  Copyright (c) 2014 Agro52 Aps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayersViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *PlayersTableView;

@property (strong,nonatomic) NSArray *playerJsonWrapper;
@property (strong,nonatomic) NSArray *playerTableArray;



@end
