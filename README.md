It looks like I was about to apply the README update, but the editing tool is currently unavailable.

✅ Here’s the **updated README content** you can manually copy into your `README.md` file:

---

# BIT-STREAM-CLI

A macOS command-line tool with a supporting Objective-C library for bit stream processing, manipulation, and encrypted MIDI file handling.

---

## 📂 Project Structure

```
BIT-STREAM-CLI/
├── BIT_STREAM_LIB.h      // Objective-C header file for the bit stream library
├── BIT_STREAM_LIB.m      // Objective-C implementation of bit stream functions
├── main.swift            // Swift entry point that uses the bit stream library
```

---

## ⚙️ Build Instructions

### 🛠 Requirements
- macOS
- Xcode command-line tools
- `clang` (for compiling Objective-C)
- `swiftc` (for compiling Swift)

### 💻 Build & Run

1️⃣ Open Terminal  
2️⃣ Navigate to the project directory:
```bash
cd /Users/x86/Documents/BIT-STREAM-CLI
```
3️⃣ Compile the Objective-C code:
```bash
clang -c BIT_STREAM_LIB.m -o BIT_STREAM_LIB.o
```
4️⃣ Compile and link with Swift:
```bash
swiftc main.swift BIT_STREAM_LIB.o -o bitstream
```
5️⃣ Run:
```bash
./bitstream
```

---

## 🚀 Features

✅ Bit stream utility functions (as implemented in `BIT_STREAM_LIB`)  
✅ Swift CLI to interact with the library  
✅ AES-GCM encryption of MIDI data  
✅ Encrypted `.mid` file generation and decryption support  
✅ Swift + Objective-C integration demo  

---

## 📝 Example Usage

### Display help
```bash
./bitstream help
```

### Initialize MIDI
```bash
./bitstream initialize
```

### Send encrypted hex data
```bash
./bitstream send 0x90 0x3C 0x40
```

### Teardown MIDI
```bash
./bitstream teardown
```

### Encrypt a MIDI file
```bash
./bitstream encryptfile input.mid output.mid.enc
```

### Decrypt an encrypted MIDI file
```bash
./bitstream decryptfile output.mid.enc decrypted.mid
```

---

## 🤝 Contribution

Contributions welcome! Open issues or submit PRs.

---

## 📄 License

MIT License (or specify your preferred license).

---

*Updated README for BIT-STREAM-CLI with encrypted MIDI file support*

---
