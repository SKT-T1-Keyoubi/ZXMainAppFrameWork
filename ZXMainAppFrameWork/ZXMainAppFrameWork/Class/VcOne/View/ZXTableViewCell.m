//
//  ZXTableViewCell.m
//  ZXMainAppFrameWork
//
//  Created by LoveQiuYi on 16/1/24.
//  Copyright © 2016年 LoveQiuYi. All rights reserved.
//

#import "ZXTableViewCell.h"

@implementation ZXTableViewCell
/**
 *  通过nib创建View对象的时候执行
 */
- (void)awakeFromNib {
    
    //设置xib中自定义的imageView1的圆角属性
    self.imageView1.layer.cornerRadius = 5;
    self.imageView1.layer.masksToBounds = YES;
    //设置detailLabel额外的属性
    self.detailLabel.editable = NO;
    self.detailLabel.showsVerticalScrollIndicator = NO;
    self.detailLabel.userInteractionEnabled = NO;
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
