module 0x19ad44eabbf577beb3fb8d853f384d27f999cca7d6f1765b819d5630fcf1580b::dex_integration {
    public fun validate_name(arg0: vector<u8>, arg1: bool, arg2: bool, arg3: bool, arg4: bool) : bool {
        if (arg0 == b"FlowX") {
            return arg1
        };
        if (arg0 == b"Aftermath") {
            return arg2
        };
        if (arg0 == b"Kriya") {
            return arg3
        };
        if (arg0 == b"Magma") {
            return arg4
        };
        false
    }

    // decompiled from Move bytecode v6
}

