module 0xd4de3644e9f3d291c967c7abe13a4988037c0bc130c7ff300a8f5b1638220012::base_test {
    public fun print(arg0: vector<u8>) {
        let v0 = 0x1::ascii::string(arg0);
        0x1::debug::print<0x1::ascii::String>(&v0);
    }

    public entry fun print2(arg0: vector<u8>) {
        let v0 = 0x1::ascii::string(arg0);
        0x1::debug::print<0x1::ascii::String>(&v0);
    }

    // decompiled from Move bytecode v6
}

