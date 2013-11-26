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
@property (nonatomic, strong) UIButton                      *uib_city;
@property (nonatomic, strong) UIButton                      *uib_neighborhood;

@property (nonatomic, strong) NSMutableArray                *arr_cellName;
@property (nonatomic, strong) NSMutableArray                *arr_contentView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self citySectionData];
    [self initVC];
    [self.view addSubview:_uiv_collapseContainer];
}

-(void)initVC
{
    // Set Container's Frame
    _uiv_collapseContainer = [[UIView alloc] init];
    _uiv_collapseContainer.frame = CGRectMake(0.0f, (768-kCCHeaderHeight*(numOfCells+1))/2, 200, kCCHeaderHeight*(numOfCells+1));
    [_uiv_collapseContainer setBackgroundColor:[UIColor blackColor]];
    
    // Set Each Cell's Frame
    _theCell = [[CollapseClickCell alloc] initWithFrame:CGRectMake(0.0, 0.0, 200.0, 200.0)];
    
    //Set Collapse View's Frame
    theCollapseClick = [[CollapseClick alloc] initWithFrame:CGRectMake(0.0f, kCCHeaderHeight, 200, kCCHeaderHeight*numOfCells)];
    [theCollapseClick setBackgroundColor:[UIColor blackColor]];
    
    //Set Top Section Buttons
    _uib_city = [UIButton buttonWithType:UIButtonTypeCustom];
    [_uib_city setBackgroundColor:[UIColor blackColor]];
    _uib_city.alpha = 0.35;
    [_uib_city setTitle:@"CITY" forState:UIControlStateNormal];
    _uib_city.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    _uib_city.titleLabel.textColor = [UIColor whiteColor];
    _uib_city.frame = CGRectMake(0.0, 0.0, 70, kCCHeaderHeight);
    [_uib_city addTarget:self action:@selector(cityBtnTapped) forControlEvents:UIControlEventTouchDown];
    
    _uib_neighborhood = [UIButton buttonWithType:UIButtonTypeCustom];
    [_uib_neighborhood setBackgroundColor:[UIColor colorWithWhite:0.4 alpha:1.0]];
    [_uib_neighborhood setTitle:@"NEIGHBORHOOD" forState:UIControlStateNormal];
    _uib_neighborhood.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    _uib_neighborhood.titleLabel.textColor = [UIColor whiteColor];
    _uib_neighborhood.frame = CGRectMake(70.0, 0.0, 130, kCCHeaderHeight);
    [_uib_neighborhood addTarget:self action:@selector(neighborhoodBtnTapped) forControlEvents:UIControlEventTouchDown];
    
    //Set Dark & Light Border of Buttons
    UIView *uiv_darkBar = [[UIView alloc] initWithFrame:CGRectMake(0.0, kCCHeaderHeight-1, _uiv_collapseContainer.frame.size.width, 1)];
    [uiv_darkBar setBackgroundColor:[UIColor blackColor]];
    uiv_darkBar.alpha = 0.35;
    
    UIView *uiv_lightBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _uiv_collapseContainer.frame.size.width, 1)];
    [uiv_lightBar setBackgroundColor: [UIColor whiteColor]];
    uiv_lightBar.alpha = 0.25;
    
    theCollapseClick.CollapseClickDelegate = self;
    [theCollapseClick reloadCollapseClick];
    
    [_uiv_collapseContainer addSubview: _uib_city];
    [_uiv_collapseContainer addSubview: _uib_neighborhood];
    [_uiv_collapseContainer addSubview:theCollapseClick];
    [_uiv_collapseContainer addSubview:uiv_darkBar];
    [_uiv_collapseContainer addSubview:uiv_lightBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Handle Button Actions
-(void)cityBtnTapped
{
    NSLog(@"City button tapped");
    
    [self citySectionData];

    [_uib_neighborhood setBackgroundColor:[UIColor colorWithWhite:0.4 alpha:1.0]];
    _uib_neighborhood.alpha = 1.0;
    [_uib_city setBackgroundColor:[UIColor blackColor]];
    _uib_city.alpha = 0.35;
    

}

-(void)neighborhoodBtnTapped
{
    NSLog(@"Neighborhood button tapped");
    
    [self neighborhoodSectionData];
    
    [_uib_city setBackgroundColor:[UIColor colorWithWhite:0.4 alpha:1.0]];
    _uib_city.alpha = 1.0;
    [_uib_neighborhood setBackgroundColor:[UIColor blackColor]];
    _uib_neighborhood.alpha = 0.35;
}

#pragma mark - Init Data For 2 Sections
-(void)citySectionData
{
    [_uiv_collapseContainer removeFromSuperview];
    _arr_cellName = [[NSMutableArray alloc] initWithObjects:@"DRIVING DIRECTION", @"PARKING", @"PUBLIC TRANSIT", nil];
    [self initVC];
    [self.view addSubview:_uiv_collapseContainer];
//    [theCollapseClick closeCollapseClickCellAtIndex:_arr_cellName animated:YES];
}

-(void)neighborhoodSectionData
{
    [_uiv_collapseContainer removeFromSuperview];
    _arr_cellName = [[NSMutableArray alloc] initWithObjects:@"HOTEL",@"DINING",@"FITNESS", nil];
    [self initVC];
    [self.view addSubview:_uiv_collapseContainer];
//    [theCollapseClick closeCollapseClickCellAtIndex:_arr_cellName animated:YES];
}
#pragma mark - Collapse Click Delegate

// Required Methods
-(int)numberOfCellsForCollapseClick {
    return numOfCells;
}

-(NSString *)titleForCollapseClickAtIndex:(int)index {
    NSString *str_cellName = [[NSString alloc] init];
    str_cellName = [_arr_cellName objectAtIndex:index];
    return str_cellName;
//    switch (index) {
//        case 0:
//            str_cellName = [_arr_cellName objectAtIndex:index];
//            return str_cellName;
//            break;
//        case 1:
//            str_cellName = [_arr_cellName objectAtIndex:index];
//            return str_cellName;
//            break;
//        case 2:
//            str_cellName = [_arr_cellName objectAtIndex:index];
//            return str_cellName;
//            break;
//            
//        default:
//            return @"";
//            break;
//    }
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
