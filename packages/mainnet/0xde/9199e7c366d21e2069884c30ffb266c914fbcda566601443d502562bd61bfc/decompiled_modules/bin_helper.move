module 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::bin_helper {
    struct BinManager has store {
        bin_step: u16,
        bins: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::SkipList<BinReserves>,
    }

    struct BinReserves has copy, drop, store {
        reserve_x: u64,
        reserve_y: u64,
        fee_x: u64,
        fee_y: u64,
        price: u128,
        fee_growth_x: u128,
        fee_growth_y: u128,
        rewards_growth: vector<u128>,
        liquidity: u128,
        last_update_time: u64,
    }

    struct Amounts has copy, drop {
        amount_x: u64,
        amount_y: u64,
    }

    struct NextNonEmptyBinQueried has copy, drop {
        swap_for_y: bool,
        id: u32,
        next_id: u32,
    }

    public fun contains(arg0: &BinManager, arg1: u32) : bool {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<BinReserves>(&arg0.bins, (arg1 as u64))
    }

    public fun new(arg0: u16, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : BinManager {
        BinManager{
            bin_step : arg0,
            bins     : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::new<BinReserves>(16, 2, arg1, arg2),
        }
    }

    public fun add_amounts(arg0: &Amounts, arg1: &Amounts) : Amounts {
        Amounts{
            amount_x : 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::add_u64(arg0.amount_x, arg1.amount_x),
            amount_y : 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::add_u64(arg0.amount_y, arg1.amount_y),
        }
    }

    public(friend) fun add_or_update_bin(arg0: &mut BinManager, arg1: u32, arg2: BinReserves) {
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<BinReserves>(&arg0.bins, (arg1 as u64))) {
            *0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_mut<BinReserves>(&mut arg0.bins, (arg1 as u64)) = arg2;
        } else {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::insert<BinReserves>(&mut arg0.bins, (arg1 as u64), arg2);
        };
    }

    fun add_reserves(arg0: &BinReserves, arg1: &BinReserves) : BinReserves {
        BinReserves{
            reserve_x        : 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::add_u64(arg0.reserve_x, arg1.reserve_x),
            reserve_y        : 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::add_u64(arg0.reserve_y, arg1.reserve_y),
            fee_x            : arg0.fee_x,
            fee_y            : arg0.fee_y,
            price            : arg0.price,
            fee_growth_x     : arg0.fee_growth_x,
            fee_growth_y     : arg0.fee_growth_y,
            rewards_growth   : arg0.rewards_growth,
            liquidity        : arg0.liquidity,
            last_update_time : arg0.last_update_time,
        }
    }

    public fun add_to_reserves(arg0: &mut BinReserves, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        arg0.reserve_x = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::add_u64(arg0.reserve_x, arg1);
        arg0.reserve_y = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::add_u64(arg0.reserve_y, arg2);
        arg0.fee_x = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::add_u64(arg0.fee_x, arg3);
        arg0.fee_y = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::add_u64(arg0.fee_y, arg4);
    }

    fun amounts_to_reserves(arg0: &Amounts) : BinReserves {
        BinReserves{
            reserve_x        : arg0.amount_x,
            reserve_y        : arg0.amount_y,
            fee_x            : 0,
            fee_y            : 0,
            price            : 0,
            fee_growth_x     : 0,
            fee_growth_y     : 0,
            rewards_growth   : 0x1::vector::empty<u128>(),
            liquidity        : 0,
            last_update_time : 0,
        }
    }

    public fun get_amount_out_of_bin(arg0: &BinReserves, arg1: u128, arg2: u128) : Amounts {
        if (arg2 == 0) {
            return new_amounts(0, 0)
        };
        let (v0, v1) = get_total_amounts(arg0);
        let v2 = if (v0 > 0) {
            0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::u128_to_u64(0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::mul_div_u128(arg1, (v0 as u128), arg2))
        } else {
            0
        };
        let v3 = if (v1 > 0) {
            0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::u128_to_u64(0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::mul_div_u128(arg1, (v1 as u128), arg2))
        } else {
            0
        };
        new_amounts(v2, v3)
    }

    public fun get_amounts(arg0: &BinReserves, arg1: &0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::pair_parameter_helper::PairParameters, arg2: u16, arg3: bool, arg4: u32, arg5: &Amounts) : (Amounts, Amounts, Amounts) {
        let v0 = arg0.price;
        let v1 = if (arg3) {
            arg0.reserve_y
        } else {
            arg0.reserve_x
        };
        if (v1 == 0) {
            return (new_amounts(0, 0), new_amounts(0, 0), new_amounts(0, 0))
        };
        let v2 = if (arg3) {
            0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::q64x64::get_integer(0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::q64x64::div(0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::q64x64::from_integer(v1), v0))
        } else {
            0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::q64x64::get_integer(0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::q64x64::mul(0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::q64x64::from_integer(v1), v0))
        };
        let v3 = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::pair_parameter_helper::get_total_fee(arg1, arg2);
        let v4 = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::fee_helper::get_fee_amount(v2, v3);
        let v5 = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::add_u64(v2, v4);
        let v6 = if (arg3) {
            arg5.amount_x
        } else {
            arg5.amount_y
        };
        let (v7, v8, v9) = if (v6 >= v5) {
            (v5, v1, v4)
        } else {
            let v10 = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::fee_helper::get_fee_amount_from(v6, v3);
            let v11 = if (arg3) {
                0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::q64x64::get_integer(0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::q64x64::mul(0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::q64x64::from_integer(0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::sub_u64(v6, v10)), v0))
            } else {
                0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::q64x64::get_integer(0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::q64x64::div(0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::q64x64::from_integer(0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::sub_u64(v6, v10)), v0))
            };
            (v6, 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::min_u64(v11, v1), v10)
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
        assert!(get_liquidity_from_reserves(&v21, v0) <= 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::constants::max_liquidity_per_bin(), 702);
        (v13, v15, v12)
    }

    public fun get_amounts_values(arg0: &Amounts) : (u64, u64) {
        (arg0.amount_x, arg0.amount_y)
    }

    public fun get_bin(arg0: &BinManager, arg1: u32) : &BinReserves {
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<BinReserves>(&arg0.bins, (arg1 as u64)), 704);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow<BinReserves>(&arg0.bins, (arg1 as u64))
    }

    public(friend) fun get_bin_mut(arg0: &mut BinManager, arg1: u32) : &mut BinReserves {
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<BinReserves>(&arg0.bins, (arg1 as u64)), 704);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_mut<BinReserves>(&mut arg0.bins, (arg1 as u64))
    }

    public fun get_bin_reserves(arg0: &BinManager, arg1: u32) : (u64, u64) {
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<BinReserves>(&arg0.bins, (arg1 as u64)), 704);
        let v0 = *0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow<BinReserves>(&arg0.bins, (arg1 as u64));
        (v0.reserve_x, v0.reserve_y)
    }

    public fun get_cached_price(arg0: &BinReserves) : u128 {
        arg0.price
    }

    public fun get_composition_fees(arg0: &BinReserves, arg1: &0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::pair_parameter_helper::PairParameters, arg2: u16, arg3: &Amounts, arg4: u128, arg5: u128) : Amounts {
        if (arg5 == 0) {
            return new_amounts(0, 0)
        };
        let v0 = amounts_to_reserves(arg3);
        let v1 = add_reserves(arg0, &v0);
        let v2 = get_amount_out_of_bin(&v1, arg5, 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::add_u128(arg4, arg5));
        if (v2.amount_x > arg3.amount_x && arg3.amount_y > v2.amount_y) {
            new_amounts(0, 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::fee_helper::get_composition_fee(arg3.amount_y - v2.amount_y, 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::pair_parameter_helper::get_total_fee(arg1, arg2)))
        } else if (v2.amount_y > arg3.amount_y && arg3.amount_x > v2.amount_x) {
            new_amounts(0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::fee_helper::get_composition_fee(arg3.amount_x - v2.amount_x, 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::pair_parameter_helper::get_total_fee(arg1, arg2)), 0)
        } else {
            new_amounts(0, 0)
        }
    }

    public fun get_fee_growth_x(arg0: &BinReserves) : u128 {
        arg0.fee_growth_x
    }

    public fun get_fee_growth_y(arg0: &BinReserves) : u128 {
        arg0.fee_growth_y
    }

    public fun get_fees(arg0: &BinReserves) : (u64, u64) {
        (arg0.fee_x, arg0.fee_y)
    }

    public fun get_last_update_time(arg0: &BinReserves) : u64 {
        arg0.last_update_time
    }

    public fun get_liquidity(arg0: &BinReserves) : u128 {
        arg0.liquidity
    }

    fun get_liquidity_amounts(arg0: u64, arg1: u64, arg2: u128) : u128 {
        let v0 = 0;
        if (arg0 > 0 && arg2 > 0) {
            v0 = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::q64x64::mul(arg2, 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::q64x64::from_integer(arg0));
        };
        if (arg1 > 0) {
            v0 = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::q64x64::add(v0, 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::q64x64::from_integer(arg1));
        };
        (0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::q64x64::get_integer(v0) as u128)
    }

    public fun get_liquidity_from_amounts(arg0: &Amounts, arg1: u128) : u128 {
        get_liquidity_amounts(arg0.amount_x, arg0.amount_y, arg1)
    }

    public fun get_liquidity_from_reserves(arg0: &BinReserves, arg1: u128) : u128 {
        get_liquidity_amounts(arg0.reserve_x, arg0.reserve_y, arg1)
    }

    public fun get_liquidity_from_reserves2(arg0: &BinReserves, arg1: u128, arg2: &Amounts, arg3: &Amounts) : u128 {
        get_liquidity_amounts(0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::add_u64(arg0.reserve_x, 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::sub_u64(arg2.amount_x, arg3.amount_x)), 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::add_u64(arg0.reserve_y, 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::sub_u64(arg2.amount_y, arg3.amount_y)), arg1)
    }

    public fun get_next_non_empty_bin(arg0: &BinManager, arg1: bool, arg2: u32) : u32 {
        let v0 = if (arg1) {
            let v1 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::find_next<BinReserves>(&arg0.bins, (arg2 as u64), false);
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
            let v3 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::find_prev<BinReserves>(&arg0.bins, (arg2 as u64), false);
            if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v3)) {
                (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v3) as u32)
            } else {
                0
            }
        };
        let v4 = NextNonEmptyBinQueried{
            swap_for_y : arg1,
            id         : arg2,
            next_id    : v0,
        };
        0x2::event::emit<NextNonEmptyBinQueried>(v4);
        v0
    }

    public fun get_reserves(arg0: &BinReserves) : (u64, u64) {
        (arg0.reserve_x, arg0.reserve_y)
    }

    public fun get_rewards_growth(arg0: &BinReserves) : &vector<u128> {
        &arg0.rewards_growth
    }

    public fun get_shares_and_effective_amounts_in(arg0: &BinReserves, arg1: &Amounts, arg2: u128, arg3: u128) : (u128, Amounts) {
        let v0 = get_liquidity_amounts(arg1.amount_x, arg1.amount_y, arg2);
        if (v0 == 0) {
            return (0, new_amounts(0, 0))
        };
        let v1 = get_liquidity_from_reserves(arg0, arg2);
        if (v1 == 0 || arg3 == 0) {
            let v2 = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::sqrt_u128(v0);
            let v3 = v2;
            if (v2 == 0) {
                v3 = 1000;
            };
            return (v3, *arg1)
        };
        let v4 = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::mul_div_u128(v0, arg3, v1);
        if (v4 == 0) {
            return (0, new_amounts(0, 0))
        };
        let v5 = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::mul_div_u128(v4, v1, arg3);
        let v6 = if (v0 > v5) {
            let v7 = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::mul_div_u128(v5, (0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::constants::precision() as u128), v0);
            new_amounts(0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::u128_to_u64(0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::mul_div_u128((arg1.amount_x as u128), v7, (0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::constants::precision() as u128))), 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::u128_to_u64(0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::mul_div_u128((arg1.amount_y as u128), v7, (0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::constants::precision() as u128))))
        } else {
            *arg1
        };
        let v8 = v6;
        let v9 = amounts_to_reserves(&v8);
        let v10 = add_reserves(arg0, &v9);
        assert!(get_liquidity_from_reserves(&v10, arg2) <= 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::constants::max_liquidity_per_bin(), 702);
        (v4, v8)
    }

    public fun get_total_amounts(arg0: &BinReserves) : (u64, u64) {
        (0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::add_u64(arg0.reserve_x, arg0.fee_x), 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::add_u64(arg0.reserve_y, arg0.fee_y))
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

    public fun new_bin_reserves(arg0: u64, arg1: u64, arg2: u128) : BinReserves {
        BinReserves{
            reserve_x        : arg0,
            reserve_y        : arg1,
            fee_x            : 0,
            fee_y            : 0,
            price            : arg2,
            fee_growth_x     : 0,
            fee_growth_y     : 0,
            rewards_growth   : 0x1::vector::empty<u128>(),
            liquidity        : 0,
            last_update_time : 0,
        }
    }

    public(friend) fun remove_bin(arg0: &mut BinManager, arg1: u32) {
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<BinReserves>(&arg0.bins, (arg1 as u64))) {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::remove<BinReserves>(&mut arg0.bins, (arg1 as u64));
        };
    }

    public fun set_fee_growth(arg0: &mut BinReserves, arg1: u128, arg2: u128) {
        arg0.fee_growth_x = arg1;
        arg0.fee_growth_y = arg2;
    }

    public fun set_liquidity_info(arg0: &mut BinReserves, arg1: u128, arg2: u64) {
        arg0.liquidity = arg1;
        arg0.last_update_time = arg2;
    }

    public fun set_rewards_growth(arg0: &mut BinReserves, arg1: vector<u128>) {
        arg0.rewards_growth = arg1;
    }

    public fun sub_amounts(arg0: &Amounts, arg1: &Amounts) : Amounts {
        assert!(arg0.amount_x >= arg1.amount_x && arg0.amount_y >= arg1.amount_y, 703);
        Amounts{
            amount_x : 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::sub_u64(arg0.amount_x, arg1.amount_x),
            amount_y : 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::sub_u64(arg0.amount_y, arg1.amount_y),
        }
    }

    fun sub_reserves(arg0: &BinReserves, arg1: &BinReserves) : BinReserves {
        assert!(arg0.reserve_x >= arg1.reserve_x && arg0.reserve_y >= arg1.reserve_y, 703);
        BinReserves{
            reserve_x        : arg0.reserve_x - arg1.reserve_x,
            reserve_y        : arg0.reserve_y - arg1.reserve_y,
            fee_x            : arg0.fee_x,
            fee_y            : arg0.fee_y,
            price            : arg0.price,
            fee_growth_x     : arg0.fee_growth_x,
            fee_growth_y     : arg0.fee_growth_y,
            rewards_growth   : arg0.rewards_growth,
            liquidity        : arg0.liquidity,
            last_update_time : arg0.last_update_time,
        }
    }

    public fun update_bin_reserves_after_remove(arg0: &BinReserves, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : BinReserves {
        BinReserves{
            reserve_x        : arg1,
            reserve_y        : arg2,
            fee_x            : arg3,
            fee_y            : arg4,
            price            : arg0.price,
            fee_growth_x     : arg0.fee_growth_x,
            fee_growth_y     : arg0.fee_growth_y,
            rewards_growth   : arg0.rewards_growth,
            liquidity        : arg0.liquidity,
            last_update_time : arg0.last_update_time,
        }
    }

    public fun update_to_reserves(arg0: &mut BinReserves, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        arg0.reserve_x = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::sub_u64(0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::add_u64(arg0.reserve_x, arg1), arg2);
        arg0.reserve_y = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::sub_u64(0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::add_u64(arg0.reserve_y, arg3), arg4);
        arg0.fee_x = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::add_u64(arg0.fee_x, arg5);
        arg0.fee_y = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::add_u64(arg0.fee_y, arg6);
    }

    public fun verify_amounts(arg0: &Amounts, arg1: u32, arg2: u32) {
        if (arg2 < arg1 && arg0.amount_y > 0 || arg2 > arg1 && arg0.amount_x > 0) {
            abort 700
        };
    }

    // decompiled from Move bytecode v6
}

