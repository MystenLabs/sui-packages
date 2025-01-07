module 0xbb735479c1ac4adff867904bc1f913d48650a8c2afc08495064a2f0890da92a1::amm_utils {
    public fun get_amount_in(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        assert!(arg0 > 0, 1);
        assert!(arg1 > 0 && arg2 > 0, 1);
        assert!(arg3 > 0 && arg4 > 0, 1);
        assert!(arg4 > arg3, 1);
        assert!(arg2 > arg0, 1);
        0xbb735479c1ac4adff867904bc1f913d48650a8c2afc08495064a2f0890da92a1::amm_math::safe_mul_div_u64(arg0 * arg4, arg1, (arg2 - arg0) * (arg4 - arg3)) + 1
    }

    public fun get_amount_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        assert!(arg0 > 0, 1);
        assert!(arg1 > 0 && arg2 > 0, 1);
        assert!(arg3 > 0 && arg4 > 0, 1);
        assert!(arg4 > arg3, 1);
        let v0 = arg0 * (arg4 - arg3);
        0xbb735479c1ac4adff867904bc1f913d48650a8c2afc08495064a2f0890da92a1::amm_math::safe_mul_div_u64(v0, arg2, arg1 * arg4 + v0)
    }

    public fun quote(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 1);
        assert!(arg1 > 0 && arg2 > 0, 1);
        0xbb735479c1ac4adff867904bc1f913d48650a8c2afc08495064a2f0890da92a1::amm_math::safe_mul_div_u64(arg0, arg2, arg1)
    }

    // decompiled from Move bytecode v6
}

