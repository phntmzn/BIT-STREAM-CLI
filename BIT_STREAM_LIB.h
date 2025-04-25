//
//  BIT_STREAM_LIB.h
//  BIT-STREAM-CLI
//
//  Created by bRx86 on 4/13/25.
//

#ifndef BIT_STREAM_LIB_h
#define BIT_STREAM_LIB_h

#import <Foundation/Foundation.h>

@interface BIT_STREAM_LIB : NSObject

- (void)initializeMIDI;
- (void)sendBitStream:(NSData *)data;
- (void)teardownMIDI;

@end

#endif /* BIT_STREAM_LIB_h */
