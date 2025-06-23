import Foundation
// Assuming you imported BIT_STREAM_LIB via bridging header or module map
// Make sure to bridge Objective-C with Swift using a bridging header if needed
import Foundation
import CryptoKit
import BIT_STREAM_LIB

struct CryptoHelper {
    static func encrypt(_ data: Data, key: SymmetricKey) throws -> Data {
        let sealedBox = try AES.GCM.seal(data, using: key)
        return sealedBox.combined!
    }

    static func decrypt(_ data: Data, key: SymmetricKey) throws -> Data {
        let sealedBox = try AES.GCM.SealedBox(combined: data)
        return try AES.GCM.open(sealedBox, using: key)
    }
}

// Example: Incoming MIDI data (replace with real input)
// let midiData: Data = Data([0x90, 0x3C, 0x40, 0x80, 0x3C, 0x40])  // Note on/off

// Generate a symmetric key (store this securely in real apps)
let key = SymmetricKey(size: .bits256)

// Encrypt using AES-GCM
// do {
//     let sealedBox = try AES.GCM.seal(midiData, using: key)
//     let encryptedData = sealedBox.combined!
//
//     print("Encrypted MIDI (Base64): \(encryptedData.base64EncodedString())")
//
//     // To decrypt:
//     let box = try AES.GCM.SealedBox(combined: encryptedData)
//     let decryptedData = try AES.GCM.open(box, using: key)
//
//     print("Decrypted MIDI: \(decryptedData as NSData)")
// } catch {
//     print("Encryption error: \(error)")
// }


func printUsage() {
    print("""
    BIT-STREAM-CLI — Usage:
    ------------------------
    initialize         Initialize MIDI session
    send <hexdata>     Send bitstream as hex (e.g., send 0xDEADBEEF)
    teardown           Close MIDI session
    version              Show version info
    help                 Show this help message
    """)
}

let args = CommandLine.arguments

guard args.count > 1 else {
    printUsage()
    exit(0)
}

class BitStreamManager {
    private let lib = BIT_STREAM_LIB()
    
    func initialize() {
        lib.initializeMIDI()
    }
    
    func send(data: Data) {
        lib.sendBitStream(data)
    }
    
    func teardown() {
        lib.teardownMIDI()
    }
}

let manager = BitStreamManager()

switch args[1] {
case "initialize":
    manager.initialize()
    print("MIDI Initialized")

case "send":
    guard args.count > 2 else {
        print("Provide hex data to send")
        exit(1)
    }

    let hexString = args.dropFirst(2).joined().replacingOccurrences(of: "0x", with: "")
    
    if hexString.count % 2 != 0 {
        print("Hex string must have even length")
        exit(1)
    }

    var data = Data()

    var index = hexString.startIndex
    while index < hexString.endIndex {
        let nextIndex = hexString.index(index, offsetBy: 2, limitedBy: hexString.endIndex) ?? hexString.endIndex
        if nextIndex <= hexString.endIndex {
            let byteStr = hexString[index..<nextIndex]
            if let byte = UInt8(byteStr, radix: 16) {
                data.append(byte)
            } else {
                print("Invalid hex byte: \(byteStr)")
                exit(1)
            }
        }
        index = nextIndex
    }

    do {
        let encrypted = try CryptoHelper.encrypt(data, key: key)
        manager.send(data: encrypted)
        print("Encrypted bitstream sent (Base64): \(encrypted.base64EncodedString())")
    } catch {
        print("Encryption failed: \(error)")
    }

case "teardown":
    manager.teardown()
    print("MIDI Teardown complete")

case "help":
    printUsage()

case "version":
    print("BIT-STREAM-CLI v1.0.0")

default:
    print("Unknown command: \(args[1])")
    printUsage()
}

case "encryptfile":
    guard args.count > 3 else {
        print("Usage: encryptfile <input.mid> <output.enc>")
        exit(1)
    }

    let inputPath = args[2]
    let outputPath = args[3]

    do {
        let midiData = try Data(contentsOf: URL(fileURLWithPath: inputPath))
        let encrypted = try CryptoHelper.encrypt(midiData, key: key)
        try encrypted.write(to: URL(fileURLWithPath: outputPath))
        print("Encrypted MIDI written to \(outputPath)")
    } catch {
        print("Failed to encrypt MIDI file: \(error)")
    }

case "decryptfile":
    guard args.count > 3 else {
        print("Usage: decryptfile <input.enc> <output.mid>")
        exit(1)
    }

    let inputPath = args[2]
    let outputPath = args[3]

    do {
        let encData = try Data(contentsOf: URL(fileURLWithPath: inputPath))
        let decrypted = try CryptoHelper.decrypt(encData, key: key)
        try decrypted.write(to: URL(fileURLWithPath: outputPath))
        print("Decrypted MIDI written to \(outputPath)")
    } catch {
        print("Failed to decrypt MIDI file: \(error)")
    }
