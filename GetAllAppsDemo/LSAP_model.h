//
//  LSAP_model.h
//  BeePlayTestDemo
//
//  Created by luck on 2018/7/15.
//  Copyright © 2018年 luck. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^loadIconResource)(UIImage *icon);
@interface LSAP_model : NSObject<NSCoding>

@property(nonatomic,strong) NSObject *LSAP_model_instance;
@property(nonatomic,strong) NSDictionary *dictionary;



- (void)getIconWithBlock:(loadIconResource)block;

- (BOOL)isAppStoreInstalled;
- (NSString *)description;
- (BOOL)isHasInstalled;
- (BOOL)isNotFirstInstalled;
- (BOOL)isNowInstalling;
- (BOOL)isNowInstalled;
- (NSString *)identifier;
- (NSString *)localizedName;
- (NSString *)resourcesDirectoryURL;
- (instancetype)initWithInstance:(id)arg1;
- (instancetype)initWithId:(id)arg1;
@end
