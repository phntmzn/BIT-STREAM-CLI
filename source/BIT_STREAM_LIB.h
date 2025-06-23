//
//  BIT_STREAM_LIB.h
//  BIT-STREAM-LIB
//
//  Created by bRx86 on 4/13/25.
//

#import <Foundation/Foundation.h>

@interface BIT_STREAM_LIB : NSObject

- (BOOL)initializeMIDI;
- (void)sendBitStream:(NSData *)data;
- (void)teardownMIDI;

@end
