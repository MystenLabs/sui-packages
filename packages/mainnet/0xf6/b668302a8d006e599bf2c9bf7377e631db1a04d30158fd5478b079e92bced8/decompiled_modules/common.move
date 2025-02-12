module 0xf6b668302a8d006e599bf2c9bf7377e631db1a04d30158fd5478b079e92bced8::common {
    public fun find_upper_bound(arg0: vector<u64>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::length<u64>(&arg0) - 1;
        while (v0 < v1) {
            v1 = v0 + (v1 - v0) / 2;
            if (*0x1::vector::borrow<u64>(&arg0, v1) < arg1) {
                v0 = v1 + 1;
                continue
            };
        };
        v0
    }

    // decompiled from Move bytecode v6
}

