//
//  DetailsViewController.m
//  GetAllAppsDemo
//
//  Created by  on 2018/8/1.
//  Copyright © 2018年 luck. All rights reserved.
//

#import "DetailsViewController.h"

#import "AppsCell.h"

@interface DetailsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView  *tableView;
@property(nonatomic,strong) NSArray  *dataArray;

@end

@implementation DetailsViewController
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[AppsCell class] forCellReuseIdentifier:@"AppsCell"];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"沙盒文件";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.dataArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self.lsap_model resourcesDirectoryURL] error:nil];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppsCell"];
    NSString  *content = self.dataArray[indexPath.row];
    cell.appIcon.image = nil;
    if ([content hasSuffix:@".png"]) {
        cell.appIcon.image = [UIImage imageWithContentsOfFile:[self.lsap_model.resourcesDirectoryURL stringByAppendingPathComponent:content]];
    }
    cell.appName.text = content;
    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
