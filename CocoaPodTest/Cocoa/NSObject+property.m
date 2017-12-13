//
//  NSObject+property.m
//  Runtime
//
//  Created by libo on 2017/11/2.
//  Copyright © 2017年 蝉鸣. All rights reserved.
//

#import "NSObject+property.h"
#import <objc/runtime.h>

//在分类中设置属性，给任何一个对象设置属性
@implementation NSObject (property)
char nameKey;

//void objc_setAssociatedObject(id object , const void *key ,id value ,objc_AssociationPolicy policy)
/*
 set 方法，将value跟对象object关联起来(将值value存储到对象object中)
 object: 给哪个对象设置属性
 key:    一个属性对应一个Key，将来可以通过key取出这个存储的值，key可以是任何类型：double 、int等，建议使用 char 可以节省字节
 value: 给属性设置的值
 policy:存储策略（assign、copy、retain、strong）
 */

- (void)setName:(NSString *)name {
    //将某个值跟某个对象关联起来,将某个值存储到某个对象中
    objc_setAssociatedObject(self, &nameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//id objc_getAssociatedObject(id object , const void *key)
- (NSString *)name {
    return objc_getAssociatedObject(self, &nameKey);
}



@end
