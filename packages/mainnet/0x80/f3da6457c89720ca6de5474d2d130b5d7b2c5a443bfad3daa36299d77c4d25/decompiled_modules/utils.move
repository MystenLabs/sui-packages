module 0x80f3da6457c89720ca6de5474d2d130b5d7b2c5a443bfad3daa36299d77c4d25::utils {
    public fun log<T0>(arg0: vector<u8>, arg1: &T0) {
        let v0 = 0x1::string::utf8(arg0);
        0x1::debug::print<0x1::string::String>(&v0);
        0x1::debug::print<T0>(arg1);
    }

    // decompiled from Move bytecode v6
}

