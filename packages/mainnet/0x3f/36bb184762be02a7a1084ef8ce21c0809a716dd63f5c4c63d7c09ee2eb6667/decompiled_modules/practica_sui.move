module 0x3f36bb184762be02a7a1084ef8ce21c0809a716dd63f5c4c63d7c09ee2eb6667::practica_sui {
    fun practica() {
        let v0 = 0x1::string::utf8(b"Hello, World!");
        0x1::debug::print<0x1::string::String>(&v0);
    }

    // decompiled from Move bytecode v6
}

