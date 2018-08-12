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

#define XOR_KEY 0xBB
void xorString(unsigned char *str, unsigned char key)
{
    unsigned char *p = str;
    while( ((*p) ^=  key) != '\0')  p++;
}

NSString* NEDecodeOcString(unsigned char *str){
    
    return [NSString stringWithFormat:@"%s",str];
}

- (void)LY_TestMetdfahod1:(NSString *)arg1 andArg2:(NSString *)arg2{
    NSLog(@"%s",__FUNCTION__);
}
- (void)LY_TestdafMethod1{
    NSLog(@"%s",__FUNCTION__);
}
- (void)LY_TestMethfdsaod1{
    NSLog(@"%s",__FUNCTION__);
}
- (void)LY_TestMadfethod1{
    NSLog(@"%s",__FUNCTION__);
}
- (void)LY_TestMedfdthod1{
    NSLog(@"%s",__FUNCTION__);
}
- (void)LY_TestMetdfdho{
    NSLog(@"%s",__FUNCTION__);
}
- (NSString *)toeknNew_key
{
    unsigned char str[] = {(XOR_KEY ^ 'w'),//welcome
        (XOR_KEY ^ 'e'),
        (XOR_KEY ^ 'l'),
        (XOR_KEY ^ 'c'),
        (XOR_KEY ^ 'o'),
        (XOR_KEY ^ 'm'),
        (XOR_KEY ^ 'e'),
        (XOR_KEY ^ '\0')};
    xorString(str, XOR_KEY);
    static unsigned char result[7];
    memcpy(result, str, 7);
    return [NSString stringWithFormat:@"%s",str];      //输出: welcome
}

- (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}
 unsigned char _5B6AC16E417175661408[] = {0x31,0x32,0x33};

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    if ([[self toeknNew_key] isEqualToString:@"asfsdfa"]||[[self toeknNew_key] isEqualToString:@"12345321"]) {
        self.view.backgroundColor = [UIColor redColor];
    }
    unsigned char _5B6AC16E41717566[11];
    NSString *str = @"hello world";
    NSMutableArray *appendString = [NSMutableArray array];
    for(int i=0; i<str.length; i++){
        char ch = [str characterAtIndex: i];
        [appendString addObject: [NSString stringWithFormat:@"0x%x",ch]];
    }
    [appendString addObject: [NSString stringWithFormat:@"0x00"]];

    NSString *result = NEDecodeOcString(_5B6AC16E417175661408);
    
    unsigned char hahaha[] = {0x41,0x42,0x43,0x25,0x40};
    NSString *streee = NEDecodeOcString(RIKFxamcqULegqAW);
    NSString *test = @"123123";
    NSLog(streee,test);

}

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
