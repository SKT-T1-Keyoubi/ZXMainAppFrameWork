//
//  ZXTabBarController.m
//  ZXMainAppFrameWork
//
//  Created by LoveQiuYi on 16/1/23.
//  Copyright © 2016年 LoveQiuYi. All rights reserved.
//

#import "ZXTabBarController.h"

@implementation ZXTabBarController
- (void)viewDidLoad{
    [super viewDidLoad];
    //添加子控制器
    [self setUpChildController];
}

#pragma mark - 添加四个子控制器
- (void)setUpChildController{
    //采用sb的模式设计界面
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"ZXOneViewController" bundle:nil];
    ZXOneViewController * oneVc = [storyBoard instantiateInitialViewController];
    [self setUpNavigationController:oneVc title:@"首页" image:@"Circle_MyCircleHeader" tabBarItemImage:@"tabbar_home"];
    ZXTwoViewController * twoVc = [[ZXTwoViewController alloc]init];
    [self setUpNavigationController:twoVc title:@"消息" image:@"Circle_MyCircleHeader" tabBarItemImage:@"tabbar_message_center"];
    ZXThreeViewController * threeVc = [[ZXThreeViewController alloc]init];
    [self setUpNavigationController:threeVc title:@"发现" image:@"Circle_MyCircleHeader" tabBarItemImage:@"tabbar_discover"];
    ZXFourViewController * fourVc = [[ZXFourViewController alloc]init];
    [self setUpNavigationController:fourVc title:@"我的" image:@"Circle_MyCircleHeader" tabBarItemImage:@"tabbar_profile"];

}
#pragma mark - 添加导航控制器
-(void)setUpNavigationController:(UITableViewController *)vc title:(NSString *)title image:(NSString *)image tabBarItemImage:(NSString *)tabBarItemImage{
    //为每个tableViewController设置导航控制器
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
    //设置导航栏标题
    vc.navigationItem.title = title;
    //设置tabBarItem的image
    nav.tabBarItem.image = [UIImage imageNamed:tabBarItemImage];
    nav.title = @"标题";
    //设置导航栏的背景图片
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:image] forBarMetrics:UIBarMetricsDefault];
    //添加导航栏
    [self addChildViewController:nav];
}


@end
