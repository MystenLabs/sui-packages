module 0x5dc8d4fa535b8392d052c532219935cabfde52c54e6e49e2a4b0ebaddcab8e22::base_test {
    public fun print(arg0: vector<u8>) {
        let v0 = 0x1::ascii::string(arg0);
        0x1::debug::print<0x1::ascii::String>(&v0);
    }

    public fun print2(arg0: vector<u8>) {
        let v0 = 0x1::ascii::string(arg0);
        0x1::debug::print<0x1::ascii::String>(&v0);
    }

    public fun print3(arg0: vector<u8>) {
        let v0 = 0x1::ascii::string(arg0);
        0x1::debug::print<0x1::ascii::String>(&v0);
    }

    // decompiled from Move bytecode v6
}

