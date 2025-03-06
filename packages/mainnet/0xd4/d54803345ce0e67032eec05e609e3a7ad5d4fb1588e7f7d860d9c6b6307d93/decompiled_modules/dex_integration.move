module 0xd4d54803345ce0e67032eec05e609e3a7ad5d4fb1588e7f7d860d9c6b6307d93::dex_integration {
    public fun validate_name(arg0: vector<u8>, arg1: bool, arg2: bool, arg3: bool) : bool {
        if (arg0 == b"FlowX") {
            return arg1
        };
        if (arg0 == b"Aftermath") {
            return arg2
        };
        if (arg0 == b"Kriya") {
            return arg3
        };
        false
    }

    // decompiled from Move bytecode v6
}

