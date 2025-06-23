import Foundation
// Assuming you imported BIT_STREAM_LIB via bridging header or module map
// Make sure to bridge Objective-C with Swift using a bridging header if needed

func printUsage() {
    print("""
    BIT-STREAM-CLI — Usage:
    ------------------------
    initialize         Initialize MIDI session
    send <hexdata>     Send bitstream as hex (e.g., send 0xDEADBEEF)
    teardown           Close MIDI session
    """)
}

let args = CommandLine.arguments

guard args.count > 1 else {
    printUsage()
    exit(0)
}

let bitstream = BIT_STREAM_LIB()

switch args[1] {
case "initialize":
    bitstream.initializeMIDI()
    print("MIDI Initialized")

case "send":
    guard args.count > 2 else {
        print("Provide hex data to send")
        exit(1)
    }

    let hexString = args[2].replacingOccurrences(of: "0x", with: "")
    var data = Data()

    var index = hexString.startIndex
    while index < hexString.endIndex {
        let nextIndex = hexString.index(index, offsetBy: 2, limitedBy: hexString.endIndex) ?? hexString.endIndex
        if nextIndex <= hexString.endIndex {
            let byteStr = hexString[index..<nextIndex]
            if let byte = UInt8(byteStr, radix: 16) {
                data.append(byte)
            }
        }
        index = nextIndex
    }

    bitstream.sendBitStream(data)
    print("Bitstream sent: \(data as NSData)")

case "teardown":
    bitstream.teardownMIDI()
    print("MIDI Teardown complete")

default:
    print("Unknown command: \(args[1])")
    printUsage()
}
