module 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math {
    struct Volatility has copy, drop, store {
        reference: u64,
        accumulator: u64,
        index_reference: u32,
        last_update_ms: u64,
    }

    public fun accumulate(arg0: &mut Volatility, arg1: u32, arg2: u64) {
        let v0 = if (arg1 > arg0.index_reference) {
            arg1 - arg0.index_reference
        } else {
            arg0.index_reference - arg1
        };
        arg0.accumulator = (0x1::u128::min((arg0.reference as u128) + (v0 as u128) * (10000 as u128), (arg2 as u128)) as u64);
    }

    public fun accumulator(arg0: &Volatility) : u64 {
        arg0.accumulator
    }

    public fun base_fee_rate(arg0: u64, arg1: u64) : u64 {
        (0x1::u128::min((arg0 as u128) * (arg1 as u128) * 10, (100000000 as u128)) as u64)
    }

    public fun basis() : u64 {
        10000
    }

    public fun ceil_div(arg0: u256, arg1: u256) : u256 {
        assert!(arg1 > 0, 1);
        if (arg0 == 0) {
            0
        } else {
            (arg0 - 1) / arg1 + 1
        }
    }

    public fun composition_fee(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: u64) : (u64, u64) {
        assert!(arg5 <= 100000000, 2);
        let v0 = liquidity(arg0, arg1, arg4);
        let v1 = liquidity(arg2, arg3, arg4);
        let v2 = if (v0 == 0) {
            true
        } else if (v1 == 0) {
            true
        } else {
            arg5 == 0
        };
        if (v2) {
            return (0, 0)
        };
        let v3 = v0 + v1;
        let v4 = ((arg0 as u256) + (arg2 as u256)) * v1 / v3;
        let v5 = ((arg1 as u256) + (arg3 as u256)) * v1 / v3;
        let v6 = if ((arg2 as u256) > v4) {
            fee_on_net((arg2 as u256) - v4, arg5)
        } else {
            0
        };
        let v7 = if ((arg3 as u256) > v5) {
            fee_on_net((arg3 as u256) - v5, arg5)
        } else {
            0
        };
        ((0x1::u256::min(v6, (arg2 as u256)) as u64), (0x1::u256::min(v7, (arg3 as u256)) as u64))
    }

    public fun fee_on(arg0: u256, arg1: u64) : u256 {
        ceil_div(arg0 * (arg1 as u256), (1000000000 as u256))
    }

    public fun fee_on_net(arg0: u256, arg1: u64) : u256 {
        ceil_div(arg0 * (arg1 as u256), ((1000000000 - arg1) as u256))
    }

    public fun fee_precision() : u64 {
        1000000000
    }

    public fun id_offset() : u32 {
        8388608
    }

    public fun index_reference(arg0: &Volatility) : u32 {
        arg0.index_reference
    }

    public fun last_update_ms(arg0: &Volatility) : u64 {
        arg0.last_update_ms
    }

    public fun liquidity(arg0: u64, arg1: u64, arg2: u128) : u256 {
        (arg0 as u256) * (arg2 as u256) + ((arg1 as u256) << 64)
    }

    public fun max_bin_step() : u64 {
        500
    }

    public fun max_fee_rate() : u64 {
        100000000
    }

    public fun max_id() : u32 {
        16777215
    }

    public fun new_volatility(arg0: u32, arg1: u64) : Volatility {
        Volatility{
            reference       : 0,
            accumulator     : 0,
            index_reference : arg0,
            last_update_ms  : arg1,
        }
    }

    public fun one() : u256 {
        18446744073709551616
    }

    public fun price(arg0: u32, arg1: u64) : u128 {
        assert!(arg1 > 0 && arg1 <= 500, 3);
        assert!(arg0 <= 16777215, 1);
        let (v0, v1) = if (arg0 >= 8388608) {
            (false, arg0 - 8388608)
        } else {
            (true, 8388608 - arg0)
        };
        let v2 = v1;
        let v3 = 18446744073709551616;
        let v4 = 18446744073709551616 + (arg1 as u256) * 18446744073709551616 / (10000 as u256);
        while (v2 > 0) {
            if (v2 & 1 == 1) {
                let v5 = v3 * v4 >> 64;
                v3 = v5;
                assert!(v5 <= 340282366920938463463374607431768211455, 1);
            };
            v2 = v2 >> 1;
            if (v2 > 0) {
                assert!(v4 <= 340282366920938463463374607431768211455, 1);
                let v6 = v4 * v4;
                v4 = v6 >> 64;
            };
        };
        let v7 = if (v0) {
            18446744073709551616 * 18446744073709551616 / v3
        } else {
            v3
        };
        assert!(v7 > 0 && v7 <= 340282366920938463463374607431768211455, 1);
        (v7 as u128)
    }

    public fun reference(arg0: &Volatility) : u64 {
        arg0.reference
    }

    public fun refresh(arg0: &mut Volatility, arg1: u32, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = if (arg2 > arg0.last_update_ms) {
            arg2 - arg0.last_update_ms
        } else {
            0
        };
        if (v0 < arg3) {
            return
        };
        arg0.index_reference = arg1;
        let v1 = if (v0 < arg4) {
            (((arg0.accumulator as u128) * (arg5 as u128) / (10000 as u128)) as u64)
        } else {
            0
        };
        arg0.reference = v1;
    }

    public fun share_of(arg0: u64, arg1: u256, arg2: u256) : u64 {
        assert!(arg2 > 0 && arg1 <= arg2, 1);
        (((arg0 as u256) * arg1 / arg2) as u64)
    }

    public fun swap_in_bin(arg0: u64, arg1: u64, arg2: u128, arg3: u64, arg4: bool, arg5: u64) : (u64, u64, u64, u64) {
        assert!(arg5 <= 100000000, 2);
        assert!(arg2 > 0, 1);
        let v0 = if (arg4) {
            arg1
        } else {
            arg0
        };
        if (v0 == 0 || arg3 == 0) {
            return (0, 0, 0, 0)
        };
        let v1 = (arg2 as u256);
        let v2 = if (arg4) {
            ceil_div((v0 as u256) << 64, v1)
        } else {
            ceil_div((v0 as u256) * v1, 18446744073709551616)
        };
        let v3 = fee_on_net(v2, arg5);
        if ((arg3 as u256) >= v2 + v3) {
            return (((v2 + v3) as u64), (v2 as u64), (v3 as u64), v0)
        };
        let v4 = fee_on((arg3 as u256), arg5);
        let v5 = (arg3 as u256) - v4;
        let v6 = if (arg4) {
            v5 * v1 >> 64
        } else {
            (v5 << 64) / v1
        };
        (arg3, (v5 as u64), (v4 as u64), (0x1::u256::min(v6, (v0 as u256)) as u64))
    }

    public fun total_fee_rate(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        0x1::u64::min(base_fee_rate(arg0, arg1) + variable_fee_rate(arg2, arg1, arg3), 100000000)
    }

    public fun touch(arg0: &mut Volatility, arg1: u64) {
        if (arg1 > arg0.last_update_ms) {
            arg0.last_update_ms = arg1;
        };
    }

    public fun variable_fee_rate(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0 || arg0 == 0) {
            return 0
        };
        let v0 = (arg0 as u256) * (arg1 as u256);
        (0x1::u256::min(ceil_div(v0 * v0 * (arg2 as u256), 100000000000), (100000000 as u256)) as u64)
    }

    // decompiled from Move bytecode v7
}

