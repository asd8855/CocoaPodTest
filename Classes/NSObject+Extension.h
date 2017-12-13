//
//  NSObject+Extension.h
//  Runtime
//
//  Created by libo on 2017/11/2.
//  Copyright © 2017年 蝉鸣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)

- (NSArray *)ignoredNames;

- (void)encode:(NSCoder *)aCoder;

- (void)decode:(NSCoder *)aDecoder;

@end
