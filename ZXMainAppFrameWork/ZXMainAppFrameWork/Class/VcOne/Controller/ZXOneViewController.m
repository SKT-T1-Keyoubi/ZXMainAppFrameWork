//
//  ZXOneViewController.m
//  ZXMainAppFrameWork
//
//  Created by LoveQiuYi on 16/1/23.
//  Copyright © 2016年 LoveQiuYi. All rights reserved.
//

#import "ZXOneViewController.h"
#import "ZXTableViewCell.h"
#import "ZX3DTouchViewController.h"
#define tabBarHeight self.tabBarController.tabBar.frame.size.height

@interface ZXOneViewController()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UIViewControllerPreviewingDelegate>
{
    UILongPressGestureRecognizer * _longPress;
}
@property (weak, nonatomic) UITableViewCell * cellTwo;
@property (weak, nonatomic) UITableView * tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@end
@implementation ZXOneViewController
ZXTableViewCell *  cellOne;
NSTimer * timer;
-(void)viewWillAppear:(BOOL)animated{
    //[super viewWillAppear:animated];
//    _cellOne = cellOne;
    [self check3DTouch];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    //创建长按手势识别器
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:nil];
    _longPress = longPressGr;
    //首页图片循环播放
    NSLog(@"%f",tabBarHeight);
    [self addScrollViewImage];
    [self addTableView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Love" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor]}];

    
}
- (void)check3DTouch{
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self registerForPreviewingWithDelegate:self sourceView:self.scrollView];
        _longPress.enabled = NO;
        NSLog(@"3D touch 开启");
    }else{
        _longPress.enabled = YES;
    }
}
- (void)addTableView{
    CGRect frame = CGRectMake(0, 156, self.view.frame.size.width, self.view.frame.size.height - 263);
    //创建一个tableView
    UITableView * tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    //设置数据源方法和代理
    tableView.dataSource = self;
    tableView.delegate = self;
    //垂直滚动的条设置为隐藏
    tableView.showsVerticalScrollIndicator = NO;
    _tableView = tableView;
    [self.view addSubview:tableView];
}
#pragma mark - 3D touch代理方法
//轻按进入浮动预览页面
-(UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    ZX3DTouchViewController * vc = [[ZX3DTouchViewController alloc]init];
    return vc;
}

#pragma mark - tableView的数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"cell";
   cellOne = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cellOne == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cellOne = [[[NSBundle mainBundle] loadNibNamed:@"ZXTableViewCell" owner:self options:nil]lastObject];
    }
    cellOne.imageView1.image = [UIImage imageNamed:@"girl2"];
    //cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    //cell.titleLabel.text = @"今日新闻";
   // cell.detailLabel.text = @"今天天气非常不错";
    self.cellTwo = cellOne;
    return cellOne;
    
}
#pragma mark - tableView的代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
    NSString * msg = [NSString stringWithFormat:@"这是第%ld行",(long)indexPath.row];
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction * submit = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:cancle];
    [alert addAction:submit];
    [self presentViewController:alert animated:YES completion:nil];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
#pragma mark - 实现图片轮播的效果
- (void)addScrollViewImage{
    int count = 5;
    //scrollView框的大小
    CGSize size = self.scrollView.frame.size;
    NSLog(@"%f",size.height);
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
