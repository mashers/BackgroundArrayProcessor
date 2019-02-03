# BackgroundArrayProcessor
An objective-c class to process an array of items in some way on the main thread, while still allowing UI updates during processing.

# Use case
In some cases, you may need to carry out UI-intensive operations in a loop, but still want to be able to update the UI to indicate progress. This is a problem in Cocoa because all UI operations must be carried out on the main thread. This means that iterating through an array of objects to process them in sequence and carry out UI changes will block the main thread, meaning you cannot update the UI to indicate progress to the user. This simple class addresses that problem by providing a simple function for processing of an array of objects, which accepts three blocks as arguments. These blocks allow you to specify the code for processing each object in the array, how the UI should be updated in response to the processing of the array, and a completion block.

# Usage
BackgroundArrayProcessor is extremely simple to use. Simply `#include "BackgroundArrayProcessor.h"` in the class you want to use it, and then call `+[BackgroundArrayProcessor processArray:processingBlock:updateUIBlock:completionBlock:];`. BackgroundArrayProcessor will then carry out the following operations:
1. Call `updateUIBlock` first, to show an initial progress state
2. Schedule the running of `processingBlock` for the next run loop
3. On the next run loop (and therefore after the UI has updated to show progress), call `processingBlock` and pass the first object in the array to the block, so that it can be processed accordingly
4. Schedule `updateUIBlock` and `processingBlock` for the next run loop
5. Repeat this process until the array is empty
6. Call `completionBlock`

# Example
    // MyClass.m
    
    #import "BackgroundArrayProcessor.h"
    
    - (IBAction)startprocessing {
        [BackgroundArrayProcessor processArray:self.dataArray processingBlock:^(id  _Nonnull obj) {
        
            //Do something with obj
        
        } updateUIBlock:^(NSInteger count, NSInteger total) {
    
            //Update progress on the UI, using `count` and `total` to determine progress

        } completionBlock:^{
        
            //Indicate completion
        
        }];
    }
