//
//  hotelTableViewController.h
//  xhTableOfMap
//
//  Created by Xiaohe Hu on 11/22/13.
//  Copyright (c) 2013 Xiaohe Hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol hotelViewControllerDelegate

-(NSString *)getPlistName;
@end

@interface hotelTableViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate, hotelViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *arr_tableData;
@property (nonatomic, strong) NSString *str_plistName;
@end
