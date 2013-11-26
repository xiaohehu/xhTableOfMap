//
//  ViewController.m
//  xhTableOfMap
//
//  Created by Xiaohe Hu on 11/22/13.
//  Copyright (c) 2013 Xiaohe Hu. All rights reserved.
//

#import "ViewController.h"

static int numOfCells = 3;
static float container_W = 160.0;

@interface ViewController ()
@property (nonatomic, strong) hotspotTableViewController    *fitnessTableView;
@property (nonatomic, strong) hotelTableViewController      *hotelTableView;
@property (nonatomic, strong) diningTableViewController     *diningTableView;
@property (nonatomic, strong) CollapseClickCell             *theCell;
@property (nonatomic, strong) UIView                        *uiv_collapseContainer;
@property (nonatomic, strong) UIButton                      *uib_city;
@property (nonatomic, strong) UIButton                      *uib_neighborhood;
@property (nonatomic, strong) UIButton                      *uib_closeBtn;

@property (nonatomic, strong) UIView                        *uiv_leftBar;

@property (nonatomic, strong) NSMutableArray                *arr_cellName;
@property (nonatomic, strong) NSMutableArray                *arr_contentView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _arr_cellName = [[NSMutableArray alloc] initWithObjects:@"DRIVING DIRECTION", @"PARKING", @"PUBLIC TRANSIT", nil];
    [self initVC];
    [self.view addSubview:_uiv_collapseContainer];
    
    [UIView animateWithDuration:0.33 animations:^{
        _uiv_collapseContainer.alpha = 1.0;
    }];
}

-(void)initVC
{
    isCity = YES;
    
    // Set Container's Frame
    _uiv_collapseContainer = [[UIView alloc] init];
    _uiv_collapseContainer.frame = CGRectMake(0.0f, (768-kCCHeaderHeight*(numOfCells+1))/2, container_W, kCCHeaderHeight*(numOfCells+1));
    [_uiv_collapseContainer setBackgroundColor:[UIColor blackColor]];
    
//    // Set Each Cell's Frame
//    _theCell = [[CollapseClickCell alloc] initWithFrame:CGRectMake(5.0, 0.0, container_W-10, 200.0)];
    
    //Set Collapse View's Frame
    theCollapseClick = [[CollapseClick alloc] initWithFrame:CGRectMake(0.0f, kCCHeaderHeight, container_W, kCCHeaderHeight*numOfCells)];
    [theCollapseClick setBackgroundColor:[UIColor blackColor]];
    
    //Set Top Section Buttons
    _uib_city = [UIButton buttonWithType:UIButtonTypeCustom];
    [_uib_city setBackgroundColor:[UIColor blackColor]];
    _uib_city.alpha = 0.35;
    [_uib_city setTitle:@"CITY" forState:UIControlStateNormal];
    _uib_city.titleLabel.font = [UIFont boldSystemFontOfSize:12.5];
    _uib_city.titleLabel.textColor = [UIColor whiteColor];
    _uib_city.frame = CGRectMake(0.0, 0.0, 60, kCCHeaderHeight);
    [_uib_city addTarget:self action:@selector(cityBtnTapped) forControlEvents:UIControlEventTouchDown];
    _uib_city.userInteractionEnabled = NO;
    
    _uib_neighborhood = [UIButton buttonWithType:UIButtonTypeCustom];
    [_uib_neighborhood setBackgroundColor:[UIColor colorWithWhite:0.4 alpha:1.0]];
    [_uib_neighborhood setTitle:@"NEIGHBORHOOD" forState:UIControlStateNormal];
    _uib_neighborhood.titleLabel.font = [UIFont boldSystemFontOfSize:11.5];
    _uib_neighborhood.titleLabel.textColor = [UIColor whiteColor];
    _uib_neighborhood.frame = CGRectMake(60.0, 0.0, 100, kCCHeaderHeight);
    [_uib_neighborhood addTarget:self action:@selector(neighborhoodBtnTapped) forControlEvents:UIControlEventTouchDown];
    _uib_neighborhood.userInteractionEnabled = YES;
    
    //Set Close Button
    _uib_closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_uib_closeBtn setBackgroundColor:[UIColor clearColor]];
    [_uib_closeBtn setBackgroundImage:[UIImage imageNamed:@"map_menu_close.png"] forState:UIControlStateNormal];
    _uib_closeBtn.frame = CGRectMake(container_W-25, 0, 26, 26);
    [_uib_closeBtn addTarget:self action:@selector(closeButtonTapped) forControlEvents:UIControlEventTouchDown];
    
    //Set Dark & Light Border of Buttons
    UIView *uiv_darkBar = [[UIView alloc] initWithFrame:CGRectMake(0.0, kCCHeaderHeight-1, container_W, 1)];
    [uiv_darkBar setBackgroundColor:[UIColor blackColor]];
    uiv_darkBar.alpha = 0.35;
    
    UIView *uiv_lightBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, container_W, 1)];
    [uiv_lightBar setBackgroundColor: [UIColor whiteColor]];
    uiv_lightBar.alpha = 0.25;
    
    //Set Left Bar Of Table
    _uiv_leftBar = [[UIView alloc] init];
    [_uiv_leftBar setBackgroundColor:[UIColor clearColor]];
    _uiv_leftBar.alpha = 0.0;
    
    theCollapseClick.CollapseClickDelegate = self;
    [theCollapseClick reloadCollapseClick];
    
    [_uiv_collapseContainer addSubview: _uib_city];
    [_uiv_collapseContainer addSubview: _uib_neighborhood];
    [_uiv_collapseContainer addSubview:theCollapseClick];
    [_uiv_collapseContainer addSubview:uiv_darkBar];
    [_uiv_collapseContainer addSubview:uiv_lightBar];
    [_uiv_collapseContainer insertSubview:_uib_closeBtn aboveSubview:_uib_neighborhood];
    
    _uiv_collapseContainer.alpha = 0.0;
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
    
    [UIView animateWithDuration:0.33 animations:^{
        _uiv_leftBar.alpha = 0.0;
    }];
    [_uiv_leftBar removeFromSuperview];
    
    [_uib_neighborhood setBackgroundColor:[UIColor colorWithWhite:0.4 alpha:1.0]];
    _uib_neighborhood.alpha = 1.0;
    [_uib_city setBackgroundColor:[UIColor blackColor]];
    _uib_city.alpha = 0.35;
    

}

-(void)neighborhoodBtnTapped
{
    NSLog(@"Neighborhood button tapped");
    
    [self neighborhoodSectionData];
    
    [UIView animateWithDuration:0.33 animations:^{
        _uiv_leftBar.alpha = 0.0;
    }];
    [_uiv_leftBar removeFromSuperview];
    
    [_uib_city setBackgroundColor:[UIColor colorWithWhite:0.4 alpha:1.0]];
    _uib_city.alpha = 1.0;
    [_uib_neighborhood setBackgroundColor:[UIColor blackColor]];
    _uib_neighborhood.alpha = 0.35;
}
-(void)closeButtonTapped
{
    NSLog(@"!!! Then Menu Should Be Closed !!!");
}

#pragma mark - Init Data For 2 Sections
-(void)citySectionData
{
    isCity = YES;
    
    [theCollapseClick closeCollapseClickCellsWithIndexes:_arr_cellName animated:NO];
    [theCollapseClick closeCellResize];
    [UIView animateWithDuration:0.33 animations:^{
        _uiv_collapseContainer.alpha = 0.0;
    }];
    [_arr_cellName removeAllObjects];
    _arr_cellName = [[NSMutableArray alloc] initWithObjects:@"DRIVING DIRECTION", @"PARKING", @"PUBLIC TRANSIT", nil];
    theCollapseClick.CollapseClickDelegate = self;
    [theCollapseClick reloadCollapseClick];
    [UIView animateWithDuration:0.33 animations:^{
         _uiv_collapseContainer.alpha = 1.0;
     }];
    _uib_city.userInteractionEnabled = NO;
    _uib_neighborhood.userInteractionEnabled = YES;
}

-(void)neighborhoodSectionData
{
    isCity = NO;
    
    [theCollapseClick closeCollapseClickCellsWithIndexes:_arr_cellName animated:NO];
    [theCollapseClick closeCellResize];
    [UIView animateWithDuration:0.33 animations:^{
        _uiv_collapseContainer.alpha = 0.0;
    }];
    [_arr_cellName removeAllObjects];
    _arr_cellName = [[NSMutableArray alloc] initWithObjects:@"HOTEL",@"DINING",@"FITNESS", nil];
    theCollapseClick.CollapseClickDelegate = self;
    [theCollapseClick reloadCollapseClick];
    [UIView animateWithDuration:0.33 animations:^{
        _uiv_collapseContainer.alpha = 1.0;
    }];
    _uib_city.userInteractionEnabled = YES;
    _uib_neighborhood.userInteractionEnabled = NO;
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
}

-(UIView *)viewForCollapseClickContentViewAtIndex:(int)index {

    switch (index) {
        case 0:
            _hotelTableView = [[hotelTableViewController alloc] init];
           [uiv_tableHotels addSubview:self.hotelTableView.view];
            [uiv_tableHotels setBackgroundColor:[UIColor brownColor]];
            return uiv_tableHotels;
            break;
        case 1:
            _diningTableView = [[diningTableViewController alloc] init];
           [uiv_tableDining addSubview:self.diningTableView.view];
            [uiv_tableDining setBackgroundColor:[UIColor blueColor]];
            return uiv_tableDining;
            break;
        case 2:
            if (isCity) {
                for (UIView *tmp in [uiv_tableFitness subviews]) {
                    [tmp removeFromSuperview];
                }
                UIImageView *uiiv_parking = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"publicT.png"]];
                uiiv_parking.frame = CGRectMake(0.0, 0.0, 174, 47);
                uiv_tableFitness.frame = uiiv_parking.frame;
                [uiv_tableFitness addSubview:uiiv_parking];
            }
            else
            {
                for (UIView *tmp in [uiv_tableFitness subviews]) {
                    [tmp removeFromSuperview];
                }
                _fitnessTableView = [[hotspotTableViewController alloc] init];
                [uiv_tableFitness addSubview:self.fitnessTableView.view];
                uiv_tableFitness.frame = CGRectMake(0.0, 0.0, 160, 150);
                [uiv_tableFitness setBackgroundColor:[UIColor greenColor]];
            }
            return uiv_tableFitness;
            break;
        default:
            return nil;
            break;
    }
}

-(void)didClickCollapseClickCellAtIndex:(int)index isNowOpen:(BOOL)open;
{
    [UIView animateWithDuration:0.33 animations:^{
        _uiv_leftBar.alpha = 0.0;
    }];
    [_uiv_leftBar removeFromSuperview];
    if (open == NO) {
        [_uiv_leftBar removeFromSuperview];
    }
    else
    {
        switch (index) {
            case 0:
                [_uiv_leftBar setBackgroundColor:[UIColor redColor]];
                break;
            case 1:
                [_uiv_leftBar setBackgroundColor:[UIColor greenColor]];
                break;
            case 2:
                [_uiv_leftBar setBackgroundColor:[UIColor yellowColor]];
                break;
                
            default:
                break;
        }
        
        
        _uiv_leftBar.frame = CGRectMake(0.0, kCCHeaderHeight+index*kCCHeaderHeight, 5.0, 0);
        [_uiv_collapseContainer insertSubview:_uiv_leftBar aboveSubview:theCollapseClick];
        _uiv_leftBar.alpha = 0.0;
        [UIView animateWithDuration:0.68 animations:^{
            _uiv_leftBar.alpha = 1.0;
            
            if (isCity && (index != 2)) {
                _uiv_leftBar.frame = CGRectMake(0.0, kCCHeaderHeight+index*kCCHeaderHeight, 5.0, kCCHeaderHeight+150);
            }
           else if (isCity == NO)
            {
                _uiv_leftBar.frame = CGRectMake(0.0, kCCHeaderHeight+index*kCCHeaderHeight, 5.0, kCCHeaderHeight+150);
            }
            else
            {
                _uiv_leftBar.frame = CGRectMake(0.0, kCCHeaderHeight+index*kCCHeaderHeight, 5.0, kCCHeaderHeight+47);
            }
        }];
    }
    NSLog(@"the index is %i",index);
    NSLog(@"the Bool Value is %i", open);
}
@end
