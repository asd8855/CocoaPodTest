//
//  Person.h
//  Runtime
//
//  Created by libo on 2017/11/2.
//  Copyright © 2017年 蝉鸣. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol personDelegate <NSObject>

@property (nonatomic, copy) NSString *deleName;

@end

@interface Person : NSObject {
    
    NSString    *money;
    int         childCount;
}

@property (nonatomic, copy) NSString *name;

@property (nonatomic)       int      age;//岁

@property (nonatomic)       float      height; //厘米

@property (nonatomic, copy) NSString *sex;

@end
