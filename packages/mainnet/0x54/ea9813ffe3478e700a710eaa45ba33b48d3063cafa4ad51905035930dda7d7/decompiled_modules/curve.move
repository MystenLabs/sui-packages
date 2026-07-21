module 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::curve {
    fun assert_invariant(arg0: u128, arg1: u128, arg2: u128) {
        assert!((arg1 as u256) * (arg2 as u256) >= (arg0 as u256), 5);
    }

    public fun buy_cost_exact_out(arg0: u64, arg1: u64, arg2: u64) : (u64, u64, u64) {
        assert!(arg2 < arg0, 4);
        let v0 = (arg0 as u128) * (arg1 as u128);
        let v1 = ((arg0 - arg2) as u128);
        let v2 = div_ceil(v0, v1);
        assert!(v2 <= 18446744073709551615, 3);
        assert_invariant(v0, v1, v2);
        (((v2 - (arg1 as u128)) as u64), (v1 as u64), (v2 as u64))
    }

    public fun buy_out(arg0: u64, arg1: u64, arg2: u64) : (u64, u64, u64) {
        let v0 = (arg0 as u128) * (arg1 as u128);
        let v1 = (arg1 as u128) + (arg2 as u128);
        assert!(v1 <= 18446744073709551615, 3);
        let v2 = div_ceil(v0, v1);
        assert_invariant(v0, v2, v1);
        ((((arg0 as u128) - v2) as u64), (v2 as u64), (v1 as u64))
    }

    public fun buy_out_preview(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let (v0, _, _) = buy_out(arg0, arg1, arg2);
        v0
    }

    public fun derive_virtual_reserves(arg0: u64, arg1: u64, arg2: u64) : (u64, u64, u64) {
        assert!(arg1 > 0 && arg0 > arg1, 1);
        assert!(arg2 > 0, 2);
        let v0 = ((arg0 - arg1) as u128);
        let v1 = (arg0 as u128) * (arg0 as u128) / v0;
        assert!(v1 <= 18446744073709551615, 3);
        let v2 = div_ceil((arg2 as u128) * (arg1 as u128), v0);
        assert!(v2 > 0 && v2 <= 18446744073709551615, 3);
        ((v1 as u64), (v2 as u64), (v1 as u64) - arg0)
    }

    fun div_ceil(arg0: u128, arg1: u128) : u128 {
        (arg0 + arg1 - 1) / arg1
    }

    public fun fee_amount(arg0: u64, arg1: u64) : u64 {
        (div_ceil((arg0 as u128) * (arg1 as u128), (10000 as u128)) as u64)
    }

    public fun full_range_lower_sqrt_price() : u128 {
        4302785677
    }

    public fun full_range_upper_sqrt_price() : u128 {
        79084200890414257525634219231
    }

    public fun initial_sqrt_price_x64(arg0: u64, arg1: u64) : u128 {
        assert!(arg0 > 0 && arg1 > 0, 6);
        (isqrt((arg1 as u256) * 340282366920938463463374607431768211456 / (arg0 as u256)) as u128)
    }

    public fun isqrt(arg0: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = 340282366920938463463374607431768211456;
        let v1 = v0;
        loop {
            v1 = v1 + arg0 / v1 >> 1;
            if (v1 >= v0) {
                break
            };
        };
        v0
    }

    public fun seed_base_amount(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 6);
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun sell_out(arg0: u64, arg1: u64, arg2: u64) : (u64, u64, u64) {
        let v0 = (arg0 as u128) * (arg1 as u128);
        let v1 = (arg0 as u128) + (arg2 as u128);
        assert!(v1 <= 18446744073709551615, 3);
        let v2 = div_ceil(v0, v1);
        assert_invariant(v0, v1, v2);
        ((((arg1 as u128) - v2) as u64), (v1 as u64), (v2 as u64))
    }

    public fun tvl_in_quote(arg0: u64, arg1: u64, arg2: u128, arg3: bool) : u128 {
        let v0 = (arg2 as u256);
        let v1 = if (arg3) {
            ((arg0 as u256) * v0 >> 64) * v0 >> 64
        } else {
            (((arg0 as u256) << 64) / v0 << 64) / v0
        };
        let v2 = (arg1 as u256) + v1;
        if (v2 > 340282366920938463463374607431768211455) {
            340282366920938463463374607431768211455
        } else {
            (v2 as u128)
        }
    }

    public fun vested_amount(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 7);
        let v0 = if (arg1 > arg2) {
            arg2
        } else {
            arg1
        };
        (((arg0 as u128) * (v0 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v7
}

