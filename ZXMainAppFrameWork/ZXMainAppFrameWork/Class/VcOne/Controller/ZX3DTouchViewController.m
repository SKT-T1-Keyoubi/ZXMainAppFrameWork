//
//  ZX3DTouchViewController.m
//  ZXMainAppFrameWork
//
//  Created by LoveQiuYi on 16/1/24.
//  Copyright © 2016年 LoveQiuYi. All rights reserved.
//

#import "ZX3DTouchViewController.h"

@interface ZX3DTouchViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) UIWebView * webView;
@end

@implementation ZX3DTouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建一个webView
    self.view.backgroundColor = [UIColor grayColor];
    UIWebView * webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    webView.delegate = self;
    _webView = webView;
    
}
//重写方法，预览页面，底部的Action Items
-(NSArray<id<UIPreviewActionItem>> *)previewActionItems{//-----返回数组类型
    UIPreviewAction * p1 = [UIPreviewAction actionWithTitle:@"share" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"share");
    }];
    UIPreviewAction * p2 = [UIPreviewAction actionWithTitle:@"close" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"close");
    }];
    NSArray * actions = @[p1,p2];
    return actions;
}

-(void)dealloc{
    NSLog(@"%s",__func__);
}
@end
