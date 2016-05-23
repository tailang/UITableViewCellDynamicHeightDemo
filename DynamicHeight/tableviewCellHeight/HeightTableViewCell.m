//
//  HeightTableViewCell.m
//  DynamicHeight
//
//  Created by tailang on 3/11/16.
//  Copyright © 2016 com.ecoolhud.DynamicHeight. All rights reserved.
//

#import "HeightTableViewCell.h"
#import <Masonry.h>

@interface HeightTableViewCell()

@property (nonatomic, strong) UILabel *label;

@end

@implementation HeightTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        [self setLayout];
    }
    
    return self;
}

- (void)initView
{
    [self.contentView addSubview:self.label];
}

- (void)setLayout
{
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.contentView).offset(10);
        //因为cell的高度是根据子view确定的 所以这里要指定bottom
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
}

//更新cell的数据 不要写在layoutSubviews中了，要像下面一样自己写一个方法，然后在外部调用更新数据，使用layoutSubviews将不能正常计算高度
//- (void)layoutSubviews
//{
//
//}

- (void)setTexts:(NSString *)text
{
    self.label.text = text;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:14];
        _label.numberOfLines = 0;
        
        //label多行时一定要指定该值,iOS < 8.0
        if ([UIDevice currentDevice].systemVersion.floatValue < 8.0) {
            CGFloat preferredMaxWidth = [UIScreen mainScreen].bounds.size.width - 20; //20 是左右的padding
            _label.preferredMaxLayoutWidth = preferredMaxWidth;
        }

    }
    
    return _label;
}

@end
