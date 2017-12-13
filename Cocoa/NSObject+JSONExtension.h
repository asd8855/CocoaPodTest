//
//  NSObject+JSONExtension.h
//  Runtime
//
//  Created by libo on 2017/11/2.
//  Copyright © 2017年 蝉鸣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JSONExtension)

// 返回数组中都是什么类型的模型对象
- (NSString *)arrayObjectClass;

@end
