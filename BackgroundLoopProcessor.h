//
//  BackgroundArrayProcessor.h
//  Space Invaders Video App
//
//  Created by Mark Ashley on 03/02/2019.
//  Copyright © 2019 Mark Ashley. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BackgroundLoopProcessor : NSObject
+ (void)processLoopWithRunCount:(NSInteger)runCount processingBlock:(void(^)(NSInteger run))processingBlock updateUIBlock:(void(^)(NSInteger run))updateUIBlock completionBlock:(void(^)(void))completionBlock;
@end

NS_ASSUME_NONNULL_END
