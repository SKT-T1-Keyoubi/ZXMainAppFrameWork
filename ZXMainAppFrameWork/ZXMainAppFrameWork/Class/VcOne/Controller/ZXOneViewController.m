//
//  ZXOneViewController.m
//  ZXMainAppFrameWork
//
//  Created by LoveQiuYi on 16/1/23.
//  Copyright © 2016年 LoveQiuYi. All rights reserved.
//

#import "ZXOneViewController.h"
@interface ZXOneViewController()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@end
@implementation ZXOneViewController
NSTimer * timer;
-(void)viewDidLoad{
    [super viewDidLoad];
    [self addScrollViewImage];
    
}
#pragma mark - 实现图片轮播的效果
- (void)addScrollViewImage{
    int count = 5;
    //scrollView框的大小
    CGSize size = self.scrollView.frame.size;
    for (int i = 0; i < count; i++) {
        //创建imageView
        UIImageView * imageView = [[UIImageView alloc]init];
        //添加到ScrollView中去
        [self.scrollView addSubview:imageView];
        //取出image
        NSString * imageName = [NSString stringWithFormat:@"img_%02d",i+1];
        //设置imageView的图片
        imageView.image = [UIImage imageNamed:imageName];
        //设置图片的位置
        CGFloat x = i * size.width;
        imageView.frame = CGRectMake(x, 0, size.width, size.height);
    }
    //设置scrollView的大小
    self.scrollView.contentSize = CGSizeMake(count * size.width, 0);
    //水平滚动条不显示
    self.scrollView.showsHorizontalScrollIndicator = NO;
    //设置分页
    self.scrollView.pagingEnabled = YES;
    //设置分页页数
    self.pageControl.numberOfPages = count;
    //设置scrollView的代理
    self.scrollView.delegate = self;
    //调用定时器
    [self addTimer];
}
-(void) addTimer{
    //创建一个定时器
    
    timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}
-(void) nextImage{
    //获取当前的页码
    NSInteger page = self.pageControl.currentPage;
    if (page == self.pageControl.numberOfPages - 1) {
        page = 0;
    }
    else{
        page++;
    }
    //移动图片的原理
    CGFloat offSetX = page * self.scrollView.frame.size.width;
    //执行动画
    [UIView animateWithDuration:3.0 animations:^{
        self.scrollView.contentOffset = CGPointMake(offSetX, 0);
    }];
}
//正在滚动的时候
-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    //滚动超过一半的时候显示下一页
    int page = (scrollView.contentOffset.x + scrollView.frame.size.width/2)/scrollView.frame.size.width;
    self.pageControl.currentPage = page;
}
//拖拽图片暂停定时器
-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [timer setFireDate:[NSDate distantFuture]];
}
//拖拽完毕重新启用定时器
-(void) scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    //为了更好的用户体验，延迟三秒执行
    [self performSelector:@selector(setFire) withObject:nil afterDelay:3];
}
//重新启用定时器
- (void)setFire{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 500), dispatch_get_main_queue(), ^{
        [timer setFireDate:[NSDate date]];
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
