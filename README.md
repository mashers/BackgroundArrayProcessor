# BackgroundLoopProcessor
An objective-c class to run a loop on the main thread, while still allowing UI updates during processing.

# Use case
In some cases, you may need to carry out UI-intensive operations in a loop, but still want to be able to update the UI to indicate progress. This is a problem in Cocoa because all UI operations must be carried out on the main thread. This means that carrying out UI operations in a loop will block the main thread, meaning you cannot update the UI to indicate progress to the user. This simple class addresses that problem by providing a simple function for running a loop on the main thread, and accepts three blocks as arguments. These blocks allow you to specify the code for processing iterations of the loop, how the UI should be updated in response to the processing of the loop, and a completion block.

# Usage
BackgroundLoopProcessor is extremely simple to use. Simply `#include "BackgroundLoopProcessor.h"` in the class you want to use it, and then call `+[BackgroundLoopProcessor processLoopWithRunCount:processingBlock:updateUIBlock:completionBlock:];`. BackgroundLoopProcessor will then carry out the following operations:
1. Call `updateUIBlock` first, to show an initial progress state
2. Schedule the running of `processingBlock` for the next run loop
3. On the next run loop (and therefore after the UI has updated to show progress), call `processingBlock` and pass the run number to the block (equivalent to the count variable in a `for` loop)
4. Schedule `updateUIBlock` and `processingBlock` for the next run loop
5. Repeat this process until the loop is completed
6. Call `completionBlock`

# Example
    // MyClass.m
    
    #import "BackgroundLoopProcessor.h"
    
    - (IBAction)startprocessing {
        [BackgroundLoopProcessor processLoopWithRunCount:self.myArray.count processingBlock:^(NSInteger run) {
        
            //Get an object from the array using the `run` variable as the index
            id object = [self.myArray objectAtIndex:run];
            
            //Do something with `object`

        } updateUIBlock:^(NSInteger run) {
        
            //Update the UI to show progress

        } completionBlock:^{
        
            //Update the UI to show processing complete

        }];
    }
