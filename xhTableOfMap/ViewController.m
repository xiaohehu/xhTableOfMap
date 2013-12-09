//
//  ViewController.m
//  xhTableOfMap
//
//  Created by Xiaohe Hu on 11/22/13.
//  Copyright (c) 2013 Xiaohe Hu. All rights reserved.
//

#import "ViewController.h"

static int numOfCells = 4;
static float container_W = 200.0;

@interface ViewController ()
@property (nonatomic, strong) hotspotTableViewController    *fitnessTableView;
@property (nonatomic, strong) hotelTableViewController      *hotelTableView;
@property (nonatomic, strong) diningTableViewController     *diningTableView;
@property (nonatomic, strong) CollapseClickCell             *theCell;

@property (nonatomic, strong) UIView                        *uiv_collapseContainer;
@property (nonatomic, strong) UIView                        *uiv_closedMenuContainer;

@property (nonatomic, strong) UIButton                      *uib_city;
@property (nonatomic, strong) UIButton                      *uib_neighborhood;
@property (nonatomic, strong) UIButton                      *uib_closeBtn;
@property (nonatomic, strong) UIButton                      *uib_openBtn;

@property (nonatomic, strong) UILabel                       *uil_cellName;

@property (nonatomic, strong) UIView                        *uiv_leftBar;

@property (nonatomic, strong) NSMutableArray                *arr_cellName;
@property (nonatomic, strong) NSMutableArray                *arr_contentView;
@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _arr_cellName = [[NSMutableArray alloc] initWithObjects:@"DRIVING DIRECTION", @"PARKING", @"PUBLIC TRANSIT", @"444",nil];
    [self initVC];
    [self.view addSubview:_uiv_collapseContainer];
    [self.view addSubview:_uiv_closedMenuContainer];
    
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
    _uiv_collapseContainer.clipsToBounds = YES;
    
    //Set Collapse View's Frame
    theCollapseClick = [[CollapseClick alloc] initWithFrame:CGRectMake(0.0f, kCCHeaderHeight, container_W, kCCHeaderHeight*numOfCells)];
    [theCollapseClick setBackgroundColor:[UIColor greenColor]];
    
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
    _uib_neighborhood.frame = CGRectMake(60.0, 0.0, container_W-60, kCCHeaderHeight);
    [_uib_neighborhood addTarget:self action:@selector(neighborhoodBtnTapped) forControlEvents:UIControlEventTouchDown];
    _uib_neighborhood.userInteractionEnabled = YES;
    
    //Set Close Button
    _uib_closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_uib_closeBtn setBackgroundColor:[UIColor clearColor]];
    [_uib_closeBtn setBackgroundImage:[UIImage imageNamed:@"map_menu_close@2x.png"] forState:UIControlStateNormal];
    _uib_closeBtn.frame = CGRectMake(container_W-35, 0, 36, 36);
    [_uib_closeBtn addTarget:self action:@selector(closeButtonTapped) forControlEvents:UIControlEventTouchDown];
    
    //Set Closed Menu Container
    _uiv_closedMenuContainer = [[UIView alloc] initWithFrame:CGRectMake(-41.0, (768-36)/2, 41.0, 36)];
    [_uiv_closedMenuContainer setBackgroundColor:[UIColor colorWithWhite:0.4 alpha:1.0]];
    _uib_openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_uib_openBtn setBackgroundColor:[UIColor clearColor]];
    [_uib_openBtn setBackgroundImage:[UIImage imageNamed:@"map_menu_opne@2x.png"] forState:UIControlStateNormal];
    _uib_openBtn.frame = CGRectMake(5, 0, 36, 36);
    [_uib_openBtn addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchDown];
    
    
    [_uiv_closedMenuContainer addSubview:_uib_openBtn];
    [self initCellNameLabel:nil];
    
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

-(void)initCellNameLabel:(NSString *)cellName
{
    [_uil_cellName removeFromSuperview];
    _uil_cellName = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 36.0, 30.0, 20.0)];
    _uil_cellName.layer.anchorPoint = CGPointMake(0, 1.0);
    [_uil_cellName setBackgroundColor:[UIColor clearColor]];
    _uil_cellName.autoresizesSubviews = YES;
    [_uil_cellName setText:cellName];
    _uil_cellName.font = [UIFont boldSystemFontOfSize:16];
    [_uil_cellName setTextColor:[UIColor whiteColor]];

    [_uiv_closedMenuContainer addSubview:_uil_cellName];
    [_uil_cellName sizeToFit];
    [_uil_cellName setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
    CGRect frame = _uil_cellName.frame;
    frame.origin.x = _uil_cellName.frame.origin.x - 15;
    frame.origin.y = (_uiv_closedMenuContainer.frame.size.height - _uil_cellName.frame.size.height)/2 - _uil_cellName.frame.size.height;
    _uil_cellName.frame = frame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Handle Button Actions
-(void)cityBtnTapped
{
    [self citySectionData];
    [self initCellNameLabel:nil];
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
    [self neighborhoodSectionData];
    [self initCellNameLabel:nil];
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
    [UIView animateWithDuration:0.33 animations:^{
        _uiv_collapseContainer.transform = CGAffineTransformMakeTranslation(-(1+container_W), 0);
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.33 animations:^{
            _uiv_closedMenuContainer.transform = CGAffineTransformMakeTranslation(41, 0);
        }];
    }];
}

-(void)openMenu
{
    [UIView animateWithDuration:0.33 animations:^{
        _uiv_closedMenuContainer.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.33 animations:^{
            _uiv_collapseContainer.transform = CGAffineTransformMakeTranslation(0, 0);
        }];
    }];
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
    _arr_cellName = [[NSMutableArray alloc] initWithObjects:@"DRIVING DIRECTION", @"PARKING", @"PUBLIC TRANSIT", @"444",nil];
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
    _arr_cellName = [[NSMutableArray alloc] initWithObjects:@"SPAS",@"DINING",@"FITNESS", nil];
    theCollapseClick.CollapseClickDelegate = self;
    [theCollapseClick reloadCollapseClick];
    [UIView animateWithDuration:0.33 animations:^{
        _uiv_collapseContainer.alpha = 1.0;
    }];
    _uib_city.userInteractionEnabled = YES;
    _uib_neighborhood.userInteractionEnabled = NO;
//    [theCollapseClick closeCollapseClickCellAtIndex:_arr_cellName animated:YES];
}

-(void)resizeCollapseContainer:(int)numOfCell
{
    _uiv_collapseContainer.frame = CGRectMake(0.0f, (768-kCCHeaderHeight*(numOfCell+1))/2, container_W, kCCHeaderHeight*(numOfCell+1));
    theCollapseClick.frame = CGRectMake(0.0f, kCCHeaderHeight, container_W, kCCHeaderHeight*numOfCell);
    theCollapseClick.originalFrameSize = theCollapseClick.frame.size;
}
#pragma mark - Collapse Click Delegate

// Required Methods
-(int)numberOfCellsForCollapseClick {
    if (isCity == YES) {
//        _uiv_collapseContainer.frame = CGRectMake(0.0f, (768-kCCHeaderHeight*(numOfCells+1))/2, container_W, kCCHeaderHeight*(numOfCells+1));
        [self resizeCollapseContainer:4];
        return 4;
    }
//    if (isCity == NO) {
    else{
//        _uiv_collapseContainer.frame = CGRectMake(0.0f, (768-kCCHeaderHeight*(3+1))/2, container_W, kCCHeaderHeight*(3+1));
        [self resizeCollapseContainer:3];
        [_uiv_collapseContainer setBackgroundColor:[UIColor redColor]];
        return 3;
    }
    return 4;
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
    NSString *test = [[NSString alloc] initWithString:[_arr_cellName objectAtIndex:index]];
    
    [UIView animateWithDuration:0.33 animations:^{
        _uiv_leftBar.alpha = 0.0;
    }];
    [_uiv_leftBar removeFromSuperview];
    if (open == NO) {
        [_uiv_leftBar removeFromSuperview];
        _uiv_closedMenuContainer.frame = CGRectMake(-41.0, (768-36)/2, 41.0, 36);
        [_uil_cellName removeFromSuperview]; 
    }
    else
    {
        _uiv_closedMenuContainer.frame = CGRectMake(-41.0, _uiv_collapseContainer.frame.origin.y, 41.0, _uiv_collapseContainer.frame.size.height);
        switch (index) {
            case 0:
                [_uiv_leftBar setBackgroundColor:[UIColor redColor]];
                [self initCellNameLabel:test];
                break;
            case 1:
                [_uiv_leftBar setBackgroundColor:[UIColor greenColor]];
                [self initCellNameLabel:test];
                break;
            case 2:
                [_uiv_leftBar setBackgroundColor:[UIColor yellowColor]];
                [self initCellNameLabel:test];
                break;
                
            default:
                [self initCellNameLabel:nil];
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
}
@end
