module 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::position {
    struct Position has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        lower_tick: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32,
        upper_tick: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32,
        fee_rate: u64,
        liquidity: u128,
        fee_growth_coin_a: u128,
        fee_growth_coin_b: u128,
        token_a_owed: u64,
        token_b_owed: u64,
    }

    public fun new(arg0: 0x2::object::ID, arg1: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32, arg2: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Position {
        Position{
            id                : 0x2::object::new(arg4),
            pool_id           : arg0,
            lower_tick        : arg1,
            upper_tick        : arg2,
            fee_rate          : arg3,
            liquidity         : 0,
            fee_growth_coin_a : 0,
            fee_growth_coin_b : 0,
            token_a_owed      : 0,
            token_b_owed      : 0,
        }
    }

    public fun close_position(arg0: Position, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.liquidity == 0, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::errors::non_empty_position());
        let Position {
            id                : v0,
            pool_id           : v1,
            lower_tick        : v2,
            upper_tick        : v3,
            fee_rate          : _,
            liquidity         : _,
            fee_growth_coin_a : _,
            fee_growth_coin_b : _,
            token_a_owed      : _,
            token_b_owed      : _,
        } = arg0;
        let v10 = v0;
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::events::emit_position_close_event(0x2::tx_context::sender(arg1), v1, 0x2::object::uid_to_inner(&v10), v2, v3);
        0x2::object::delete(v10);
    }

    public fun liquidity(arg0: &Position) : u128 {
        arg0.liquidity
    }

    public fun lower_tick(arg0: &Position) : 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32 {
        arg0.lower_tick
    }

    public(friend) fun update(arg0: &mut Position, arg1: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i128::I128, arg2: u128, arg3: u128) {
        let v0 = if (0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i128::eq(arg1, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i128::zero())) {
            assert!(arg0.liquidity > 0, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::errors::insufficient_liquidity());
            arg0.liquidity
        } else {
            0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::liquidity_math::add_delta(arg0.liquidity, arg1)
        };
        let v1 = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::full_math_u128::mul_div_floor(0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::math_u128::wrapping_sub(arg2, arg0.fee_growth_coin_a), arg0.liquidity, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::constants::q64());
        let v2 = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::full_math_u128::mul_div_floor(0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::math_u128::wrapping_sub(arg3, arg0.fee_growth_coin_b), arg0.liquidity, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::constants::q64());
        assert!(v1 <= (0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::constants::max_u64() as u128) && v2 <= (0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::constants::max_u64() as u128), 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::errors::invalid_fee_growth());
        assert!(0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::math_u64::add_check(arg0.token_a_owed, (v1 as u64)) && 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::math_u64::add_check(arg0.token_b_owed, (v2 as u64)), 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::errors::add_check_failed());
        arg0.liquidity = v0;
        arg0.fee_growth_coin_a = arg2;
        arg0.fee_growth_coin_b = arg3;
        arg0.token_a_owed = arg0.token_a_owed + (v1 as u64);
        arg0.token_b_owed = arg0.token_b_owed + (v2 as u64);
    }

    public fun upper_tick(arg0: &Position) : 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32 {
        arg0.upper_tick
    }

    // decompiled from Move bytecode v6
}

