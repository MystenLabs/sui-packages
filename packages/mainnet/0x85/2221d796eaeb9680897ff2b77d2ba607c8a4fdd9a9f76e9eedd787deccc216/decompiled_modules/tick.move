module 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::tick {
    struct TickInfo has copy, drop, store {
        liquidity_gross: u128,
        liquidity_net: 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i128::I128,
        fee_growth_outside_x: u128,
        fee_growth_outside_y: u128,
        reward_growths_outside: vector<u128>,
        tick_cumulative_out_side: 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i64::I64,
        seconds_per_liquidity_out_side: u256,
        seconds_out_side: u64,
    }

    public(friend) fun clear(arg0: &mut 0x2::table::Table<0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, TickInfo>, arg1: 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32) {
        0x2::table::remove<0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, TickInfo>(arg0, arg1);
    }

    fun compute_reward_growths(arg0: vector<u128>, arg1: vector<u128>) : vector<u128> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u128>();
        while (v0 < 0x1::vector::length<u128>(&arg0)) {
            let v2 = if (v0 >= 0x1::vector::length<u128>(&arg1)) {
                0
            } else {
                *0x1::vector::borrow<u128>(&arg1, v0)
            };
            0x1::vector::push_back<u128>(&mut v1, 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::full_math_u128::wrapping_sub(*0x1::vector::borrow<u128>(&arg0, v0), v2));
            v0 = v0 + 1;
        };
        v1
    }

    public(friend) fun cross(arg0: &mut 0x2::table::Table<0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, TickInfo>, arg1: 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, arg2: u128, arg3: u128, arg4: vector<u128>, arg5: u256, arg6: 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i64::I64, arg7: u64) : 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i128::I128 {
        let v0 = try_borrow_mut_tick(arg0, arg1);
        v0.fee_growth_outside_x = 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::full_math_u128::wrapping_sub(arg2, v0.fee_growth_outside_x);
        v0.fee_growth_outside_y = 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::full_math_u128::wrapping_sub(arg3, v0.fee_growth_outside_y);
        v0.reward_growths_outside = compute_reward_growths(arg4, v0.reward_growths_outside);
        v0.seconds_per_liquidity_out_side = arg5 - v0.seconds_per_liquidity_out_side;
        v0.tick_cumulative_out_side = 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i64::sub(arg6, v0.tick_cumulative_out_side);
        v0.seconds_out_side = arg7 - v0.seconds_out_side;
        v0.liquidity_net
    }

    public fun get_fee_and_reward_growths_inside(arg0: &0x2::table::Table<0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, TickInfo>, arg1: 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, arg2: 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, arg3: 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, arg4: u128, arg5: u128, arg6: vector<u128>) : (u128, u128, vector<u128>) {
        let (v0, v1, v2) = get_fee_and_reward_growths_outside(arg0, arg1);
        let (v3, v4, v5) = get_fee_and_reward_growths_outside(arg0, arg2);
        let (v6, v7, v8) = if (0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::gte(arg3, arg1)) {
            (v0, v1, v2)
        } else {
            (0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::full_math_u128::wrapping_sub(arg4, v0), 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::full_math_u128::wrapping_sub(arg5, v1), compute_reward_growths(arg6, v2))
        };
        let (v9, v10, v11) = if (0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::lt(arg3, arg2)) {
            (v3, v4, v5)
        } else {
            (0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::full_math_u128::wrapping_sub(arg4, v3), 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::full_math_u128::wrapping_sub(arg5, v4), compute_reward_growths(arg6, v5))
        };
        (0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::full_math_u128::wrapping_sub(0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::full_math_u128::wrapping_sub(arg4, v6), v9), 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::full_math_u128::wrapping_sub(0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::full_math_u128::wrapping_sub(arg5, v7), v10), compute_reward_growths(compute_reward_growths(arg6, v8), v11))
    }

    public fun get_fee_and_reward_growths_outside(arg0: &0x2::table::Table<0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, TickInfo>, arg1: 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32) : (u128, u128, vector<u128>) {
        if (!is_initialized(arg0, arg1)) {
            (0, 0, 0x1::vector::empty<u128>())
        } else {
            let v3 = 0x2::table::borrow<0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, TickInfo>(arg0, arg1);
            (v3.fee_growth_outside_x, v3.fee_growth_outside_y, v3.reward_growths_outside)
        }
    }

    public fun get_liquidity_gross(arg0: &0x2::table::Table<0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, TickInfo>, arg1: 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32) : u128 {
        if (!is_initialized(arg0, arg1)) {
            0
        } else {
            0x2::table::borrow<0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, TickInfo>(arg0, arg1).liquidity_gross
        }
    }

    public fun get_liquidity_net(arg0: &0x2::table::Table<0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, TickInfo>, arg1: 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32) : 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i128::I128 {
        if (!is_initialized(arg0, arg1)) {
            0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i128::zero()
        } else {
            0x2::table::borrow<0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, TickInfo>(arg0, arg1).liquidity_net
        }
    }

    public fun get_seconds_out_side(arg0: &0x2::table::Table<0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, TickInfo>, arg1: 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32) : u64 {
        if (!is_initialized(arg0, arg1)) {
            0
        } else {
            0x2::table::borrow<0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, TickInfo>(arg0, arg1).seconds_out_side
        }
    }

    public fun get_seconds_per_liquidity_out_side(arg0: &0x2::table::Table<0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, TickInfo>, arg1: 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32) : u256 {
        if (!is_initialized(arg0, arg1)) {
            0
        } else {
            0x2::table::borrow<0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, TickInfo>(arg0, arg1).seconds_per_liquidity_out_side
        }
    }

    public fun get_tick_cumulative_out_side(arg0: &0x2::table::Table<0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, TickInfo>, arg1: 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32) : 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i64::I64 {
        if (!is_initialized(arg0, arg1)) {
            0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i64::zero()
        } else {
            0x2::table::borrow<0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, TickInfo>(arg0, arg1).tick_cumulative_out_side
        }
    }

    public fun is_initialized(arg0: &0x2::table::Table<0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, TickInfo>, arg1: 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32) : bool {
        0x2::table::contains<0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, TickInfo>(arg0, arg1)
    }

    public fun tick_spacing_to_max_liquidity_per_tick(arg0: u32) : u128 {
        let v0 = 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::from(arg0);
        0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::constants::max_u128() / ((0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::as_u32(0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::div(0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::sub(0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::mul(0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::div(0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::tick_math::max_tick(), v0), v0), 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::mul(0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::div(0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::tick_math::min_tick(), v0), v0)), v0)) + 1) as u128)
    }

    fun try_borrow_mut_tick(arg0: &mut 0x2::table::Table<0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, TickInfo>, arg1: 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32) : &mut TickInfo {
        if (!0x2::table::contains<0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, TickInfo>(arg0, arg1)) {
            let v0 = TickInfo{
                liquidity_gross                : 0,
                liquidity_net                  : 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i128::zero(),
                fee_growth_outside_x           : 0,
                fee_growth_outside_y           : 0,
                reward_growths_outside         : 0x1::vector::empty<u128>(),
                tick_cumulative_out_side       : 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i64::zero(),
                seconds_per_liquidity_out_side : 0,
                seconds_out_side               : 0,
            };
            0x2::table::add<0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, TickInfo>(arg0, arg1, v0);
        };
        0x2::table::borrow_mut<0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, TickInfo>(arg0, arg1)
    }

    public(friend) fun update(arg0: &mut 0x2::table::Table<0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, TickInfo>, arg1: 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, arg2: 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, arg3: 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i128::I128, arg4: u128, arg5: u128, arg6: vector<u128>, arg7: u256, arg8: 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i64::I64, arg9: u64, arg10: bool, arg11: u128) : bool {
        let v0 = try_borrow_mut_tick(arg0, arg1);
        let v1 = v0.liquidity_gross;
        let v2 = 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::liquidity_math::add_delta(v1, arg3);
        assert!(v2 <= arg11, 99);
        if (v1 == 0) {
            if (0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::lte(arg1, arg2)) {
                v0.fee_growth_outside_x = arg4;
                v0.fee_growth_outside_y = arg5;
                v0.seconds_per_liquidity_out_side = arg7;
                v0.tick_cumulative_out_side = arg8;
                v0.seconds_out_side = arg9;
                v0.reward_growths_outside = arg6;
            } else {
                let v3 = 0;
                while (v3 < 0x1::vector::length<u128>(&arg6)) {
                    0x1::vector::push_back<u128>(&mut v0.reward_growths_outside, 0);
                    v3 = v3 + 1;
                };
            };
        };
        v0.liquidity_gross = v2;
        let v4 = if (arg10) {
            0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i128::sub(v0.liquidity_net, arg3)
        } else {
            0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i128::add(v0.liquidity_net, arg3)
        };
        v0.liquidity_net = v4;
        v2 == 0 != v1 == 0
    }

    public fun verify_tick(arg0: 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, arg1: 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::I32, arg2: u32) {
        assert!(0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::abs_u32(arg0) % arg2 == 0 && 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::abs_u32(arg1) % arg2 == 0 && 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::lt(arg0, arg1) && 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::gte(arg0, 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::tick_math::min_tick()) && 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::i32::lte(arg1, 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::tick_math::max_tick()), 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::error::invalid_tick());
    }

    // decompiled from Move bytecode v6
}

