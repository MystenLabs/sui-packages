module 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_utils {
    public fun get_amount_in(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 1);
        assert!(arg1 > 0 && arg2 > 0, 1);
        assert!(arg2 > arg0, 1);
        0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_math::safe_mul_div_u64_u128((arg1 as u128), (arg0 as u128) * 1000, 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_math::safe_mul_u64_u128(arg2 - arg0, 1000)) + 1
    }

    public fun get_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 1);
        assert!(arg1 > 0 && arg2 > 0, 1);
        let v0 = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_math::safe_mul_u64_u128(arg0, 1000);
        0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_math::safe_mul_div_u64_u128(v0, (arg2 as u128), 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_math::safe_mul_u64_u128(arg1, 1000) + v0)
    }

    public fun quote(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 1);
        assert!(arg1 > 0 && arg2 > 0, 1);
        0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_math::safe_mul_div_u64(arg0, arg2, arg1)
    }

    // decompiled from Move bytecode v6
}

