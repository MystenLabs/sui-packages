module 0x5d5beb1ef6f1d555eeb8b9b942f5bdaae2ca34d2a794e5e16be6dacf08b10263::formula {
    public(friend) fun compute_base_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = if (arg3 >= arg2) {
            arg3 - arg2
        } else {
            arg2 - arg3
        };
        let v1 = (arg0 as u128) * (arg1 as u128);
        let v2 = (arg0 as u128) * 2 * (arg2 as u128) * (0x5d5beb1ef6f1d555eeb8b9b942f5bdaae2ca34d2a794e5e16be6dacf08b10263::constants::get_k_scale() as u128);
        let v3 = (arg0 as u128) * (arg1 as u128) * 2 * (v0 as u128);
        let v4 = if (arg3 < arg2) {
            v2 + v3
        } else {
            assert!(v2 >= v3, 3);
            v2 - v3
        };
        let v5 = isqrt((v4 as u256) * (v4 as u256) + 4 * (v1 as u256) * (arg4 as u256) * (0x5d5beb1ef6f1d555eeb8b9b942f5bdaae2ca34d2a794e5e16be6dacf08b10263::constants::get_price_precision() as u256) * 2 * (arg2 as u256) * (0x5d5beb1ef6f1d555eeb8b9b942f5bdaae2ca34d2a794e5e16be6dacf08b10263::constants::get_k_scale() as u256));
        assert!(v5 >= (v4 as u256), 4);
        let v6 = (v5 - (v4 as u256)) / 2 * (v1 as u256);
        assert!(v6 > 0, 2);
        (v6 as u64)
    }

    public(friend) fun compute_quote_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = arg3 + arg4;
        let v1 = if (arg3 >= arg2) {
            arg3 - arg2
        } else {
            arg2 - arg3
        };
        let v2 = if (v0 >= arg2) {
            v0 - arg2
        } else {
            arg2 - v0
        };
        let v3 = (arg0 as u128) * (arg4 as u128);
        let v4 = (v1 as u128) * (v1 as u128);
        let v5 = (v2 as u128) * (v2 as u128);
        let v6 = if (v4 >= v5) {
            v4 - v5
        } else {
            v5 - v4
        };
        let v7 = (arg0 as u128) * (arg1 as u128) * v6 / 2 * (arg2 as u128) * (0x5d5beb1ef6f1d555eeb8b9b942f5bdaae2ca34d2a794e5e16be6dacf08b10263::constants::get_k_scale() as u128);
        let v8 = if (v5 > v4) {
            assert!(v3 >= v7, 1);
            v3 - v7
        } else {
            v3 + v7
        };
        ((v8 / (0x5d5beb1ef6f1d555eeb8b9b942f5bdaae2ca34d2a794e5e16be6dacf08b10263::constants::get_price_precision() as u128)) as u64)
    }

    public fun compute_withdraw_penalty(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 >= arg1) {
            return 0
        };
        arg2 * (arg1 - arg0) / arg1
    }

    fun isqrt(arg0: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = v0 + arg0 / v0;
            v0 = v1 / 2;
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

