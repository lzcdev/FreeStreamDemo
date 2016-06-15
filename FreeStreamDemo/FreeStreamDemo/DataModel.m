
//
//  DataModel.m
//  FreeStreamDemo
//
//  Created by LuzhiChao on 16/6/15.
//  Copyright © 2016年 LuzhiChao. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.urlName = dic[@"url"];
    }
    return self;
}

@end
