module 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::math_utils {
    public fun integer_sqrt(arg0: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        if (arg0 < 4) {
            return 1
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = arg0 / v0 + v0;
            v0 = v1 / 2;
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

