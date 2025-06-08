module 0x5e04416a3e1d42795bcf133c36b3829374384eeedaf3c1711a80dd689cebc410::math {
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

