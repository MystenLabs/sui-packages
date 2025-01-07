module 0x3d67a96a86672808c5c228e9cca46e30708552ec215950c8f8c38b398b4be947::tools {
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

