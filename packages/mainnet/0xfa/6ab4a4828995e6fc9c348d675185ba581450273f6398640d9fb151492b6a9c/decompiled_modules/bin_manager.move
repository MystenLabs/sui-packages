module 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::bin_manager {
    struct BinManager has store {
        bins: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::SkipList<Bin>,
    }

    struct Bin has copy, drop, store {
        reserve_x: u64,
        reserve_y: u64,
        fee_x: u64,
        fee_y: u64,
        price: u128,
        fee_growth_x: u128,
        fee_growth_y: u128,
        total_supply: u128,
    }

    public fun contains(arg0: &BinManager, arg1: u32) : bool {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<Bin>(&arg0.bins, (arg1 as u64))
    }

    public fun new(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : BinManager {
        BinManager{bins: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::new<Bin>(16, 2, arg0, arg1)}
    }

    public fun add_or_update_bin(arg0: &mut BinManager, arg1: u32, arg2: Bin) {
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<Bin>(&arg0.bins, (arg1 as u64))) {
            *0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_mut<Bin>(&mut arg0.bins, (arg1 as u64)) = arg2;
        } else {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::insert<Bin>(&mut arg0.bins, (arg1 as u64), arg2);
        };
    }

    public fun add_reserves_fees(arg0: &mut Bin, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        arg0.reserve_x = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::add_u64(arg0.reserve_x, arg1);
        arg0.reserve_y = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::add_u64(arg0.reserve_y, arg2);
        arg0.fee_x = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::add_u64(arg0.fee_x, arg3);
        arg0.fee_y = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::add_u64(arg0.fee_y, arg4);
    }

    public fun bin_details(arg0: &Bin) : (u64, u64, u64, u64, u128, u128, u128) {
        (0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::add_u64(arg0.reserve_x, arg0.fee_x), 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::add_u64(arg0.reserve_y, arg0.fee_y), arg0.reserve_x, arg0.reserve_y, arg0.fee_growth_x, arg0.fee_growth_y, arg0.total_supply)
    }

    public fun decrement_total_supply(arg0: &mut BinManager, arg1: u32, arg2: u128) : u128 {
        if (!contains(arg0, arg1)) {
            return 0
        };
        let v0 = get_bin_mut(arg0, arg1);
        assert!(v0.total_supply >= arg2, 703);
        v0.total_supply = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::sub_u128(v0.total_supply, arg2);
        v0.total_supply
    }

    public fun get_amount_out_of_bin(arg0: &Bin, arg1: u128, arg2: u128) : (u64, u64) {
        if (arg2 == 0) {
            return (0, 0)
        };
        let (v0, v1) = get_total_amounts(arg0);
        let v2 = if (v0 > 0) {
            0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::u128_to_u64(0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::mul_div_u128(arg1, (v0 as u128), arg2))
        } else {
            0
        };
        let v3 = if (v1 > 0) {
            0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::u128_to_u64(0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::mul_div_u128(arg1, (v1 as u128), arg2))
        } else {
            0
        };
        (v2, v3)
    }

    public fun get_bin(arg0: &BinManager, arg1: u32) : &Bin {
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<Bin>(&arg0.bins, (arg1 as u64)), 704);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow<Bin>(&arg0.bins, (arg1 as u64))
    }

    public fun get_bin_mut(arg0: &mut BinManager, arg1: u32) : &mut Bin {
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<Bin>(&arg0.bins, (arg1 as u64)), 704);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_mut<Bin>(&mut arg0.bins, (arg1 as u64))
    }

    public fun get_bin_reserves(arg0: &BinManager, arg1: u32) : (u64, u64) {
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<Bin>(&arg0.bins, (arg1 as u64)), 704);
        let v0 = *0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow<Bin>(&arg0.bins, (arg1 as u64));
        (v0.reserve_x, v0.reserve_y)
    }

    public fun get_composition_fees(arg0: &Bin, arg1: &0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::pair_parameter_helper::PairParameters, arg2: u16, arg3: u64, arg4: u64, arg5: u128, arg6: u128) : (u64, u64) {
        if (arg6 == 0) {
            return (0, 0)
        };
        let v0 = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::add_u128(arg5, arg6);
        let v1 = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::add_u64(0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::add_u64(arg0.reserve_x, arg0.fee_x), arg3);
        let v2 = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::add_u64(0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::add_u64(arg0.reserve_y, arg0.fee_y), arg4);
        let v3 = if (v1 > 0) {
            0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::u128_to_u64(0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::mul_div_u128(arg6, (v1 as u128), v0))
        } else {
            0
        };
        let v4 = if (v2 > 0) {
            0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::u128_to_u64(0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::mul_div_u128(arg6, (v2 as u128), v0))
        } else {
            0
        };
        if (v3 > arg3 && arg4 > v4) {
            (0, 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::fee_helper::get_composition_fee(arg4 - v4, 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::pair_parameter_helper::get_total_fee(arg1, arg2)))
        } else if (v4 > arg4 && arg3 > v3) {
            (0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::fee_helper::get_composition_fee(arg3 - v3, 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::pair_parameter_helper::get_total_fee(arg1, arg2)), 0)
        } else {
            (0, 0)
        }
    }

    public fun get_fee_growth_x(arg0: &Bin) : u128 {
        arg0.fee_growth_x
    }

    public fun get_fee_growth_y(arg0: &Bin) : u128 {
        arg0.fee_growth_y
    }

    public fun get_fees(arg0: &Bin) : (u64, u64) {
        (arg0.fee_x, arg0.fee_y)
    }

    public fun get_liquidity_from_reserves(arg0: &Bin, arg1: u128) : u128 {
        0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::q64x64::liquidity_from_amounts(arg0.reserve_x, arg0.reserve_y, arg1)
    }

    public fun get_next_non_empty_bin(arg0: &BinManager, arg1: bool, arg2: u32) : u32 {
        if (arg1) {
            let v1 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::find_next<Bin>(&arg0.bins, (arg2 as u64), false);
            if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v1)) {
                let v2 = (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v1) as u32);
                if (v2 == 4294967295) {
                    0
                } else {
                    v2
                }
            } else {
                0
            }
        } else {
            let v3 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::find_prev<Bin>(&arg0.bins, (arg2 as u64), false);
            if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v3)) {
                (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v3) as u32)
            } else {
                0
            }
        }
    }

    public fun get_price(arg0: &Bin) : u128 {
        arg0.price
    }

    public fun get_reserves(arg0: &Bin) : (u64, u64) {
        (arg0.reserve_x, arg0.reserve_y)
    }

    public fun get_shares_and_effective_amounts_in(arg0: &Bin, arg1: u64, arg2: u64, arg3: u128, arg4: u128) : (u128, u64, u64) {
        let v0 = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::q64x64::liquidity_from_amounts(arg1, arg2, arg3);
        if (v0 == 0) {
            return (0, 0, 0)
        };
        let v1 = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::q64x64::liquidity_from_amounts(arg0.reserve_x, arg0.reserve_y, arg3);
        if (v1 == 0 || arg4 == 0) {
            let v2 = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::sqrt_u128(v0);
            let v3 = v2;
            if (v2 == 0) {
                v3 = 1000;
            };
            return (v3, arg1, arg2)
        };
        let v4 = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::mul_div_u128(v0, arg4, v1);
        if (v4 == 0) {
            return (0, 0, 0)
        };
        let v5 = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::mul_div_u128(v4, v1, arg4);
        let (v6, v7) = if (v0 > v5) {
            let v8 = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::mul_div_u128(v5, (0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::constants::precision() as u128), v0);
            (0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::u128_to_u64(0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::mul_div_u128((arg1 as u128), v8, (0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::constants::precision() as u128))), 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::u128_to_u64(0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::mul_div_u128((arg2 as u128), v8, (0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::constants::precision() as u128))))
        } else {
            (arg1, arg2)
        };
        assert!(0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::q64x64::liquidity_from_amounts(0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::add_u64(arg0.reserve_x, v6), 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::add_u64(arg0.reserve_y, v7), arg3) <= 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::constants::max_liquidity_per_bin(), 702);
        (v4, v6, v7)
    }

    public fun get_swap_amounts(arg0: &Bin, arg1: &0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::pair_parameter_helper::PairParameters, arg2: u16, arg3: bool, arg4: u64, arg5: u64) : (u64, u64, u64, u64, u64, u64) {
        let v0 = arg0.price;
        let v1 = if (arg3) {
            arg0.reserve_y
        } else {
            arg0.reserve_x
        };
        if (v1 == 0) {
            return (0, 0, 0, 0, 0, 0)
        };
        let v2 = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::q64x64::max_input_for_exact_output(v1, v0, arg3);
        let v3 = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::pair_parameter_helper::get_total_fee(arg1, arg2);
        let v4 = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::fee_helper::get_fee_amount(v2, v3);
        let v5 = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::add_u64(v2, v4);
        let v6 = if (arg3) {
            arg4
        } else {
            arg5
        };
        let (v7, v8, v9) = if (v6 >= v5) {
            (v5, v1, v4)
        } else {
            let v10 = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::fee_helper::get_fee_amount_from(v6, v3);
            (v6, 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::min_u64(0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::q64x64::swap_amount_out(0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::sub_u64(v6, v10), v0, arg3), v1), v10)
        };
        let (v11, v12) = if (arg3) {
            (v7, 0)
        } else {
            (0, v7)
        };
        let (v13, v14) = if (arg3) {
            (0, v8)
        } else {
            (v8, 0)
        };
        let (v15, v16) = if (arg3) {
            (v9, 0)
        } else {
            (0, v9)
        };
        let v17 = if (arg3) {
            0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::add_u64(arg0.reserve_x, v7 - v9)
        } else {
            0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::sub_u64(arg0.reserve_x, v8)
        };
        let v18 = if (arg3) {
            0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::sub_u64(arg0.reserve_y, v8)
        } else {
            0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::add_u64(arg0.reserve_y, v7 - v9)
        };
        assert!(0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::q64x64::liquidity_from_amounts(v17, v18, v0) <= 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::constants::max_liquidity_per_bin(), 702);
        (v11, v12, v13, v14, v15, v16)
    }

    public fun get_total_amounts(arg0: &Bin) : (u64, u64) {
        (0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::add_u64(arg0.reserve_x, arg0.fee_x), 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::add_u64(arg0.reserve_y, arg0.fee_y))
    }

    public fun get_total_supply(arg0: &Bin) : u128 {
        arg0.total_supply
    }

    public fun increment_total_supply(arg0: &mut BinManager, arg1: u32, arg2: u128) : u128 {
        let v0 = get_bin_mut(arg0, arg1);
        v0.total_supply = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::add_u128(v0.total_supply, arg2);
        v0.total_supply
    }

    public fun is_empty(arg0: &Bin, arg1: bool) : bool {
        arg1 && arg0.reserve_x == 0 || arg0.reserve_y == 0
    }

    public fun new_bin(arg0: u64, arg1: u64, arg2: u128) : Bin {
        Bin{
            reserve_x    : arg0,
            reserve_y    : arg1,
            fee_x        : 0,
            fee_y        : 0,
            price        : arg2,
            fee_growth_x : 0,
            fee_growth_y : 0,
            total_supply : 0,
        }
    }

    public fun remove_bin(arg0: &mut BinManager, arg1: u32) {
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<Bin>(&arg0.bins, (arg1 as u64))) {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::remove<Bin>(&mut arg0.bins, (arg1 as u64));
        };
    }

    public fun set_fee_growth(arg0: &mut Bin, arg1: u128, arg2: u128) {
        arg0.fee_growth_x = arg1;
        arg0.fee_growth_y = arg2;
    }

    public fun subtract_reserves_and_fees(arg0: &mut Bin, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        arg0.reserve_x = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::sub_u64(arg0.reserve_x, arg1);
        arg0.reserve_y = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::sub_u64(arg0.reserve_y, arg2);
        arg0.fee_x = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::sub_u64(arg0.fee_x, arg3);
        arg0.fee_y = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::sub_u64(arg0.fee_y, arg4);
    }

    public fun update_reserves_fees(arg0: &mut Bin, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        arg0.reserve_x = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::sub_u64(0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::add_u64(arg0.reserve_x, arg1), arg2);
        arg0.reserve_y = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::sub_u64(0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::add_u64(arg0.reserve_y, arg3), arg4);
        arg0.fee_x = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::add_u64(arg0.fee_x, arg5);
        arg0.fee_y = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::add_u64(arg0.fee_y, arg6);
    }

    public fun verify_amounts(arg0: u64, arg1: u64, arg2: u32, arg3: u32) {
        if (arg3 < arg2 && arg1 > 0 || arg3 > arg2 && arg0 > 0) {
            abort 700
        };
    }

    // decompiled from Move bytecode v6
}

