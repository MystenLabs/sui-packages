module 0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::math_fixed {
    public fun div_down(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        (((arg0 as u128) * 1000000000000000000 / (arg1 as u128)) as u64)
    }

    public fun mul_div_down(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000000000000000) as u64)
    }

    public fun pow(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return (1000000000000000000 as u64)
        };
        let v0 = (1000000000000000000 as u64);
        if (arg1 == v0) {
            return arg0
        };
        let v1 = arg1 / v0;
        if (v1 == 0) {
            return (1000000000000000000 as u64)
        };
        let v2 = (arg0 as u128);
        let v3 = 1000000000000000000;
        while (v1 > 0) {
            if (v1 % 2 == 1) {
                let v4 = v3 * v2;
                v3 = v4 / 1000000000000000000;
            };
            let v5 = v2 * v2;
            v2 = v5 / 1000000000000000000;
            v1 = v1 / 2;
        };
        (v3 as u64)
    }

    public fun wad() : u64 {
        (1000000000000000000 as u64)
    }

    // decompiled from Move bytecode v6
}

