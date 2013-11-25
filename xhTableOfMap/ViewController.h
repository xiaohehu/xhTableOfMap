//
//  ViewController.h
//  xhTableOfMap
//
//  Created by Xiaohe Hu on 11/22/13.
//  Copyright (c) 2013 Xiaohe Hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollapseClick.h"
#import "hotspotTableViewController.h"
#import "hotelTableViewController.h"
#import "diningTableViewController.h"

@interface ViewController : UIViewController <CollapseClickDelegate, UITextFieldDelegate>//, UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UIView *uiv_tableHotels;
    
    IBOutlet UIView *uiv_tableDining;
    
    IBOutlet UIView *uiv_tableFitness;
    
//    __weak IBOutlet CollapseClick * theCollapseClick;
    
    CollapseClick *theCollapseClick;
}

@end
