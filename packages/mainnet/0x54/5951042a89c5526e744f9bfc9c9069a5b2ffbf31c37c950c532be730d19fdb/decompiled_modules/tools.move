module 0x545951042a89c5526e744f9bfc9c9069a5b2ffbf31c37c950c532be730d19fdb::tools {
    public fun pow(arg0: u64, arg1: u8) : u64 {
        let v0 = 1;
        while (arg1 > 0) {
            if (arg1 % 2 == 1) {
                v0 = v0 * arg0;
            };
            arg1 = arg1 / 2;
            arg0 = arg0 * arg0;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

