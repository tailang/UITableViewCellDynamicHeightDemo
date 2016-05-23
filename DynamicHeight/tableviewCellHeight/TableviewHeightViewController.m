//
//  TableviewHeightViewController.m
//  DynamicHeight
//
//  Created by tailang on 3/11/16.
//  Copyright © 2016 com.ecoolhud.DynamicHeight. All rights reserved.
//

#import "TableviewHeightViewController.h"
#import "HeightTableViewCell.h"

@interface TableviewHeightViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation TableviewHeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = @[@"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试", @"短文案短文案短文案短文案"];
    [self.view addSubview:self.tableView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HeightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HeightTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0 || indexPath.row == 10) {
        [cell setTexts:[self.dataArray objectAtIndex:0]];
    }else{
        [cell setTexts:[self.dataArray objectAtIndex:1]];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        return UITableViewAutomaticDimension;
    }else{
        //在这可以做一下缓存，本例子没做缓存
        HeightTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HeightTableViewCell class])];
        
        CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 0.5f; //0.5是一个像素的contentview下的横线
        return height;
    }
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
 
        
        //设置一个高度估值，减少初始化时大量计算
        _tableView.estimatedRowHeight = 44;
        
        //iOS8以上指定该属性值，可以更容易计算高度
        if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
            _tableView.rowHeight = UITableViewAutomaticDimension;
        }
        
               [_tableView registerClass:[HeightTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HeightTableViewCell class])];
    }
    
    return _tableView;
}

@end
