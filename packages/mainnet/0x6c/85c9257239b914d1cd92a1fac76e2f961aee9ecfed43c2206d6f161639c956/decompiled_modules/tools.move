module 0x6c85c9257239b914d1cd92a1fac76e2f961aee9ecfed43c2206d6f161639c956::tools {
    public fun calc_optimal_values(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64) {
        if (arg4 == 0 && arg5 == 0) {
            return (arg0, arg1)
        };
        let v0 = 0x6c85c9257239b914d1cd92a1fac76e2f961aee9ecfed43c2206d6f161639c956::maths::mul_div(arg0, arg5, arg4);
        if (v0 <= arg1) {
            assert!(v0 >= arg3, 705);
            return (arg0, v0)
        };
        let v1 = 0x6c85c9257239b914d1cd92a1fac76e2f961aee9ecfed43c2206d6f161639c956::maths::mul_div(arg1, arg4, arg5);
        assert!(v1 <= arg0, 706);
        assert!(v1 >= arg2, 704);
        (v1, arg1)
    }

    public fun calculate_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 701);
        assert!(arg0 > 0 && arg1 > 0, 702);
        (((arg2 as u128) * (arg1 as u128) / ((arg0 as u128) + (arg2 as u128))) as u64)
    }

    public fun check_reserve_is_increased(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!((arg0 as u128) * (arg1 as u128) < (arg2 as u128) * (arg3 as u128), 703);
    }

    public fun get_fee(arg0: u64, arg1: u32, arg2: u32) : u64 {
        0x6c85c9257239b914d1cd92a1fac76e2f961aee9ecfed43c2206d6f161639c956::maths::mul_div(arg0, (arg1 as u64), (arg2 as u64))
    }

    // decompiled from Move bytecode v6
}

