module 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_math {
    public(friend) fun assert_valid_coin_ratio(arg0: u64) {
        assert!(arg0 > 0, 1);
    }

    public(friend) fun assert_valid_token_scale(arg0: u64) {
        assert!(arg0 > 0, 0);
    }

    public(friend) fun checked_add(arg0: u64, arg1: u64) : u64 {
        checked_u256_to_u64((arg0 as u256) + (arg1 as u256))
    }

    fun checked_add_u256(arg0: u256, arg1: u256) : u256 {
        assert!(arg0 <= max_u256() - arg1, 3);
        arg0 + arg1
    }

    fun checked_mul(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0 || arg1 == 0) {
            0
        } else {
            assert!(arg0 <= max_u256() / arg1, 3);
            arg0 * arg1
        }
    }

    public(friend) fun checked_u256_to_u64(arg0: u256) : u64 {
        assert!(arg0 <= max_u64(), 5);
        (arg0 as u64)
    }

    public(friend) fun decimal_scale(arg0: u8) : u256 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = checked_mul(v0, 10);
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun linear_accrued(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 2);
        mul_div_floor_to_u64((arg0 as u256), (arg1 as u256), (arg2 as u256))
    }

    fun max_u256() : u256 {
        115792089237316195423570985008687907853269984665640564039457584007913129639935
    }

    fun max_u64() : u256 {
        18446744073709551615
    }

    public(friend) fun mul_div_ceil_to_u64(arg0: u256, arg1: u256, arg2: u256) : u64 {
        assert!(arg2 > 0, 2);
        let v0 = checked_mul(arg0, arg1);
        let v1 = if (v0 % arg2 == 0) {
            v0 / arg2
        } else {
            checked_add_u256(v0 / arg2, 1)
        };
        checked_u256_to_u64(v1)
    }

    public(friend) fun mul_div_floor(arg0: u256, arg1: u256, arg2: u256) : u256 {
        assert!(arg2 > 0, 2);
        checked_mul(arg0, arg1) / arg2
    }

    public(friend) fun mul_div_floor_to_u64(arg0: u256, arg1: u256, arg2: u256) : u64 {
        checked_u256_to_u64(mul_div_floor(arg0, arg1, arg2))
    }

    public(friend) fun points_to_coin_floor(arg0: u64, arg1: u64) : (u64, u64, u64) {
        assert_valid_coin_ratio(arg1);
        let v0 = arg0 / arg1;
        let v1 = checked_u256_to_u64(checked_mul((v0 as u256), (arg1 as u256)));
        (v0, v1, arg0 - v1)
    }

    public(friend) fun points_to_token_amount(arg0: u64, arg1: u64) : u64 {
        assert_valid_token_scale(arg1);
        checked_u256_to_u64(checked_mul((arg0 as u256), (arg1 as u256)))
    }

    public(friend) fun token_amount_to_coin_exact(arg0: u64, arg1: u64, arg2: u64) : (u64, u64) {
        assert_valid_token_scale(arg1);
        assert_valid_coin_ratio(arg2);
        let v0 = (arg0 as u256);
        let v1 = checked_u256_to_u64(checked_mul((arg2 as u256), (arg1 as u256)));
        assert!(v0 % (v1 as u256) == 0, 4);
        (checked_u256_to_u64(v0 / (v1 as u256)), v1)
    }

    public(friend) fun token_amount_to_points_exact(arg0: u64, arg1: u64) : u64 {
        assert_valid_token_scale(arg1);
        assert!(arg0 % arg1 == 0, 4);
        arg0 / arg1
    }

    // decompiled from Move bytecode v7
}

