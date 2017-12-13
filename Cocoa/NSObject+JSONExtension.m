//
//  NSObject+JSONExtension.m
//  Runtime
//
//  Created by libo on 2017/11/2.
//  Copyright © 2017年 蝉鸣. All rights reserved.
//

#import "NSObject+JSONExtension.h"
#import <objc/runtime.h>
@implementation NSObject (JSONExtension)

- (void)setDict:(NSDictionary *)dict {
    
    Class cl = self.class;
    while (cl && cl != [NSObject class]) {
        
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList(cl, &outCount);
        for (int i = 0 ; i < outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            //成员变量名转为属性名(去掉下划线) 大括号里面的变量有可能没有
            if ([key containsString:@"_"]) {
                key = [key substringFromIndex:1];
            }
            //取出字典的值
            id value = dict[key];
            
            //当字典的key和模型的属性匹配不上
            //如果模型属性数量大于字典键值对数量,模型属性会被赋值为nil而报错
            if (value == nil) continue;
            
            
            //获取成员变量的类型
            NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
            //如果属性时对象类型
            NSRange range = [type rangeOfString:@"@"];
            if (range.location != NSNotFound) {
                //那么截取对象的名字(比如@"Dog",截取为Dog)
                type = [type substringWithRange:NSMakeRange(2, type.length - 3)];
                //排除系统的对象类型
                if (![type hasPrefix:@"NS"]) {
                    //模型中嵌套模型（模型属性是另外一个模型对象）

                    //将对象名转换为对象的类型，将新的对象字典转模型(递归)
                    Class class = NSClassFromString(type);
                    value = [class objectWithDict:value];
                }else if ([type isEqualToString:@"NSArray"]) {
                    //数组中装着模型（模型的属性是一个数组，数组中是一个个模型对象）

                    NSArray *array = (NSArray *)value;
                    NSMutableArray *mArray = [NSMutableArray array];
                    
                    //获取到每个模型的类型
                    id class;
                    if ([self respondsToSelector:@selector(arrayObjectClass)]) {
                        NSString *classStr = [self arrayObjectClass];
                        class = NSClassFromString(classStr);
                    }
                    //将数组中的所有模型进行字典转模型
                    for (int i = 0; i < array.count; i++) {
                        [mArray addObject:[class objectWithDict:value[i]]];
                    }
                    value = mArray;
                }
            }
            
            //将字典中的值设置到模型上
            [self setValue:value forKeyPath:key];
            
        }
        free(ivars);
        cl = [cl superclass];
    }
}

+ (instancetype)objectWithDict:(NSDictionary *)dict {
    NSObject *obj = [[self alloc]init];
    [obj setDict:dict];
    return obj;
}

@end
