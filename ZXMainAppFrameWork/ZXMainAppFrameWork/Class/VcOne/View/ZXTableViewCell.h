//
//  ZXTableViewCell.h
//  ZXMainAppFrameWork
//
//  Created by LoveQiuYi on 16/1/24.
//  Copyright © 2016年 LoveQiuYi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailLabel;

@end
