

# BIT-STREAM-CLI

A macOS command-line tool with a supporting Objective-C library for bit stream processing and manipulation.

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
✅ Demonstrates Swift + Objective-C integration  

---

## 📝 Example Usage

Once built, run the executable:
```bash
./bitstream
```

### Example 1: Display help
Modify `main.swift` to accept a `--help` argument and print:
```bash
./bitstream --help
```
Expected output:
```
BIT-STREAM-CLI Usage:
  --help         Show this help message
  --set <value>  Set a bit value
  --get <index>  Get bit at index
```

### Example 2: Set a bit value
```bash
./bitstream --set 10101010
```
Expected behavior: The tool stores or manipulates the bit stream to `10101010`.

### Example 3: Get a bit at index
```bash
./bitstream --get 3
```
Expected output:
```
Bit at index 3: 0
```

### Example 4: Chain commands
```bash
./bitstream --set 11001100 --get 2
```
Expected output:
```
Bit at index 2: 0
```

You can extend `main.swift` to support these CLI arguments if not already implemented.

---

## 🤝 Contribution

Contributions welcome! Open issues or submit PRs.

---

## 📄 License

MIT License (or specify your preferred license).

---

*Generated README for BIT-STREAM-CLI*
