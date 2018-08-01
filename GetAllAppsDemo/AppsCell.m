//
//  AppsCell.m
//  GetAllAppsDemo
//
//  Created by  on 2018/8/1.
//  Copyright © 2018年 luck. All rights reserved.
//

#import "AppsCell.h"

@interface AppsCell ()

@end

@implementation AppsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.appIcon];
        [self.contentView addSubview:self.appName];
        [self.contentView addSubview:self.appBD];
        [self.appIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(45);
        }];
        [self.appName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.appIcon.mas_top).offset(5);
            make.left.equalTo(self.appIcon.mas_right).offset(10);
        }];
        [self.appBD mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.appIcon.mas_bottom).offset(-5);
            make.left.equalTo(self.appIcon.mas_right).offset(10);
        }];
    }
    return self;
}
- (UIImageView *)appIcon{
    if(!_appIcon) {
        _appIcon = [UIImageView new];
        _appIcon.contentMode = UIViewContentModeScaleAspectFill;
        _appIcon.backgroundColor = [UIColor whiteColor];
        _appIcon.layer.cornerRadius = 5;
        _appIcon.layer.masksToBounds = YES;
    }
    return _appIcon;
}
- (UILabel *)appName{
    if (!_appName) {
        _appName = [UILabel new];
        _appName.font = [UIFont systemFontOfSize:18];
        _appName.textColor = [UIColor blackColor];
        _appName.textAlignment = NSTextAlignmentLeft;
    }
    return _appName;
}
- (UILabel *)appBD{
    if (!_appBD) {
        _appBD = [UILabel new];
        _appBD.font = [UIFont systemFontOfSize:14];
        _appBD.textColor = [UIColor grayColor];
        _appBD.textAlignment = NSTextAlignmentLeft;
    }
    return _appBD;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
