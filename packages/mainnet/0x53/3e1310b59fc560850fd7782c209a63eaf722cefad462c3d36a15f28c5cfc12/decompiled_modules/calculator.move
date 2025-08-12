module 0x533e1310b59fc560850fd7782c209a63eaf722cefad462c3d36a15f28c5cfc12::calculator {
    public fun accurate_exp_taylor(arg0: u64) : u64 {
        let v0 = 1000000;
        let v1 = 1000000;
        let v2 = 1;
        while (v2 <= 20) {
            v1 = (((v1 as u128) * (arg0 as u128) / (v2 as u128) * (1000000 as u128)) as u64);
            if (v1 < 10) {
                break
            };
            v0 = v0 + v1;
            v2 = v2 + 1;
        };
        v0
    }

    public fun fixed_power(arg0: u64) : u64 {
        assert!(arg0 <= 1000000, 1000);
        accurate_exp_taylor(arg0 * 6551080 / 1000000) / 1000
    }

    public fun get_max_voting_power(arg0: u64, arg1: u64) : u64 {
        if (arg1 < 63072000000) {
            (((arg0 as u128) * ((arg1 * 1000000 / 63072000000) as u128) / (1000000 as u128)) as u64)
        } else {
            arg0
        }
    }

    public fun get_penalty_ratio(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (1000000 as u128);
        fixed_power((((0x1::u128::pow(v0, 3) - 0x1::u128::pow((arg0 as u128) * v0 / (arg1 as u128), 3)) / 0x1::u128::pow(v0, 3 - 1)) as u64)) * (1000000 - arg2 * 1000000 / 2 * (arg1 - arg0)) / 1000000
    }

    // decompiled from Move bytecode v6
}

