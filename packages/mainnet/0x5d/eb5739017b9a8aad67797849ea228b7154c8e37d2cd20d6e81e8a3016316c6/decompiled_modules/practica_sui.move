module 0x5deb5739017b9a8aad67797849ea228b7154c8e37d2cd20d6e81e8a3016316c6::practica_sui {
    fun practica() {
        let v0 = 0x1::string::utf8(b"Hello, World!");
        0x1::debug::print<0x1::string::String>(&v0);
    }

    // decompiled from Move bytecode v6
}

