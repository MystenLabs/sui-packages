module 0x3ac5d05edffefeaa7387c234de3a9f25a3a72f6d96b5efb560d81df77899cf74::math {
    public fun d_fdiv(arg0: u64, arg1: u64) : u256 {
        (arg0 as u256) * 1000000000000000000 / (arg1 as u256)
    }

    public fun d_fdiv_u256(arg0: u256, arg1: u256) : u256 {
        arg0 * 1000000000000000000 / arg1
    }

    public fun d_fmul(arg0: u64, arg1: u64) : u256 {
        (arg0 as u256) * (arg1 as u256) / 1000000000000000000
    }

    public fun d_fmul_u256(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1 / 1000000000000000000
    }

    public fun double_scalar() : u256 {
        1000000000000000000
    }

    public fun fdiv_u256(arg0: u256, arg1: u256) : u256 {
        arg0 * 1000000000 / arg1
    }

    public fun fmul_u256(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1 / 1000000000
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u64)
    }

    public fun mul_div_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u128)
    }

    public fun scalar() : u256 {
        1000000000
    }

    public fun sqrt_u256(arg0: u256) : u256 {
        let v0 = 0;
        if (arg0 > 3) {
            v0 = arg0;
            let v1 = arg0 / 2 + 1;
            while (v1 < arg0) {
                v0 = v1;
                let v2 = arg0 / v1 + v1;
                v1 = v2 / 2;
            };
        } else if (arg0 != 0) {
            v0 = 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

