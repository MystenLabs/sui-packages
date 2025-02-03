module 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::position {
    struct Position has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        lower_tick: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32,
        upper_tick: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32,
        fee_rate: u64,
        liquidity: u128,
        fee_growth_coin_a: u128,
        fee_growth_coin_b: u128,
        token_a_fee: u64,
        token_b_fee: u64,
    }

    public fun new(arg0: 0x2::object::ID, arg1: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32, arg2: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Position {
        Position{
            id                : 0x2::object::new(arg4),
            pool_id           : arg0,
            lower_tick        : arg1,
            upper_tick        : arg2,
            fee_rate          : arg3,
            liquidity         : 0,
            fee_growth_coin_a : 0,
            fee_growth_coin_b : 0,
            token_a_fee       : 0,
            token_b_fee       : 0,
        }
    }

    public fun close_position(arg0: Position) {
        assert!(arg0.liquidity == 0, 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::errors::non_empty_position());
        let Position {
            id                : v0,
            pool_id           : _,
            lower_tick        : _,
            upper_tick        : _,
            fee_rate          : _,
            liquidity         : _,
            fee_growth_coin_a : _,
            fee_growth_coin_b : _,
            token_a_fee       : _,
            token_b_fee       : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_accrued_fee(arg0: &Position) : (u64, u64) {
        (arg0.token_a_fee, arg0.token_b_fee)
    }

    public fun liquidity(arg0: &Position) : u128 {
        arg0.liquidity
    }

    public fun lower_tick(arg0: &Position) : 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32 {
        arg0.lower_tick
    }

    public fun pool_id(arg0: &Position) : 0x2::object::ID {
        arg0.pool_id
    }

    public(friend) fun set_fee_amounts(arg0: &mut Position, arg1: u64, arg2: u64) {
        arg0.token_a_fee = arg1;
        arg0.token_b_fee = arg2;
    }

    public(friend) fun update(arg0: &mut Position, arg1: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i128::I128, arg2: u128, arg3: u128) {
        let v0 = if (0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i128::eq(arg1, 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i128::zero())) {
            assert!(arg0.liquidity > 0, 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::errors::insufficient_liquidity());
            arg0.liquidity
        } else {
            0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::liquidity_math::add_delta(arg0.liquidity, arg1)
        };
        let v1 = 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::full_math_u128::mul_div_floor(0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::math_u128::wrapping_sub(arg2, arg0.fee_growth_coin_a), arg0.liquidity, 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::constants::q64());
        let v2 = 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::full_math_u128::mul_div_floor(0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::math_u128::wrapping_sub(arg3, arg0.fee_growth_coin_b), arg0.liquidity, 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::constants::q64());
        assert!(v1 <= (0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::constants::max_u64() as u128) && v2 <= (0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::constants::max_u64() as u128), 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::errors::invalid_fee_growth());
        assert!(0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::math_u64::add_check(arg0.token_a_fee, (v1 as u64)) && 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::math_u64::add_check(arg0.token_b_fee, (v2 as u64)), 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::errors::add_check_failed());
        arg0.liquidity = v0;
        arg0.fee_growth_coin_a = arg2;
        arg0.fee_growth_coin_b = arg3;
        arg0.token_a_fee = arg0.token_a_fee + (v1 as u64);
        arg0.token_b_fee = arg0.token_b_fee + (v2 as u64);
    }

    public fun upper_tick(arg0: &Position) : 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i32::I32 {
        arg0.upper_tick
    }

    // decompiled from Move bytecode v6
}

