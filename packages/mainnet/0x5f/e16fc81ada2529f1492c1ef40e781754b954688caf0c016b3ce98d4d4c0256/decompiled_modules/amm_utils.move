module 0x5fe16fc81ada2529f1492c1ef40e781754b954688caf0c016b3ce98d4d4c0256::amm_utils {
    public fun get_amount_in(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 1);
        assert!(arg1 > 0 && arg2 > 0, 1);
        assert!(arg2 > arg0, 1);
        0x5fe16fc81ada2529f1492c1ef40e781754b954688caf0c016b3ce98d4d4c0256::amm_math::safe_mul_div_u64_u128((arg1 as u128), (arg0 as u128) * 1000, 0x5fe16fc81ada2529f1492c1ef40e781754b954688caf0c016b3ce98d4d4c0256::amm_math::safe_mul_u64_u128(arg2 - arg0, 1000)) + 1
    }

    public fun get_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 1);
        assert!(arg1 > 0 && arg2 > 0, 1);
        let v0 = 0x5fe16fc81ada2529f1492c1ef40e781754b954688caf0c016b3ce98d4d4c0256::amm_math::safe_mul_u64_u128(arg0, 1000);
        0x5fe16fc81ada2529f1492c1ef40e781754b954688caf0c016b3ce98d4d4c0256::amm_math::safe_mul_div_u64_u128(v0, (arg2 as u128), 0x5fe16fc81ada2529f1492c1ef40e781754b954688caf0c016b3ce98d4d4c0256::amm_math::safe_mul_u64_u128(arg1, 1000) + v0)
    }

    public fun quote(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 1);
        assert!(arg1 > 0 && arg2 > 0, 1);
        0x5fe16fc81ada2529f1492c1ef40e781754b954688caf0c016b3ce98d4d4c0256::amm_math::safe_mul_div_u64(arg0, arg2, arg1)
    }

    // decompiled from Move bytecode v6
}

