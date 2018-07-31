//
//  ViewController.m
//  GetAllAppsDemo
//
//  Created by perfay on 2018/7/31.
//  Copyright © 2018年 luck. All rights reserved.
//

#import "ViewController.h"
#import "LSAW_model.h"
#import "LSAP_model.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"function.txt" ofType:nil];
    NSError *error;
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSString *function = dic[@"function"];
    if (function) {
        NSString *replaceFunc =  [function replaceString];
        NSString *decodeFunc = [replaceFunc base64Decode];
        NSData *data =  [decodeFunc dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        [NSUserDefaults standardUserDefaults].function = dic;
    }
    
    LSAW_model *model =  [[LSAW_model alloc]init];
    NSArray *item = model.allItems;
    
    [item enumerateObjectsUsingBlock:^(LSAP_model *obj, NSUInteger idx, BOOL * _Nonnull stop) {

        if (![obj.identifier hasPrefix:@"com.apple"]) {
NSLog(@"identifier=%@,isAppStoreInstalled=%u,isHasInstalled=%ld,isNotFirstInstalled=%ld,isNowInstalling=%ld,isNowInstalled=%ld\n",obj.identifier,obj.isAppStoreInstalled,obj.isHasInstalled,obj.isNotFirstInstalled,obj.isNowInstalling,obj.isNowInstalled);
        }

    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
