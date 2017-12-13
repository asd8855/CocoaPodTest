//
//  UIImage+Tool.m
//  Runtime
//
//  Created by libo on 2017/11/2.
//  Copyright © 2017年 蝉鸣. All rights reserved.
//

#import "UIImage+Tool.h"
#import <objc/runtime.h>
@implementation UIImage (Tool)

//拦截并替换系统方法
+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method method1 = class_getClassMethod([UIImage class], @selector(imageNamed:));
        Method method2 = class_getClassMethod([UIImage class], @selector(xys_imageNamed:));
        
        method_exchangeImplementations(method1, method2);
    });
    
}


/*
    注意：自定义方法中最后一定要再调用一下系统的方法，让其有加载图片的功能，但是由于方法交换，系统的方法名已经变成我们自定义的方法名
 */
+ (UIImage *)xys_imageNamed:(NSString *)name {
    
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    if (version >= 7.0) {
        //如果系统版本是7.0以上，使用另外一套文件名结尾是“_os7”的扁平化图片
        name = [name stringByAppendingString:@"_os7"];
    }
    return [UIImage xys_imageNamed:name];
}


@end
