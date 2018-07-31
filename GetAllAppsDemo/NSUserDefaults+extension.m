//
//  NSUserDefaults+extension.m
//  BeePlayTestDemo
//
//  Created by luck on 2018/7/14.
//  Copyright © 2018年 luck. All rights reserved.
//

#import "NSUserDefaults+extension.h"

@implementation NSUserDefaults (extension)
@dynamic  function;
- (NSDictionary *)function{
    id obj = [self objectForKey:@"function"];
    if (obj) {
        NSDictionary *value =  [NSKeyedUnarchiver unarchiveObjectWithData:obj];
        return value;
    }
    return nil;
}
- (void)setFunction:(NSDictionary *)function{
    if (function) {
        [self setValue:[NSKeyedArchiver  archivedDataWithRootObject:function] forKey:@"function"];
    }
    else{
        [self removeObjectForKey:@"function"];
    }
    [self synchronize];
}
@end
