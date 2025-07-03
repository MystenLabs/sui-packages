module 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::bin_helper {
    struct BinReserves has copy, drop, store {
        reserve_x: u64,
        reserve_y: u64,
        fee_x: u64,
        fee_y: u64,
    }

    struct Amounts has copy, drop {
        amount_x: u64,
        amount_y: u64,
    }

    struct BinWithRewards has copy, drop, store {
        reserves: BinReserves,
        rewards_growth: vector<u128>,
    }

    public fun add_amounts(arg0: &Amounts, arg1: &Amounts) : Amounts {
        Amounts{
            amount_x : 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::add_u64(arg0.amount_x, arg1.amount_x),
            amount_y : 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::add_u64(arg0.amount_y, arg1.amount_y),
        }
    }

    public fun add_fees_to_bin(arg0: &mut BinReserves, arg1: u64, arg2: u64) {
        arg0.fee_x = 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::add_u64(arg0.fee_x, arg1);
        arg0.fee_y = 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::add_u64(arg0.fee_y, arg2);
    }

    public fun add_reserves(arg0: &BinReserves, arg1: &BinReserves) : BinReserves {
        BinReserves{
            reserve_x : 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::add_u64(arg0.reserve_x, arg1.reserve_x),
            reserve_y : 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::add_u64(arg0.reserve_y, arg1.reserve_y),
            fee_x     : arg0.fee_x,
            fee_y     : arg0.fee_y,
        }
    }

    public fun add_to_bin(arg0: &BinReserves, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : BinReserves {
        BinReserves{
            reserve_x : 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::add_u64(arg0.reserve_x, arg1),
            reserve_y : 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::add_u64(arg0.reserve_y, arg2),
            fee_x     : 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::add_u64(arg0.fee_x, arg3),
            fee_y     : 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::add_u64(arg0.fee_y, arg4),
        }
    }

    public fun amounts_to_reserves(arg0: &Amounts) : BinReserves {
        BinReserves{
            reserve_x : arg0.amount_x,
            reserve_y : arg0.amount_y,
            fee_x     : 0,
            fee_y     : 0,
        }
    }

    public fun calculate_bin_rewards_growth(arg0: &vector<u128>, arg1: &vector<u128>) : vector<u128> {
        let v0 = 0x1::vector::empty<u128>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u128>(arg1)) {
            let v2 = if (v1 < 0x1::vector::length<u128>(arg0)) {
                *0x1::vector::borrow<u128>(arg0, v1)
            } else {
                0
            };
            0x1::vector::push_back<u128>(&mut v0, 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::add_u128(v2, *0x1::vector::borrow<u128>(arg1, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun collect_fees_from_bin(arg0: &mut BinReserves) : (u64, u64) {
        arg0.fee_x = 0;
        arg0.fee_y = 0;
        (arg0.fee_x, arg0.fee_y)
    }

    public fun create_from_reserves_with_arithmetic(arg0: &BinReserves, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : BinReserves {
        let (v0, v1) = get_reserves(arg0);
        let (v2, v3) = get_fees(arg0);
        BinReserves{
            reserve_x : 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::sub_u64(0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::add_u64(v0, arg1), arg2),
            reserve_y : 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::sub_u64(0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::add_u64(v1, arg3), arg4),
            fee_x     : 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::add_u64(v2, arg5),
            fee_y     : 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::add_u64(v3, arg6),
        }
    }

    public fun get_amount_out_of_bin(arg0: &BinReserves, arg1: u128, arg2: u128) : Amounts {
        if (arg2 == 0) {
            return new_amounts(0, 0)
        };
        let (v0, v1) = get_total_amounts(arg0);
        let v2 = if (v0 > 0) {
            0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::u128_to_u64(0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::mul_div_u128(arg1, (v0 as u128), arg2))
        } else {
            0
        };
        let v3 = if (v1 > 0) {
            0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::u128_to_u64(0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::mul_div_u128(arg1, (v1 as u128), arg2))
        } else {
            0
        };
        new_amounts(v2, v3)
    }

    public fun get_amounts(arg0: &BinReserves, arg1: &0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::pair_parameter_helper::PairParameters, arg2: u16, arg3: bool, arg4: u32, arg5: &Amounts) : (Amounts, Amounts, Amounts) {
        let v0 = 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::price_helper::get_price_from_id(arg4, arg2);
        let v1 = if (arg3) {
            arg0.reserve_y
        } else {
            arg0.reserve_x
        };
        if (v1 == 0) {
            return (new_amounts(0, 0), new_amounts(0, 0), new_amounts(0, 0))
        };
        let v2 = if (arg3) {
            0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::q40x88::get_integer(0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::q40x88::div(0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::q40x88::from_integer(v1), v0))
        } else {
            0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::q40x88::get_integer(0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::q40x88::mul(0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::q40x88::from_integer(v1), v0))
        };
        let v3 = 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::pair_parameter_helper::get_total_fee(arg1, arg2);
        let v4 = 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::fee_helper::get_fee_amount(v2, v3);
        let v5 = 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::add_u64(v2, v4);
        let v6 = if (arg3) {
            arg5.amount_x
        } else {
            arg5.amount_y
        };
        let (v7, v8, v9) = if (v6 >= v5) {
            (v5, v1, v4)
        } else {
            let v10 = 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::fee_helper::get_fee_amount_from(v6, v3);
            let v11 = if (arg3) {
                0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::q40x88::get_integer(0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::q40x88::mul(0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::q40x88::from_integer(0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::sub_u64(v6, v10)), v0))
            } else {
                0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::q40x88::get_integer(0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::q40x88::div(0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::q40x88::from_integer(0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::sub_u64(v6, v10)), v0))
            };
            (v6, 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::min_u64(v11, v1), v10)
        };
        let (v12, v13, v14) = if (arg3) {
            (new_amounts(v9, 0), new_amounts(v7, 0), new_amounts(0, v8))
        } else {
            (new_amounts(0, v9), new_amounts(0, v7), new_amounts(v8, 0))
        };
        let v15 = v14;
        let v16 = if (arg3) {
            new_amounts(v7 - v9, 0)
        } else {
            new_amounts(0, v7 - v9)
        };
        let v17 = v16;
        let v18 = amounts_to_reserves(&v17);
        let v19 = amounts_to_reserves(&v15);
        let v20 = add_reserves(arg0, &v18);
        let v21 = sub_reserves(&v20, &v19);
        assert!(get_liquidity_from_reserves(&v21, v0) <= 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::constants::max_liquidity_per_bin(), 702);
        (v13, v15, v12)
    }

    public fun get_amounts_values(arg0: &Amounts) : (u64, u64) {
        (arg0.amount_x, arg0.amount_y)
    }

    public fun get_bin_reserve_components(arg0: &BinReserves) : (u64, u64, u64, u64) {
        (arg0.reserve_x, arg0.reserve_y, arg0.fee_x, arg0.fee_y)
    }

    public fun get_bin_reserves(arg0: &BinWithRewards) : &BinReserves {
        &arg0.reserves
    }

    public fun get_bin_rewards_growth(arg0: &BinWithRewards) : &vector<u128> {
        &arg0.rewards_growth
    }

    public fun get_composition_fees(arg0: &BinReserves, arg1: &0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::pair_parameter_helper::PairParameters, arg2: u16, arg3: &Amounts, arg4: u128, arg5: u128) : Amounts {
        if (arg5 == 0) {
            return new_amounts(0, 0)
        };
        let v0 = amounts_to_reserves(arg3);
        let v1 = add_reserves(arg0, &v0);
        let v2 = get_amount_out_of_bin(&v1, arg5, 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::add_u128(arg4, arg5));
        if (v2.amount_x > arg3.amount_x && arg3.amount_y > v2.amount_y) {
            new_amounts(0, 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::fee_helper::get_composition_fee(arg3.amount_y - v2.amount_y, 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::pair_parameter_helper::get_total_fee(arg1, arg2)))
        } else if (v2.amount_y > arg3.amount_y && arg3.amount_x > v2.amount_x) {
            new_amounts(0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::fee_helper::get_composition_fee(arg3.amount_x - v2.amount_x, 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::pair_parameter_helper::get_total_fee(arg1, arg2)), 0)
        } else {
            new_amounts(0, 0)
        }
    }

    public fun get_fees(arg0: &BinReserves) : (u64, u64) {
        (arg0.fee_x, arg0.fee_y)
    }

    fun get_liquidity_amounts(arg0: u64, arg1: u64, arg2: u128) : u128 {
        let v0 = 0;
        if (arg0 > 0 && arg2 > 0) {
            v0 = 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::q40x88::mul(arg2, 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::q40x88::from_integer(arg0));
        };
        if (arg1 > 0) {
            v0 = 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::q40x88::add(v0, 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::q40x88::from_integer(arg1));
        };
        (0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::q40x88::get_integer(v0) as u128)
    }

    public fun get_liquidity_from_amounts(arg0: &Amounts, arg1: u128) : u128 {
        get_liquidity_amounts(arg0.amount_x, arg0.amount_y, arg1)
    }

    public fun get_liquidity_from_reserves(arg0: &BinReserves, arg1: u128) : u128 {
        get_liquidity_amounts(arg0.reserve_x, arg0.reserve_y, arg1)
    }

    public fun get_reserves(arg0: &BinReserves) : (u64, u64) {
        (arg0.reserve_x, arg0.reserve_y)
    }

    public fun get_reward_growth_at(arg0: &vector<u128>, arg1: u64) : u128 {
        if (arg1 < 0x1::vector::length<u128>(arg0)) {
            *0x1::vector::borrow<u128>(arg0, arg1)
        } else {
            0
        }
    }

    public fun get_shares_and_effective_amounts_in(arg0: &BinReserves, arg1: &Amounts, arg2: u128, arg3: u128) : (u128, Amounts) {
        let v0 = get_liquidity_amounts(arg1.amount_x, arg1.amount_y, arg2);
        if (v0 == 0) {
            return (0, new_amounts(0, 0))
        };
        let v1 = get_liquidity_from_reserves(arg0, arg2);
        if (v1 == 0 || arg3 == 0) {
            let v2 = sqrt_u128(v0);
            let v3 = v2;
            if (v2 == 0) {
                v3 = 1000;
            };
            return (v3, *arg1)
        };
        let v4 = 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::mul_div_u128(v0, arg3, v1);
        if (v4 == 0) {
            return (0, new_amounts(0, 0))
        };
        let v5 = 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::mul_div_u128(v4, v1, arg3);
        let v6 = if (v0 > v5) {
            let v7 = 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::mul_div_u128(v5, (0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::constants::precision() as u128), v0);
            new_amounts(0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::u128_to_u64(0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::mul_div_u128((arg1.amount_x as u128), v7, (0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::constants::precision() as u128))), 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::u128_to_u64(0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::mul_div_u128((arg1.amount_y as u128), v7, (0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::constants::precision() as u128))))
        } else {
            *arg1
        };
        let v8 = v6;
        let v9 = amounts_to_reserves(&v8);
        let v10 = add_reserves(arg0, &v9);
        assert!(get_liquidity_from_reserves(&v10, arg2) <= 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::constants::max_liquidity_per_bin(), 702);
        (v4, v8)
    }

    public fun get_total_amounts(arg0: &BinReserves) : (u64, u64) {
        (0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::add_u64(arg0.reserve_x, arg0.fee_x), 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::add_u64(arg0.reserve_y, arg0.fee_y))
    }

    public fun is_empty(arg0: &BinReserves, arg1: bool) : bool {
        arg1 && arg0.reserve_x == 0 || arg0.reserve_y == 0
    }

    public fun new_amounts(arg0: u64, arg1: u64) : Amounts {
        Amounts{
            amount_x : arg0,
            amount_y : arg1,
        }
    }

    public fun new_bin_reserves(arg0: u64, arg1: u64) : BinReserves {
        BinReserves{
            reserve_x : arg0,
            reserve_y : arg1,
            fee_x     : 0,
            fee_y     : 0,
        }
    }

    public fun new_bin_reserves_with_fees(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : BinReserves {
        BinReserves{
            reserve_x : arg0,
            reserve_y : arg1,
            fee_x     : arg2,
            fee_y     : arg3,
        }
    }

    public fun new_bin_with_rewards(arg0: BinReserves, arg1: vector<u128>) : BinWithRewards {
        BinWithRewards{
            reserves       : arg0,
            rewards_growth : arg1,
        }
    }

    public fun reserves_to_amounts(arg0: &BinReserves) : Amounts {
        Amounts{
            amount_x : arg0.reserve_x,
            amount_y : arg0.reserve_y,
        }
    }

    fun sqrt_u128(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        if (arg0 <= 3) {
            return 1
        };
        let v0 = 1 << (0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::bit_math::most_significant_bit_u128(arg0) + 1) / 2;
        let v1 = (arg0 / v0 + v0) / 2;
        while (v1 < v0) {
            let v2 = arg0 / v1 + v1;
            v1 = v2 / 2;
        };
        v0
    }

    public fun sub_amounts(arg0: &Amounts, arg1: &Amounts) : Amounts {
        assert!(arg0.amount_x >= arg1.amount_x && arg0.amount_y >= arg1.amount_y, 703);
        Amounts{
            amount_x : arg0.amount_x - arg1.amount_x,
            amount_y : arg0.amount_y - arg1.amount_y,
        }
    }

    public fun sub_reserves(arg0: &BinReserves, arg1: &BinReserves) : BinReserves {
        assert!(arg0.reserve_x >= arg1.reserve_x && arg0.reserve_y >= arg1.reserve_y, 703);
        BinReserves{
            reserve_x : arg0.reserve_x - arg1.reserve_x,
            reserve_y : arg0.reserve_y - arg1.reserve_y,
            fee_x     : arg0.fee_x,
            fee_y     : arg0.fee_y,
        }
    }

    public fun update_bin_reserves(arg0: &BinReserves, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : BinReserves {
        BinReserves{
            reserve_x : 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::add_u64(arg0.reserve_x, arg1),
            reserve_y : 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::add_u64(arg0.reserve_y, arg2),
            fee_x     : 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::add_u64(arg0.fee_x, arg3),
            fee_y     : 0xe8bbfc18b792134b9bf02c9fd65e254b5da25bc221334c07c24aefd3be776e99::safe_math::add_u64(arg0.fee_y, arg4),
        }
    }

    public fun update_bin_rewards_growth(arg0: &mut BinWithRewards, arg1: vector<u128>) {
        arg0.rewards_growth = arg1;
    }

    public fun update_reserves(arg0: &BinReserves, arg1: u64, arg2: u64) : BinReserves {
        BinReserves{
            reserve_x : arg1,
            reserve_y : arg2,
            fee_x     : arg0.fee_x,
            fee_y     : arg0.fee_y,
        }
    }

    public fun verify_amounts(arg0: &Amounts, arg1: u32, arg2: u32) {
        if (arg2 < arg1 && arg0.amount_y > 0 || arg2 > arg1 && arg0.amount_x > 0) {
            abort 700
        };
    }

    // decompiled from Move bytecode v6
}

