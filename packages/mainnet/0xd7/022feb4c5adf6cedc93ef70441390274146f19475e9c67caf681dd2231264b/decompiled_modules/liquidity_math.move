module 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::liquidity_math {
    public fun add_delta(arg0: u128, arg1: 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i128::I128) : u128 {
        let v0 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i128::abs_u128(arg1);
        if (0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i128::is_neg(arg1)) {
            assert!(arg0 >= v0, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::error::insufficient_liquidity());
            arg0 - v0
        } else {
            assert!(v0 < 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::constants::max_u128() - arg0, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::error::insufficient_liquidity());
            arg0 + v0
        }
    }

    public fun get_amount_x_for_liquidity(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u64 {
        let (v0, v1) = sort_sqrt_prices(arg0, arg1);
        let (v2, v3) = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::math_u256::checked_shlw(0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::full_mul(arg2, v1 - v0));
        assert!(!v3, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::error::overflow());
        (0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::math_u256::div_round(v2, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::full_mul(v0, v1), arg3) as u64)
    }

    public fun get_amount_y_for_liquidity(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u64 {
        let (v0, v1) = sort_sqrt_prices(arg0, arg1);
        (0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::math_u256::div_round(0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::full_mul(arg2, v1 - v0), (0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::constants::q64() as u256), arg3) as u64)
    }

    public fun get_amounts_for_liquidity(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: bool) : (u64, u64) {
        if (arg0 <= arg1) {
            (0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::sqrt_price_math::get_amount_x_delta(arg1, arg2, arg3, arg4), 0)
        } else if (arg0 < arg2) {
            (0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::sqrt_price_math::get_amount_x_delta(arg0, arg2, arg3, arg4), 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::sqrt_price_math::get_amount_y_delta(arg1, arg0, arg3, arg4))
        } else {
            (0, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::sqrt_price_math::get_amount_y_delta(arg1, arg2, arg3, arg4))
        }
    }

    public fun get_liquidity_for_amount_x(arg0: u128, arg1: u128, arg2: u64) : u128 {
        let (v0, v1) = sort_sqrt_prices(arg0, arg1);
        0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_div_floor((arg2 as u128), 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_div_floor(v0, v1, (0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::constants::q64() as u128)), v1 - v0)
    }

    public fun get_liquidity_for_amount_y(arg0: u128, arg1: u128, arg2: u64) : u128 {
        let (v0, v1) = sort_sqrt_prices(arg0, arg1);
        0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_div_floor((arg2 as u128), (0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::constants::q64() as u128), v1 - v0)
    }

    public fun get_liquidity_for_amounts(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: u64) : u128 {
        if (arg0 <= arg1) {
            get_liquidity_for_amount_x(arg1, arg2, arg3)
        } else if (arg0 < arg2) {
            0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::min(get_liquidity_for_amount_x(arg0, arg2, arg3), get_liquidity_for_amount_y(arg1, arg0, arg4))
        } else {
            get_liquidity_for_amount_y(arg1, arg2, arg4)
        }
    }

    fun sort_sqrt_prices(arg0: u128, arg1: u128) : (u128, u128) {
        if (arg0 > arg1) {
            (arg1, arg0)
        } else {
            (arg0, arg1)
        }
    }

    // decompiled from Move bytecode v6
}

