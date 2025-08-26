module 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::dlmm_math {
    public fun calculate_amount_by_growth(arg0: u128, arg1: u128) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(arg0, arg1) / (1 << 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::constants::scale_offset() + 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::constants::scale_offset());
        assert!(v0 <= 18446744073709551615, 13906835767776247809);
        (v0 as u64)
    }

    public fun calculate_amount_in(arg0: u64, arg1: u128, arg2: bool) : u64 {
        assert!(arg1 > 0, 13906834483581812749);
        if (arg0 == 0) {
            return 0
        };
        let v0 = if (arg2) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_ceil((arg0 as u128), 1 << 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::constants::scale_offset(), arg1)
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_ceil((arg0 as u128), arg1, 1 << 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::constants::scale_offset())
        };
        assert!(v0 < 18446744073709551615, 13906834552301420559);
        (v0 as u64)
    }

    public fun calculate_amount_out(arg0: u64, arg1: u128, arg2: bool) : u64 {
        assert!(arg1 > 0, 13906834663970439181);
        if (arg0 == 0) {
            return 0
        };
        let v0 = if (arg2) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((arg0 as u128), arg1, 1 << 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::constants::scale_offset())
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((arg0 as u128), 1 << 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::constants::scale_offset(), arg1)
        };
        assert!(v0 < 18446744073709551615, 13906834732690178065);
        (v0 as u64)
    }

    public fun calculate_amounts_by_liquidity(arg0: u64, arg1: u64, arg2: u128, arg3: u128) : (u64, u64) {
        assert!(arg3 > 0, 13906835248086384659);
        assert!(arg2 <= arg3, 13906835252380696585);
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
        assert!(arg1 <= 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::constants::max_fee_rate(), 13906835480013832199);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::full_mul(arg0, arg1), ((0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::constants::fee_precision() + arg1) as u128), 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::constants::fee_precision_square());
        assert!(v0 < (arg0 as u128), 13906835518669455381);
        (v0 as u64)
    }

    public fun calculate_fee_exclusive(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 < 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::constants::fee_precision(), 13906834934552854533);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(arg0, arg1, 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::constants::fee_precision() - arg1)
    }

    public fun calculate_fee_inclusive(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::constants::fee_precision(), 13906834827178672133);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(arg0, arg1, 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::constants::fee_precision())
    }

    public fun calculate_growth_by_amount(arg0: u64, arg1: u128) : u128 {
        assert!(arg1 > 0, 13906835613158080523);
        if (arg0 == 0) {
            return 0
        };
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((arg0 as u128) << 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::constants::scale_offset(), 1 << 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::constants::scale_offset(), arg1)
    }

    public fun calculate_liquidity_by_amounts(arg0: u64, arg1: u64, arg2: u128) : u128 {
        assert!(arg2 > 0, 13906835076287299597);
        if (arg0 == 0 && arg1 == 0) {
            return 0
        };
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul((arg0 as u128), arg2) + ((arg1 as u256) << 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::constants::scale_offset());
        assert!(v0 < 340282366920938463463374607431768211455, 13906835102056448003);
        (v0 as u128)
    }

    // decompiled from Move bytecode v6
}

