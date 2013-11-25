//
//  ViewController.m
//  xhTableOfMap
//
//  Created by Xiaohe Hu on 11/22/13.
//  Copyright (c) 2013 Xiaohe Hu. All rights reserved.
//

#import "ViewController.h"

static int numOfCells = 3;

@interface ViewController ()
@property (nonatomic, strong) hotspotTableViewController    *fitnessTableView;
@property (nonatomic, strong) hotelTableViewController      *hotelTableView;
@property (nonatomic, strong) diningTableViewController     *diningTableView;
@property (nonatomic, strong) CollapseClickCell             *theCell;
@property (nonatomic, strong) UIView                        *uiv_collapseContainer;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    _theCell = [[CollapseClickCell alloc] initWithFrame:CGRectMake(0.0, 0.0, 200.0, 200.0)];
//    theCollapseClick = [[CollapseClick alloc] initWithFrame:CGRectMake(0.0f, (768-kCCHeaderHeight*numOfCells)/2, 200, kCCHeaderHeight*3)];
//    [theCollapseClick setBackgroundColor:[UIColor blackColor]];
////    theCollapseClick.frame = CGRectMake(0.0f, 1.5*_theCell.frame.size.height, 200, 10);
//    theCollapseClick.CollapseClickDelegate = self;
//    [theCollapseClick reloadCollapseClick];
//    [self.view addSubview:theCollapseClick];
    [self initVC];
    
}

-(void)initVC
{
    // Set Container's Frame
    _uiv_collapseContainer = [[UIView alloc] init];
    _uiv_collapseContainer.frame = CGRectMake(0.0f, (768-kCCHeaderHeight*(numOfCells+1))/2, 200, kCCHeaderHeight*(numOfCells+1));
    [_uiv_collapseContainer setBackgroundColor:[UIColor redColor]];
    
    // Set Each Cell's Frame
    _theCell = [[CollapseClickCell alloc] initWithFrame:CGRectMake(0.0, 0.0, 200.0, 200.0)];
    
    //Set Collapse View's Frame
    theCollapseClick = [[CollapseClick alloc] initWithFrame:CGRectMake(0.0f, kCCHeaderHeight, 200, kCCHeaderHeight*numOfCells)];
    [theCollapseClick setBackgroundColor:[UIColor blackColor]];
    
    theCollapseClick.CollapseClickDelegate = self;
    [theCollapseClick reloadCollapseClick];
    
    [_uiv_collapseContainer addSubview:theCollapseClick];
    [self.view addSubview:_uiv_collapseContainer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Collapse Click Delegate

// Required Methods
-(int)numberOfCellsForCollapseClick {
    return numOfCells;
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
//    _fitnessTableView = [[hotspotTableViewController alloc] init];
//    _hotelTableView = [[hotelTableViewController alloc] init];
//    _diningTableView = [[diningTableViewController alloc] init];
    switch (index) {
        case 0:
            _hotelTableView = [[hotelTableViewController alloc] init];
           [uiv_tableHotels addSubview:self.hotelTableView.view];
//            uitable_hotel = _hotelTableView.tableView;
            [uiv_tableHotels setBackgroundColor:[UIColor redColor]];
//            [_hotelTableView.tableView setDelegate:self];
            return uiv_tableHotels;
            break;
        case 1:
            _diningTableView = [[diningTableViewController alloc] init];
           [uiv_tableDining addSubview:self.diningTableView.view];
//            uitable_dining = _diningTableView.tableView;
            [uiv_tableDining setBackgroundColor:[UIColor blueColor]];
//            [_diningTableView.tableView setDelegate:self];
            return uiv_tableDining;
            break;
        case 2:
            _fitnessTableView = [[hotspotTableViewController alloc] init];
            [uiv_tableFitness addSubview:self.fitnessTableView.view];
//            uitable_fitness = _fitnessTableView.tableView;
            [uiv_tableFitness setBackgroundColor:[UIColor greenColor]];
//            [_fitnessTableView.tableView setDelegate:self];
            return uiv_tableFitness;
            break;
        default:
            return nil;
            break;
    }
}
@end
