module 0x348229cdf651b03c9ce5bc6030ebd7c69f36591554d91c1f1b071bc0096a0469::practica_sui {
    fun practica() {
        let v0 = 0x1::string::utf8(b"Hello, World!");
        0x1::debug::print<0x1::string::String>(&v0);
    }

    // decompiled from Move bytecode v6
}

