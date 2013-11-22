//
//  ViewController.m
//  xhTableOfMap
//
//  Created by Xiaohe Hu on 11/22/13.
//  Copyright (c) 2013 Xiaohe Hu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) hotspotTableViewController *fitnessTableView;
@property (nonatomic, strong) hotelTableViewController *hotelTableView;
@property (nonatomic, strong) diningTableViewController *diningTableView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    theCollapseClick.CollapseClickDelegate = self;
    [theCollapseClick reloadCollapseClick];

//    _tableView = [[hotspotTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
//    _hotelTableView = [[hotelTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
//    _diningTableView = [[diningTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
//    [self.view addSubview: _uiv_tableContainer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Collapse Click Delegate

// Required Methods
-(int)numberOfCellsForCollapseClick {
    return 3;
}

-(NSString *)titleForCollapseClickAtIndex:(int)index {
    switch (index) {
        case 0:
            return @"HOTELS";
            break;
        case 1:
            return @"DINING";
            break;
        case 2:
            return @"FITNESS";
            break;
            
        default:
            return @"";
            break;
    }
}

-(UIView *)viewForCollapseClickContentViewAtIndex:(int)index {
    _fitnessTableView = [[hotspotTableViewController alloc] init];
    _hotelTableView = [[hotelTableViewController alloc] init];
    _diningTableView = [[diningTableViewController alloc] init];
    switch (index) {
        case 0:
           [uiv_tableDining addSubview:_diningTableView.view];
            [uiv_tableDining setBackgroundColor:[UIColor redColor]];
            [_diningTableView.tableView setDelegate:self];
            return uiv_tableDining;
            break;
        case 1:
           [uiv_tableHotels addSubview:_hotelTableView.view];
            [uiv_tableHotels setBackgroundColor:[UIColor blueColor]];
            [_hotelTableView.tableView setDelegate:self];
            return uiv_tableHotels;
            break;
        case 2:
            [uiv_tableFitness addSubview:_fitnessTableView.view];
            [uiv_tableFitness setBackgroundColor:[UIColor greenColor]];
            [_fitnessTableView.tableView setDelegate:self];
            return uiv_tableFitness;
            break;
        default:
            return nil;
            break;
    }
}
@end
