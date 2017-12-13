//
//  Person.m
//  Runtime
//
//  Created by libo on 2017/11/2.
//  Copyright © 2017年 蝉鸣. All rights reserved.
//

#import "Person.h"
#import "NSObject+Extension.h"

#import <objc/message.h>

@implementation Person


//// 设置需要忽略的属性
//- (NSArray *)ignoredNames {
//    return @[@"bone"];
//}
//
//// 在系统方法内来调用我们的方法
//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    if (self = [super init]) {
//        [self decode:aDecoder];
//    }
//    return self;
//}
//
//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [self encode:aCoder];
//}

void eat(id self,SEL sel) {
    
    NSLog(@"-----%@ %@",self,NSStringFromSelector(sel));
}



// 当一个对象调用未实现的方法，会调用这个方法处理,并且会把对应的方法列表传过来.

// 刚好可以用来判断，未实现的方法是不是我们想要动态添加的方法

+ (BOOL)resolveInstanceMethod:(SEL)sel

{
    
    
    
    if (sel == NSSelectorFromString(@"eat")) {
        
        // 动态添加eat方法
        
        
        // 第一个参数：给哪个类添加方法
        // 第二个参数：添加方法的方法编号
        
        // 第三个参数：添加方法的函数实现（函数地址）
        
        // 第四个参数：函数的类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
        
        class_addMethod(self, sel, (IMP)eat, "v@:");
        
        
        
    }
    
    
    
    return [super resolveInstanceMethod:sel];
    
}





@end
