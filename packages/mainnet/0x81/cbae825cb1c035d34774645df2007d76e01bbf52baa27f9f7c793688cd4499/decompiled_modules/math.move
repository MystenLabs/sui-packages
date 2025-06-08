module 0x81cbae825cb1c035d34774645df2007d76e01bbf52baa27f9f7c793688cd4499::math {
    public fun pow(arg0: u64, arg1: u8) : u64 {
        let v0 = arg0;
        let v1 = arg1;
        let v2 = 1;
        while (v1 >= 1) {
            if (v1 % 2 == 0) {
                v0 = v0 * v0;
                v1 = v1 / 2;
                continue
            };
            v2 = v2 * v0;
            v1 = v1 - 1;
        };
        v2
    }

    // decompiled from Move bytecode v6
}

