module 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::math {
    fun checked_mul_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg0 <= 18446744073709551615 / arg1, 13835339594683383809);
        arg0 * arg1
    }

    public fun pow_u64(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 1
        };
        if (arg0 == 0) {
            return 0
        };
        if (arg0 == 1) {
            return 1
        };
        let v0 = 1;
        let v1 = arg1;
        while (v1 > 0) {
            if (v1 & 1 == 1) {
                v0 = checked_mul_u64(v0, arg0);
            };
            v1 = v1 >> 1;
            if (v1 > 0) {
                arg0 = checked_mul_u64(arg0, arg0);
            };
        };
        v0
    }

    // decompiled from Move bytecode v6
}

