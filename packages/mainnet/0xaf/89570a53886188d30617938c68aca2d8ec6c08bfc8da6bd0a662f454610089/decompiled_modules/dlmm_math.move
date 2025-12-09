module 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math {
    public fun calculate_amount_by_growth(arg0: u128, arg1: u128) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(arg0, arg1) / 340282366920938463463374607431768211456;
        assert!(v0 <= 18446744073709551615, 13906835772071215105);
        (v0 as u64)
    }

    public fun calculate_amount_in(arg0: u64, arg1: u128, arg2: bool) : u64 {
        assert!(arg1 > 0, 13906834487876780045);
        if (arg0 == 0) {
            return 0
        };
        let v0 = if (arg2) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_ceil((arg0 as u128), 18446744073709551616, arg1)
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_ceil((arg0 as u128), arg1, 18446744073709551616)
        };
        assert!(v0 < 18446744073709551615, 13906834556596387855);
        (v0 as u64)
    }

    public fun calculate_amount_out(arg0: u64, arg1: u128, arg2: bool) : u64 {
        assert!(arg1 > 0, 13906834668265406477);
        if (arg0 == 0) {
            return 0
        };
        let v0 = if (arg2) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((arg0 as u128), arg1, 18446744073709551616)
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((arg0 as u128), 18446744073709551616, arg1)
        };
        assert!(v0 < 18446744073709551615, 13906834736985145361);
        (v0 as u64)
    }

    public fun calculate_amounts_by_liquidity(arg0: u64, arg1: u64, arg2: u128, arg3: u128) : (u64, u64) {
        assert!(arg3 > 0, 13906835252381351955);
        assert!(arg2 <= arg3, 13906835256675663881);
        if (arg2 == 0) {
            return (0, 0)
        };
        let v0 = if (arg0 == 0) {
            0
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((arg0 as u128), arg2, arg3)
        };
        let v1 = if (arg1 == 0) {
            0
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((arg1 as u128), arg2, arg3)
        };
        ((v0 as u64), (v1 as u64))
    }

    public fun calculate_composition_fee(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 100000000, 13906835484308799495);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_round(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::full_mul(arg0, arg1), ((1000000000 + arg1) as u128), 1000000000000000000);
        assert!(v0 < (arg0 as u128), 13906835522964422677);
        (v0 as u64)
    }

    public fun calculate_fee_exclusive(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 < 1000000000, 13906834938847821829);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(arg0, arg1, 1000000000 - arg1)
    }

    public fun calculate_fee_inclusive(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 1000000000, 13906834831473639429);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(arg0, arg1, 1000000000)
    }

    public fun calculate_growth_by_amount(arg0: u64, arg1: u128) : u128 {
        assert!(arg1 > 0, 13906835617453047819);
        if (arg0 == 0) {
            return 0
        };
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((arg0 as u128) << 64, 18446744073709551616, arg1)
    }

    public fun calculate_liquidity_by_amounts(arg0: u64, arg1: u64, arg2: u128) : u128 {
        assert!(arg2 > 0, 13906835080582266893);
        if (arg0 == 0 && arg1 == 0) {
            return 0
        };
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul((arg0 as u128), arg2) + ((arg1 as u256) << 64);
        assert!(v0 < 340282366920938463463374607431768211455, 13906835106351415299);
        (v0 as u128)
    }

    // decompiled from Move bytecode v6
}

