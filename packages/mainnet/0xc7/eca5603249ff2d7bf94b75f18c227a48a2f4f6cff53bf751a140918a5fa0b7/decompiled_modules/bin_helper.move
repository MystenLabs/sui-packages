module 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper {
    struct BinReserves has copy, drop, store {
        reserve_x: u128,
        reserve_y: u128,
    }

    struct Amounts has copy, drop {
        amount_x: u128,
        amount_y: u128,
    }

    public fun add_amounts(arg0: &Amounts, arg1: &Amounts) : Amounts {
        Amounts{
            amount_x : arg0.amount_x + arg1.amount_x,
            amount_y : arg0.amount_y + arg1.amount_y,
        }
    }

    public fun add_reserves(arg0: &BinReserves, arg1: &BinReserves) : BinReserves {
        BinReserves{
            reserve_x : arg0.reserve_x + arg1.reserve_x,
            reserve_y : arg0.reserve_y + arg1.reserve_y,
        }
    }

    public fun amounts_to_reserves(arg0: &Amounts) : BinReserves {
        BinReserves{
            reserve_x : arg0.amount_x,
            reserve_y : arg0.amount_y,
        }
    }

    public fun get_amount_out_of_bin(arg0: &BinReserves, arg1: u256, arg2: u256) : Amounts {
        if (arg2 == 0) {
            return new_amounts(0, 0)
        };
        let v0 = if (arg0.reserve_x > 0) {
            0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::safe128(0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::uint256x256_math::mul_div_round_down(arg1, (arg0.reserve_x as u256), arg2))
        } else {
            0
        };
        let v1 = if (arg0.reserve_y > 0) {
            0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::safe128(0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::uint256x256_math::mul_div_round_down(arg1, (arg0.reserve_y as u256), arg2))
        } else {
            0
        };
        Amounts{
            amount_x : v0,
            amount_y : v1,
        }
    }

    public fun get_amounts(arg0: &BinReserves, arg1: &0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::PairParameters, arg2: u16, arg3: bool, arg4: u32, arg5: &Amounts) : (Amounts, Amounts, Amounts) {
        let v0 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::price_helper::get_price_from_id(arg4, arg2);
        let v1 = if (arg3) {
            arg0.reserve_y
        } else {
            arg0.reserve_x
        };
        if (v1 == 0) {
            return (new_amounts(0, 0), new_amounts(0, 0), new_amounts(0, 0))
        };
        let v2 = if (arg3) {
            0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::safe128(0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::uint256x256_math::shift_div_round_up((v1 as u256), 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::constants::scale_offset(), v0))
        } else {
            0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::safe128(0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::uint256x256_math::mul_shift_round_up((v1 as u256), v0, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::constants::scale_offset()))
        };
        let v3 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_total_fee(arg1, arg2);
        let v4 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::fee_helper::get_fee_amount(v2, v3);
        let v5 = v2 + v4;
        let v6 = if (arg3) {
            arg5.amount_x
        } else {
            arg5.amount_y
        };
        let (v7, v8, v9) = if (v6 >= v5) {
            (v5, v1, v4)
        } else {
            let v10 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::fee_helper::get_fee_amount_from(v6, v3);
            let v11 = if (arg3) {
                0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::safe128(0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::uint256x256_math::mul_shift_round_down(((v6 - v10) as u256), v0, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::constants::scale_offset()))
            } else {
                0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::safe128(0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::uint256x256_math::shift_div_round_down(((v6 - v10) as u256), 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::constants::scale_offset(), v0))
            };
            let v12 = if (v11 > v1) {
                v1
            } else {
                v11
            };
            (v6, v12, v10)
        };
        let (v13, v14, v15) = if (arg3) {
            (new_amounts(0, v8), new_amounts(v9, 0), new_amounts(v7, 0))
        } else {
            (new_amounts(v8, 0), new_amounts(0, v9), new_amounts(0, v7))
        };
        let v16 = v13;
        let v17 = v15;
        let v18 = amounts_to_reserves(&v17);
        let v19 = add_reserves(arg0, &v18);
        let v20 = amounts_to_reserves(&v16);
        let v21 = sub_reserves(&v19, &v20);
        assert!(get_liquidity_from_reserves(&v21, v0) <= 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::constants::max_liquidity_per_bin(), 702);
        (v17, v16, v14)
    }

    public fun get_amounts_values(arg0: &Amounts) : (u128, u128) {
        (arg0.amount_x, arg0.amount_y)
    }

    public fun get_composition_fees(arg0: &BinReserves, arg1: &0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::PairParameters, arg2: u16, arg3: &Amounts, arg4: u256, arg5: u256) : Amounts {
        if (arg5 == 0) {
            return new_amounts(0, 0)
        };
        let v0 = amounts_to_reserves(arg3);
        let v1 = add_reserves(arg0, &v0);
        let v2 = get_amount_out_of_bin(&v1, arg5, arg4 + arg5);
        if (v2.amount_x > arg3.amount_x && arg3.amount_y > v2.amount_y) {
            new_amounts(0, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::fee_helper::get_composition_fee(arg3.amount_y - v2.amount_y, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_total_fee(arg1, arg2)))
        } else if (v2.amount_y > arg3.amount_y && arg3.amount_x > v2.amount_x) {
            new_amounts(0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::fee_helper::get_composition_fee(arg3.amount_x - v2.amount_x, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_total_fee(arg1, arg2)), 0)
        } else {
            new_amounts(0, 0)
        }
    }

    public fun get_liquidity_amounts(arg0: u256, arg1: u256, arg2: u256) : u256 {
        get_liquidity_amounts_safe(arg0, arg1, arg2)
    }

    fun get_liquidity_amounts_safe(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = 0;
        if (arg0 > 0 && arg2 > 0) {
            if (arg0 <= 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::constants::max_liquidity_per_bin() / arg2) {
                v0 = arg2 * arg0;
            } else {
                v0 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::uint256x256_math::mul_div_round_down(arg2, arg0, 1);
            };
        };
        if (arg1 > 0) {
            let v1 = arg1 << 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::constants::scale_offset();
            assert!(v0 <= 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::constants::max_liquidity_per_bin() - v1, 701);
            v0 = v0 + v1;
        };
        v0
    }

    public fun get_liquidity_from_amounts(arg0: &Amounts, arg1: u256) : u256 {
        get_liquidity_amounts_safe((arg0.amount_x as u256), (arg0.amount_y as u256), arg1)
    }

    public fun get_liquidity_from_reserves(arg0: &BinReserves, arg1: u256) : u256 {
        get_liquidity_amounts_safe((arg0.reserve_x as u256), (arg0.reserve_y as u256), arg1)
    }

    public fun get_reserves(arg0: &BinReserves) : (u128, u128) {
        (arg0.reserve_x, arg0.reserve_y)
    }

    public fun get_shares_and_effective_amounts_in(arg0: &BinReserves, arg1: &Amounts, arg2: u256, arg3: u256) : (u256, Amounts) {
        let v0 = get_liquidity_amounts_safe((arg1.amount_x as u256), (arg1.amount_y as u256), arg2);
        if (v0 == 0) {
            return (0, new_amounts(0, 0))
        };
        let v1 = get_liquidity_from_reserves(arg0, arg2);
        if (v1 == 0 || arg3 == 0) {
            let v2 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::uint256x256_math::sqrt(v0);
            let v3 = v2;
            if (v2 == 0) {
                v3 = 1000;
            };
            return (v3, *arg1)
        };
        let v4 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::uint256x256_math::mul_div_round_down(v0, arg3, v1);
        if (v4 == 0) {
            return (0, new_amounts(0, 0))
        };
        let v5 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::uint256x256_math::mul_div_round_up(v4, v1, arg3);
        let v6 = arg1.amount_x;
        let v7 = arg1.amount_y;
        if (v0 > v5) {
            let v8 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::uint256x256_math::mul_div_round_down(v5, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::constants::precision(), v0);
            v6 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::safe128(0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::uint256x256_math::mul_div_round_down((arg1.amount_x as u256), v8, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::constants::precision()));
            v7 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::safe128(0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::uint256x256_math::mul_div_round_down((arg1.amount_y as u256), v8, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::constants::precision()));
        };
        let v9 = new_amounts(v6, v7);
        let v10 = amounts_to_reserves(&v9);
        let v11 = add_reserves(arg0, &v10);
        assert!(get_liquidity_from_reserves(&v11, arg2) <= 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::constants::max_liquidity_per_bin(), 702);
        (v4, v9)
    }

    public fun is_empty(arg0: &BinReserves, arg1: bool) : bool {
        arg1 && arg0.reserve_x == 0 || arg0.reserve_y == 0
    }

    public fun new_amounts(arg0: u128, arg1: u128) : Amounts {
        Amounts{
            amount_x : arg0,
            amount_y : arg1,
        }
    }

    public fun new_bin_reserves(arg0: u128, arg1: u128) : BinReserves {
        BinReserves{
            reserve_x : arg0,
            reserve_y : arg1,
        }
    }

    public fun reserves_to_amounts(arg0: &BinReserves) : Amounts {
        Amounts{
            amount_x : arg0.reserve_x,
            amount_y : arg0.reserve_y,
        }
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
        }
    }

    public fun verify_amounts(arg0: &Amounts, arg1: u32, arg2: u32) {
        if (arg2 < arg1 && arg0.amount_y > 0 || arg2 > arg1 && arg0.amount_x > 0) {
            abort 700
        };
    }

    // decompiled from Move bytecode v6
}

