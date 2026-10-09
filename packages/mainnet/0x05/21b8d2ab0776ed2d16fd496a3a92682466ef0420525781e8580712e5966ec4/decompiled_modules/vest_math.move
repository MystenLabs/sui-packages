module 0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::vest_math {
    public fun day_ms() : u64 {
        86400000
    }

    public fun duration_ms(arg0: u64, arg1: &vector<u64>) : u64 {
        assert!(0x1::vector::contains<u64>(arg1, &arg0), 501);
        arg0 * 86400000
    }

    public fun linear_vested(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 >= arg2) {
            arg0
        } else {
            0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::mul_div(arg0, arg1, arg2)
        }
    }

    public fun rate_of(arg0: u64, arg1: u64, arg2: u64) : u256 {
        if (arg2 >= arg1) {
            return 0
        };
        let v0 = ((arg1 - arg2) as u256);
        ((arg0 as u256) * 1000000000000000000 + v0 - 1) / v0
    }

    public fun rate_scale() : u256 {
        1000000000000000000
    }

    public fun unvested(arg0: u64, arg1: u256, arg2: u64, arg3: u64) : u64 {
        if (arg3 >= arg2) {
            return 0
        };
        let v0 = (arg1 * ((arg2 - arg3) as u256) + 1000000000000000000 - 1) / 1000000000000000000;
        if (v0 >= (arg0 as u256)) {
            arg0
        } else {
            (v0 as u64)
        }
    }

    // decompiled from Move bytecode v7
}

