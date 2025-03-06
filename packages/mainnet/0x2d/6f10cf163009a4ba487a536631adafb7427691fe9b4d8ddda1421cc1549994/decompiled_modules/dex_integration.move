module 0x2d6f10cf163009a4ba487a536631adafb7427691fe9b4d8ddda1421cc1549994::dex_integration {
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

