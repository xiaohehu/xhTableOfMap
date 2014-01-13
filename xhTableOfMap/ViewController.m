//
//  ViewController.m
//  xhTableOfMap
//
//  Created by Xiaohe Hu on 11/22/13.
//  Copyright (c) 2013 Xiaohe Hu. All rights reserved.
//

#import "ViewController.h"

//#import "hotspotTableViewController.h"


static int numOfCells = 4;
static float container_W = 186.0;
static float kClosedMenu_W = 40.0;
@interface ViewController ()
@property (nonatomic, strong) hotspotTableViewController    *fitnessTableView;
@property (nonatomic, strong) hotelTableViewController      *hotelTableView;
@property (nonatomic, strong) hotelTableViewController      *telTableView;
@property (nonatomic, strong) diningTableViewController     *diningTableView;
@property (nonatomic, strong) CollapseClickCell             *theCell;

@property (nonatomic, strong) UIImageView                   *uiiv_bgImg;

@property (nonatomic, strong) UIView                        *uiv_collapseContainer;
@property (nonatomic, strong) UIView                        *uiv_closedMenuContainer;
@property (nonatomic, strong) UIView                        *uiv_nameLabelContainer;

@property (nonatomic, strong) UIButton                      *uib_city;
@property (nonatomic, strong) UIButton                      *uib_neighborhood;
@property (nonatomic, strong) UIButton                      *uib_closeBtn;
@property (nonatomic, strong) UIButton                      *uib_openBtn;

@property (nonatomic, strong) UILabel                       *uil_cellName;

@property (nonatomic, strong) UIView                        *uiv_leftBar;

@property (nonatomic, strong) NSMutableArray                *arr_cellName;
@property (nonatomic, strong) NSMutableArray                *arr_contentView;

@property (nonatomic, strong) UIView                        *uiv_atIndex0;
@property (nonatomic, strong) UIView                        *uiv_atIndex1;
@property (nonatomic, strong) UIView                        *uiv_atIndex2;
@property (nonatomic, strong) UIView                        *uiv_atIndex3;
@end

@implementation ViewController
-(UIColor *) chosenBtnColor{
    return [UIColor colorWithRed:60.0/255.0 green:56.0/255.0 blue:52.0/255.0 alpha:1.0];
}
-(UIColor *) normalCellColor{
    return [UIColor colorWithRed:59.0/255.0 green:55.0/255.0 blue:50.0/255.0 alpha:0.9];
}
-(UIColor *) chosenCellColor{
    return [UIColor colorWithRed:38.0/255.0 green:36.0/255.0 blue:33.0/255.0 alpha:1.0];
}
-(UIColor *) chosenBtnTitleColor{
    return [UIColor colorWithRed:119.0/255.0 green:116.0/255.0 blue:113.0/255.0 alpha:1.0];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _arr_cellName = [[NSMutableArray alloc] initWithObjects:@"DRIVING DIRECTION", @"PARKING", @"PUBLIC TRANSIT", @"HOTELS", @"DINING", @"FITNESS", @"SPAS", nil];
    [self initVC];
    _uiiv_bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"location_bg.jpg"]];
    [self.view addSubview: _uiiv_bgImg];
    [UIView animateWithDuration:0.33 animations:^{
        _uiv_collapseContainer.alpha = 1.0;
    }];
    [self.view addSubview:_uiv_collapseContainer];
    [self.view addSubview:_uiv_closedMenuContainer];
}

-(void)initVC
{
    isCity = NO;
    
    // Set Container's Frame
    _uiv_collapseContainer = [[UIView alloc] init];
    _uiv_collapseContainer.frame = CGRectMake(0.0f, (768-kCCHeaderHeight*(numOfCells+1))/2, container_W, kCCHeaderHeight*(numOfCells+1));
    [_uiv_collapseContainer setBackgroundColor:[UIColor clearColor]];
//    [_uiv_collapseContainer setBackgroundColor:[UIColor colorWithRed:59.0/255.0 green:55.0/255.0 blue:50.0/255.0 alpha:0.9]];
    _uiv_collapseContainer.clipsToBounds = YES;
    
    //Set Collapse View's Frame
    theCollapseClick = [[CollapseClick alloc] initWithFrame:CGRectMake(0.0f, kCCHeaderHeight, container_W, kCCHeaderHeight*numOfCells)];
//    [theCollapseClick setBackgroundColor:[UIColor blackColor]];
    [theCollapseClick setBackgroundColor:[UIColor clearColor]];
    
    //Set Top Section Buttons
    _uib_city = [UIButton buttonWithType:UIButtonTypeCustom];
    [_uib_city setBackgroundColor:[self chosenBtnColor]];
    [_uib_city setTitle:@"CITY" forState:UIControlStateNormal];
//    _uib_city.titleLabel.font = [UIFont fontWithName:@"DINPro-CondBlack" size:12.5];
    [_uib_city .titleLabel setFont:[UIFont fontWithName:@"DINPro-CondBlack" size:16]];
    [_uib_city setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [_uib_city setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];
    CGFloat rightSpace = 12.0;
    CGFloat bottomSpace = 1.0;
    [_uib_city setContentEdgeInsets:UIEdgeInsetsMake(0, 0, bottomSpace, rightSpace)];
    [_uib_city setTitleColor:[self chosenBtnTitleColor] forState:UIControlStateNormal];
    _uib_city.frame = CGRectMake(0.0, 0.0, 55, kCCHeaderHeight);
    [_uib_city addTarget:self action:@selector(cityBtnTapped) forControlEvents:UIControlEventTouchDown];
    _uib_city.userInteractionEnabled = YES;
    
    _uib_neighborhood = [UIButton buttonWithType:UIButtonTypeCustom];
    [_uib_neighborhood setBackgroundColor:[self normalCellColor]];
    [_uib_neighborhood setTitle:@"NEIGHBORHOOD" forState:UIControlStateNormal];
//    _uib_neighborhood.titleLabel.font = [UIFont boldSystemFontOfSize:11.5];
    [_uib_neighborhood .titleLabel setFont:[UIFont fontWithName:@"DINPro-CondBlack" size:16]];
    _uib_neighborhood.titleLabel.textColor = [UIColor whiteColor];
    _uib_neighborhood.frame = CGRectMake(55.0, 0.0, container_W-55, kCCHeaderHeight);
    CGFloat leftSpacing = 8.0;
    [_uib_neighborhood setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_uib_neighborhood setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];
    [_uib_neighborhood setContentEdgeInsets:UIEdgeInsetsMake(0, leftSpacing, bottomSpace, 0)];
//    _uib_neighborhood.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
    [_uib_neighborhood addTarget:self action:@selector(neighborhoodBtnTapped) forControlEvents:UIControlEventTouchDown];
    _uib_neighborhood.userInteractionEnabled = NO;
    
    //Set Close Button
    _uib_closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_uib_closeBtn setBackgroundColor:[UIColor clearColor]];
    [_uib_closeBtn setBackgroundImage:[UIImage imageNamed:@"map_menu_close@2x.png"] forState:UIControlStateNormal];
    _uib_closeBtn.frame = CGRectMake(container_W-29, 0, 30, 30);
    [_uib_closeBtn addTarget:self action:@selector(closeButtonTapped) forControlEvents:UIControlEventTouchDown];
    
    //Set Closed Menu Container
    _uiv_closedMenuContainer = [[UIView alloc] initWithFrame:CGRectMake(-40.0, (768-38)/2, kClosedMenu_W, kClosedMenu_W)];
    _uiv_closedMenuContainer.clipsToBounds = NO;
    [_uiv_closedMenuContainer setBackgroundColor:[self normalCellColor]];
    _uib_openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_uib_openBtn setBackgroundColor:[UIColor clearColor]];
    [_uib_openBtn setBackgroundImage:[UIImage imageNamed:@"open_btn.jpg"] forState:UIControlStateNormal];
    _uib_openBtn.frame = CGRectMake(0, 0, kClosedMenu_W, kClosedMenu_W);
    [_uib_openBtn addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchDown];
    
    
    [_uiv_closedMenuContainer addSubview:_uib_openBtn];
    [self initCellNameLabel:nil];
    
    theCollapseClick.CollapseClickDelegate = self;
    [theCollapseClick reloadCollapseClick];
    
    [_uiv_collapseContainer addSubview: _uib_city];
    [_uiv_collapseContainer addSubview: _uib_neighborhood];
    [_uiv_collapseContainer addSubview:theCollapseClick];
    [_uiv_collapseContainer insertSubview:_uib_closeBtn aboveSubview:_uib_neighborhood];
    
    _uiv_collapseContainer.alpha = 0.0;
    
    _hotelTableView = [[hotelTableViewController alloc] init];

}

-(void)initCellNameLabel:(NSString *)cellName
{
    //Init UILabel
    CGFloat padding = 0.0;
    if (cellName)
        padding = 12.0;

    [_uil_cellName removeFromSuperview];
    _uil_cellName = [[UILabel alloc] initWithFrame:CGRectMake(10, 48.0, 30.0, 20.0)];//_uib_openBtn.frame.size.height = 40, space = 8, 40+8=48
    _uil_cellName.layer.anchorPoint = CGPointMake(0, 1.0);
    [_uil_cellName setBackgroundColor:[UIColor clearColor]];
    _uil_cellName.autoresizesSubviews = YES;
    [_uil_cellName setText:cellName];
    _uil_cellName.font = [UIFont fontWithName:@"DINPro-CondBlack" size:16];
    [_uil_cellName setTextColor:[UIColor whiteColor]];
    [_uiv_closedMenuContainer addSubview:_uil_cellName];
    
    // Adjust the frame of label after changing the anchor point
    CGRect frame = _uil_cellName.frame;
    frame.origin.x = _uil_cellName.frame.origin.x - 15;
    frame.origin.y = _uil_cellName.frame.origin.y - (18-padding);
    
    [_uil_cellName setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
    _uil_cellName.frame = frame;
    
    [_uil_cellName sizeToFit];
    //Adjust the frame of container according to the height of label
    CGRect containerFrame = _uiv_closedMenuContainer.frame;
    containerFrame.size.height = _uib_openBtn.frame.size.height + padding + _uil_cellName.frame.size.height + padding;
    containerFrame.size.width = kClosedMenu_W;
    containerFrame.origin.y = (768 - containerFrame.size.height)/2;
    containerFrame.origin.x = _uiv_closedMenuContainer.frame.origin.x;
    _uiv_closedMenuContainer.frame = containerFrame;
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
    [_uib_neighborhood setBackgroundColor:[self chosenBtnColor]];
    _uib_neighborhood.alpha = 1.0;
    [_uib_city setBackgroundColor:[self normalCellColor]];
    _uib_city.alpha = 1.0;
    [_uib_city setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_uib_neighborhood setTitleColor:[self chosenBtnTitleColor] forState:UIControlStateNormal];
    _uiv_closedMenuContainer.frame = CGRectMake(-41.0, (768-36)/2, 41.0, 36);
}

-(void)neighborhoodBtnTapped
{
    [self neighborhoodSectionData];
    [self initCellNameLabel:nil];
    [_uib_city setBackgroundColor:[self chosenBtnColor]];
    _uib_city.alpha = 1.0;
    [_uib_neighborhood setBackgroundColor:[self normalCellColor]];
    _uib_neighborhood.alpha = 1.0;
    [_uib_neighborhood setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_uib_city setTitleColor:[self chosenBtnTitleColor] forState:UIControlStateNormal];
    _uiv_closedMenuContainer.frame = CGRectMake(-41.0, (768-36)/2, 41.0, 36);
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
    _arr_cellName = [[NSMutableArray alloc] initWithObjects:@"DRIVING DIRECTION", @"PARKING", @"PUBLIC TRANSIT", @"HOTELS",nil];
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
    _arr_cellName = [[NSMutableArray alloc] initWithObjects:@"DRIVING DIRECTION", @"PARKING", @"PUBLIC TRANSIT", @"HOTELS", @"DINING", @"FITNESS", @"SPAS", nil];
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
        [_uiv_collapseContainer setBackgroundColor:[UIColor clearColor]];
        [self resizeCollapseContainer:4];
        return 4;
    }
    else{
//        _uiv_collapseContainer.frame = CGRectMake(0.0f, (768-kCCHeaderHeight*(3+1))/2, container_W, kCCHeaderHeight*(3+1));
        [self resizeCollapseContainer:7];
        [_uiv_collapseContainer setBackgroundColor:[UIColor clearColor]];
        return 7;
    }
    return 4;
}

-(NSString *)titleForCollapseClickAtIndex:(int)index {
    NSString *str_cellName = [[NSString alloc] init];
    str_cellName = [_arr_cellName objectAtIndex:index];
    return str_cellName;
}

//-(UIView *)viewForCollapseClickContentViewAtIndex:(int)index {
//    CGRect tableSize;
//    switch (index) {
//        case 0:{
//            _hotelTableView = [[hotelTableViewController alloc] init];
////            [_hotelTableView setStr_plistName:@"hotspotLis"];
//            NSString *path = [[NSBundle mainBundle] pathForResource:
//                              @"hotspotList" ofType:@"plist"];
//            _hotelTableView.arr_tableData = [[NSMutableArray alloc] initWithContentsOfFile:path];
//            tableSize = _hotelTableView.view.frame;
//            tableSize.size.width = container_W;
//            tableSize.size.height = 120;
//    
//            _hotelTableView.view.frame = tableSize;
//            _hotelTableView.view.backgroundColor = [UIColor clearColor];
//           [uiv_tableHotels addSubview:self.hotelTableView.view];
//
//            return uiv_tableHotels;
//            break;
//        }
//        case 1:{
////            _hotelTableView = nil;
////            _hotelTableView = [[hotelTableViewController alloc] init];
//            _telTableView = [[hotelTableViewController alloc] init];
//            _telTableView.str_plistName = @"hotspotList";
//            
//            NSString *path = [[NSBundle mainBundle] pathForResource:
//                              @"hotspotLis" ofType:@"plist"];
//            _telTableView.arr_tableData = [[NSMutableArray alloc] initWithContentsOfFile:path];
//            [_telTableView.tableView reloadData];
//
//            tableSize = _telTableView.view.frame;
//            tableSize.size.width = container_W;
//            tableSize.size.height = 120;
//            
//            _telTableView.view.frame = tableSize;
//            [_telTableView reloadInputViews];
//            
//             //[telTableView.view addSubview:self.hotelTableView.view];
//            
//            return _telTableView.view;
//            break;
//        }
//        case 2:
//            if (isCity) {
//                for (UIView *tmp in [uiv_tableFitness subviews]) {
//                    [tmp removeFromSuperview];
//                }
//                UIImageView *uiiv_parking = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"publicT.png"]];
//                uiiv_parking.frame = CGRectMake(0.0, 0.0, 174, 47);
//                uiv_tableFitness.frame = uiiv_parking.frame;
//                [uiv_tableFitness addSubview:uiiv_parking];
//            }
//            else
//            {
//                for (UIView *tmp in [uiv_tableFitness subviews]) {
//                    [tmp removeFromSuperview];
//                }
//                _fitnessTableView = [[hotspotTableViewController alloc] init];
//                [uiv_tableFitness addSubview:self.fitnessTableView.view];
//                uiv_tableFitness.frame = CGRectMake(0.0, 0.0, 160, 150);
////                [uiv_tableFitness setBackgroundColor:[UIColor greenColor]];
//            }
//            return uiv_tableFitness;
//            break;
//        default:
//            return nil;
//            break;
//    }
//}
-(UIView *)viewForCollapseClickContentViewAtIndex:(int)index {
    switch (index) {
        case 0:{
            _uiv_atIndex0 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, container_W, 120.0)];
            _uiv_atIndex0.backgroundColor = [UIColor redColor];
            _uiv_atIndex0.tag = 3000;
            return nil;
            break;
        }
        case 1:{
            _uiv_atIndex1 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, container_W, 60.0)];
            _uiv_atIndex1.backgroundColor = [UIColor greenColor];
            _uiv_atIndex1.tag = 3001;
            return nil;
            break;
        }
        case 2:{
                for (UIView *tmp in [uiv_tableFitness subviews]) {
                    [tmp removeFromSuperview];
                }
                UIImageView *uiiv_parking = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"public_transit.jpg"]];
                uiiv_parking.frame = CGRectMake(0.0, 0.0, container_W, 50);
                uiv_tableFitness.frame = uiiv_parking.frame;
                [uiv_tableFitness addSubview:uiiv_parking];

            return uiv_tableFitness;
            break;
        }
        case 3:{
            _uiv_atIndex0 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, container_W, 120.0)];
            _uiv_atIndex0.backgroundColor = [UIColor redColor];
            _uiv_atIndex0.tag = 3000;
            _uiv_atIndex0.clipsToBounds = NO;
            return _uiv_atIndex0;
            break;
        }
        case 4:{
            _uiv_atIndex1 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, container_W, 78.0)];
            _uiv_atIndex1.backgroundColor = [UIColor redColor];
            _uiv_atIndex1.tag = 3001;
            _uiv_atIndex1.clipsToBounds = NO;
            return _uiv_atIndex1;
            break;
        }
        case 5:{
            _uiv_atIndex2 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, container_W, 78.0)];
            _uiv_atIndex2.backgroundColor = [UIColor redColor];
            _uiv_atIndex2.tag = 3002;
            _uiv_atIndex2.clipsToBounds = NO;
            return _uiv_atIndex2;
            break;
        }
        case 6:{
            _uiv_atIndex3 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, container_W, 120.0)];
            _uiv_atIndex3.backgroundColor = [UIColor redColor];
            _uiv_atIndex3.tag = 3003;
            _uiv_atIndex3.clipsToBounds = NO;
            return _uiv_atIndex3;
            break;
        }
        default:
            return nil;
            break;
    }
}
-(UIColor *)colorForTitleSideBarAtIndex:(int)index
{
    switch (index) {
        case 0:
            return [UIColor redColor];
            break;
        case 1:
            return [UIColor greenColor];
        case 2:
            return [UIColor yellowColor];
        default:
            return [UIColor redColor];
            break;
    }
}
-(void)didClickCollapseClickCellAtIndex:(int)index isNowOpen:(BOOL)open;
{

    [self reloadTableViewAtIndex:index];
    NSString *test = [[NSString alloc] initWithString:[_arr_cellName objectAtIndex:index]];
    if (open == NO) {
        _uiv_closedMenuContainer.frame = CGRectMake(-41.0, (768-36)/2, 41.0, 38);
        [_uil_cellName removeFromSuperview]; 
    }
    else
    {
        _uiv_closedMenuContainer.frame = CGRectMake(-41.0, _uiv_collapseContainer.frame.origin.y, 41.0, _uiv_collapseContainer.frame.size.height);
        [self initCellNameLabel:test];
    }
}

#pragma mark - Reload Tableview According to the index
-(void)reloadTableViewAtIndex:(int)index
{
    
    NSString *path;
    UIView *tmp;
    
    if (index == 3) {
        path = @"hotspotList";
        tmp = _uiv_atIndex0;
    }
    else if (index == 4) {
        path = @"hotspotLis";
        tmp = _uiv_atIndex1;
    }
    else if (index == 5) {
        path = @"hotspotLis";
        tmp = _uiv_atIndex2;
    }
    else if (index == 6) {
        path = @"hotspotList";
        tmp = _uiv_atIndex3;
    }
    
    NSString *tmpp = [[NSBundle mainBundle] pathForResource:path ofType:@"plist"];
    _hotelTableView.arr_tableData = [[NSMutableArray alloc] initWithContentsOfFile:tmpp];
    
    [self performSelector:@selector(changeview:) withObject:tmp afterDelay:0.25];

    

}

-(void)changeview: (UIView *)tmpView
{
    [_hotelTableView.tableView reloadData];
    _hotelTableView.tableView.frame = tmpView.frame;
    [tmpView addSubview:_hotelTableView.tableView];

}
@end
