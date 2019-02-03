//
//  BackgroundArrayProcessor.m
//  Space Invaders Video App
//
//  Created by Mark Ashley on 03/02/2019.
//  Copyright © 2019 Mark Ashley. All rights reserved.
//

#import "BackgroundArrayProcessor.h"

@interface BackgroundArrayProcessor ()
@property NSInteger progressCounter, progressTotal;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, copy)  void (^processingBlock)(id obj);
@property (nonatomic, copy)  void (^updateUIBlock)(NSInteger counter, NSInteger total);
@property (nonatomic, copy)  void (^completionBlock)(void);
@end

@implementation BackgroundArrayProcessor

+ (void)processArray:(NSMutableArray *)array processingBlock:(void (^)(id _Nonnull))processingBlock updateUIBlock:(void (^)(NSInteger, NSInteger))updateUIBlock completionBlock:(void (^)(void))completionBlock {
    BackgroundArrayProcessor *processor = [[BackgroundArrayProcessor alloc] init];
    
    processor.progressCounter = 1;
    processor.progressTotal = array.count;
    processor.array = array;
    processor.processingBlock = processingBlock;
    processor.updateUIBlock = updateUIBlock;
    processor.completionBlock = completionBlock;
    
    [processor scheduleNext];
}

- (void)scheduleNext {
    self.updateUIBlock(self.progressCounter, self.progressTotal);
    [self performSelector:@selector(next) withObject:nil afterDelay:0.0];
}

- (void)next {
    if (self.array.count > 0) {
        id obj = self.array.firstObject;
        self.processingBlock(obj);
        [self.array removeObject:obj];
        self.progressCounter++;
        [self scheduleNext];
    }
    else {
        self.completionBlock();
    }
}

@end
