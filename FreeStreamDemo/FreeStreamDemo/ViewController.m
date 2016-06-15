//
//  ViewController.m
//  FreeStreamDemo
//
//  Created by LuzhiChao on 16/6/15.
//  Copyright © 2016年 LuzhiChao. All rights reserved.
//

#import "ViewController.h"
#import <FSAudioStream.h>
#import "DataModel.h"

// 前世情人
#define MUSIC1 @"http://sc1.111ttt.com/2016/1/06/03/199031135258.mp3"
// 千与千寻
#define MUSIC2 @"http://sc1.111ttt.com/2016/5/02/18/195182051017.mp3"
// 半生缘
#define MUSIC3 @"http://sc1.111ttt.com/2016/4/06/13/199132227259.mp3"

@interface ViewController ()

@property (nonatomic, strong) FSAudioStream *audioStream;

@property (nonatomic, strong) NSMutableArray *dataSource;

- (IBAction)startPlay:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 数据源（三首歌）
    _dataSource = [[NSMutableArray alloc]init];
    
    NSArray *arr = @[@{@"url":MUSIC1},@{@"url":MUSIC2},@{@"url":MUSIC3}];
    
    for (NSDictionary *dic in arr) {
        DataModel *model = [[DataModel alloc]initWithDic:dic];
        [_dataSource addObject:model];
    }
}

// 播放网络音频按钮
- (IBAction)startPlay:(id)sender {
    if (!_audioStream) {
        [self playNetworkMusic];
    }
    [_audioStream play];
    
}

// 播放网络音频
- (void)playNetworkMusic
{
    // 网络文件
    NSURL *url=[self getNetworkUrl];
    
    // 创建FSAudioStream对象
    _audioStream=[[FSAudioStream alloc]initWithUrl:url];
    _audioStream.onFailure=^(FSAudioStreamError error,NSString *description){
        NSLog(@"播放过程中发生错误，错误信息：%@",description);
    };
    __weak typeof(self) weakSelf = self;
    _audioStream.onCompletion=^(){
        NSLog(@"播放完成!");
        // 播放完移除对象，重新创建对象播放下一首
        [weakSelf removeFromParentViewController];
        if (_dataSource.count != 0) {
            [weakSelf playNetworkMusic];
            [weakSelf.audioStream play];
        }
    };
    
    // 设置声音
    [_audioStream setVolume:1];
    
}

/**
 *  取得网络文件路径
 *
 *  @return 文件路径
 */
-(NSURL *)getNetworkUrl{
    DataModel *model = _dataSource[0];
    NSString *urlStr = model.urlName;
    NSURL *url=[NSURL URLWithString:urlStr];
    [_dataSource removeObjectAtIndex:0];
    return url;
}

@end
