//
//  ViewController.m
//  GetAllAppsDemo
//
//  Created by  on 2018/7/31.
//  Copyright © 2018年 luck. All rights reserved.
//

#import "ViewController.h"
#import "LSAW_model.h"
#import "LSAP_model.h"
#import <objc/runtime.h>
#import "AppsCell.h"
#import "DetailsViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView  *tableView;
@property(nonatomic,strong) NSMutableArray  *dataArray;

@end

@implementation ViewController

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[AppsCell class] forCellReuseIdentifier:@"AppsCell"];
    }
    return _tableView;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    LSAW_model *model =  [[LSAW_model alloc]init];
    NSArray *item = model.allItems;
    _dataArray = [NSMutableArray array];
    [item enumerateObjectsUsingBlock:^(LSAP_model *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([self.tabBarItem.title isEqualToString:@"我的"]) {
            if (![obj.identifier hasPrefix:@"com.apple"]) {
                [self.dataArray addObject:obj];
            }
        }
        else if ([self.tabBarItem.title isEqualToString:@"系统"]){
            if ([obj.identifier hasPrefix:@"com.apple"]) {
                [self.dataArray addObject:obj];
            }
        }
    }];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppsCell"];
    LSAP_model *model = self.dataArray[indexPath.row];
    cell.appIcon.image = nil;
    [model getIconWithBlock:^(UIImage *icon) {
    cell.appIcon.image = icon;
    }];
    cell.appName.text = [model localizedName];
    cell.appBD.text = [model identifier];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LSAW_model *awModel = [[LSAW_model alloc]init];
    LSAP_model *model = self.dataArray[indexPath.row];

    [awModel openAppWithIdentifier:model.identifier];
    /*
    DetailsViewController *details = [[DetailsViewController alloc]init];
    details.lsap_model = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:details animated:YES];
     */
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
