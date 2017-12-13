//
//  NSObject+Extension.m
//  Runtime
//
//  Created by libo on 2017/11/2.
//  Copyright © 2017年 蝉鸣. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/runtime.h>
@implementation NSObject (Extension)

- (void)decode:(NSCoder *)aDecoder {
    //一层层父类往上查找，对父类的属性执行归解档方法
    Class cl = self.class;
    while (cl && cl != [NSObject class]) {
        
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList(cl, &outCount);
        for (int i = 0; i < outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            //如果有实现该方法再调用
            if ([self respondsToSelector:@selector(ignoredNames)]) {
                if ([[self ignoredNames] containsObject:key]) continue;
            }
            
            //根据变量名解档取值，无论是什么类型
            id value = [aDecoder decodeObjectForKey:key];
            //取出的值再设置给属性
            [self setValue:value forKey:key];
        }
        free(ivars);
        cl = [cl superclass];
    }
}

- (void)encode:(NSCoder *)aCoder {
    
   //一层层父类往上查找,对父类的属性执行归解档方法
    Class cl = self.class;
    while (cl && cl != [NSObject class]) {
        
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList(cl, &outCount);
        for (int i = 0; i < outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            //如果有实现该方法再去调用
            if ([self respondsToSelector:@selector(ignoredNames)]) {
                if ([[self ignoredNames] containsObject:key]) continue;
            }
            
            //通过成员变量名,取出成员变量的值
            id value = [self valueForKey:key];
            //再将值归档
            [aCoder encodeObject:value forKey:key];
        }
        //释放内存，因为是C语言的，内存需要我们自己管理
        free(ivars);
        cl = [cl superclass];
    }
}





@end
