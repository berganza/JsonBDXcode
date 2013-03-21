//
//  AppDelegate.h
//  JsonComoBBDD
//
//  Created by LLBER on 21/03/13.
//  Copyright (c) 2013 LLBER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *listOfItems;
	NSMutableArray *copyListOfItems;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSMutableDictionary *json;

@end
