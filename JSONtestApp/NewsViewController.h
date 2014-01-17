//
//  NewsViewController.h
//  JSONtestApp
//
//  Created by Lasse Wingreen on 02/01/14.
//  Copyright (c) 2014 Agro52 Aps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UITableViewController <UITableViewDataSource> {
    
    
    

    IBOutlet UITableView *NewsTableView;


    NSArray *newsJsonWrapper;
    NSArray *newsTableArray;
    NSArray *playerIdArray;
    NSDictionary *newsJsonDictionary;
    NSMutableData *newsData;
    

}
@end


