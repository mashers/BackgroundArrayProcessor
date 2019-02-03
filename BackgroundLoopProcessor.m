//
//  BackgroundArrayProcessor.m
//  Space Invaders Video App
//
//  Created by Mark Ashley on 03/02/2019.
//  Copyright © 2019 Mark Ashley. All rights reserved.
//

#import "BackgroundLoopProcessor.h"

@interface BackgroundLoopProcessor ()
@property NSInteger progressCounter, progressTotal;
@property (nonatomic, copy)  void (^processingBlock)(NSInteger run);
@property (nonatomic, copy)  void (^updateUIBlock)(NSInteger run);
@property (nonatomic, copy)  void (^completionBlock)(void);
@end

@implementation BackgroundLoopProcessor

+ (void)processLoopWithRunCount:(NSInteger)runCount processingBlock:(void(^)(NSInteger run))processingBlock updateUIBlock:(void(^)(NSInteger run))updateUIBlock completionBlock:(void(^)(void))completionBlock {
    BackgroundLoopProcessor *processor = [[BackgroundLoopProcessor alloc] init];
    
    processor.progressCounter = 0;
    processor.progressTotal = runCount;
    processor.processingBlock = processingBlock;
    processor.updateUIBlock = updateUIBlock;
    processor.completionBlock = completionBlock;
    
    [processor scheduleNext];
}

- (void)scheduleNext {
    self.updateUIBlock(self.progressCounter);
    [self performSelector:@selector(next) withObject:nil afterDelay:0.0];
}

- (void)next {
    if (self.progressCounter < self.progressTotal) {
        self.processingBlock(self.progressCounter);
        self.progressCounter++;
        [self scheduleNext];
    }
    else {
        self.completionBlock();
    }
}

@end
