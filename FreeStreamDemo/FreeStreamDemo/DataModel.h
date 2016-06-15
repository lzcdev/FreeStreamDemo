//
//  DataModel.h
//  FreeStreamDemo
//
//  Created by LuzhiChao on 16/6/15.
//  Copyright © 2016年 LuzhiChao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property (nonatomic, copy) NSString *urlName;

- (id)initWithDic:(NSDictionary *)dic;

@end
