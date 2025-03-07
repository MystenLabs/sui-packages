module 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::dex_integration {
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

