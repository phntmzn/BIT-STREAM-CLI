//
//  BIT_STREAM_LIB.m
//  BIT-STREAM-LIB
//
//  Created by bRx86 on 4/13/25.
//

#import "BIT_STREAM_LIB.h"
#import <CoreMIDI/CoreMIDI.h>

@implementation BIT_STREAM_LIB
{
    MIDIClientRef _midiClient;
    MIDIPortRef _outputPort;
    MIDIEndpointRef _destination;
}

- (BOOL)initializeMIDI {
    OSStatus status;

    status = MIDIClientCreate(CFSTR("BitStreamClient"), NULL, NULL, &_midiClient);
    if (status != noErr) return NO;

    status = MIDIOutputPortCreate(_midiClient, CFSTR("BitStreamOutput"), &_outputPort);
    if (status != noErr) return NO;

    ItemCount destCount = MIDIGetNumberOfDestinations();
    if (destCount < 1) return NO;

    _destination = MIDIGetDestination(0);
    return YES;
}

- (void)sendBitStream:(NSData *)data {
    if (!_destination || !_outputPort) return;

    Byte buffer[1024];
    MIDIPacketList *packetList = (MIDIPacketList *)buffer;
    MIDIPacket *packet = MIDIPacketListInit(packetList);
    packet = MIDIPacketListAdd(packetList, sizeof(buffer), packet, 0, data.length, data.bytes);

    if (packet)
        MIDISend(_outputPort, _destination, packetList);
}

- (void)teardownMIDI {
    if (_outputPort) MIDIPortDispose(_outputPort);
    if (_midiClient) MIDIClientDispose(_midiClient);
}

@end
