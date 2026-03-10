module 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick {
    struct Tick has copy, drop, store {
        index: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32,
        sqrt_price: u128,
        liquidity_net: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::I128,
        liquidity_gross: u128,
        fee_growth_outside_x: u128,
        fee_growth_outside_y: u128,
    }

    public fun check_tick_range(arg0: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg1: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg2: u32, arg3: u32) {
        assert!(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::gte(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::sub(arg1, arg0), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::mul(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from(arg3), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from(arg2))), 0);
    }

    public(friend) fun clear(arg0: &mut 0x2::table::Table<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, Tick>, arg1: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32) {
        0x2::table::remove<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, Tick>(arg0, arg1);
    }

    public(friend) fun cross(arg0: &mut 0x2::table::Table<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, Tick>, arg1: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg2: u128, arg3: u128) : 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::I128 {
        let v0 = try_borrow_mut_tick(arg0, arg1);
        v0.fee_growth_outside_x = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u128::wrapping_sub(arg2, v0.fee_growth_outside_x);
        v0.fee_growth_outside_y = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u128::wrapping_sub(arg3, v0.fee_growth_outside_y);
        v0.liquidity_net
    }

    public fun fee_growth_outside_x(arg0: &Tick) : u128 {
        arg0.fee_growth_outside_x
    }

    public fun fee_growth_outside_y(arg0: &Tick) : u128 {
        arg0.fee_growth_outside_y
    }

    public fun get_fee_growth_inside(arg0: &0x2::table::Table<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, Tick>, arg1: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg2: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg3: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg4: u128, arg5: u128) : (u128, u128) {
        let (v0, v1) = get_fee_growth_outside(arg0, arg1);
        let (v2, v3) = get_fee_growth_outside(arg0, arg2);
        let (v4, v5) = if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::gte(arg3, arg1)) {
            (v0, v1)
        } else {
            (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u128::wrapping_sub(arg4, v0), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u128::wrapping_sub(arg5, v1))
        };
        let (v6, v7) = if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::lt(arg3, arg2)) {
            (v2, v3)
        } else {
            (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u128::wrapping_sub(arg4, v2), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u128::wrapping_sub(arg5, v3))
        };
        (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u128::wrapping_sub(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u128::wrapping_sub(arg4, v4), v6), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u128::wrapping_sub(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u128::wrapping_sub(arg5, v5), v7))
    }

    public fun get_fee_growth_outside(arg0: &0x2::table::Table<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, Tick>, arg1: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32) : (u128, u128) {
        if (!is_initialized(arg0, arg1)) {
            (0, 0)
        } else {
            let v2 = 0x2::table::borrow<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, Tick>(arg0, arg1);
            (v2.fee_growth_outside_x, v2.fee_growth_outside_y)
        }
    }

    public fun get_liquidity_gross(arg0: &0x2::table::Table<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, Tick>, arg1: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32) : u128 {
        if (!is_initialized(arg0, arg1)) {
            0
        } else {
            0x2::table::borrow<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, Tick>(arg0, arg1).liquidity_gross
        }
    }

    public fun get_liquidity_net(arg0: &0x2::table::Table<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, Tick>, arg1: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32) : 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::I128 {
        if (!is_initialized(arg0, arg1)) {
            0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::zero()
        } else {
            0x2::table::borrow<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, Tick>(arg0, arg1).liquidity_net
        }
    }

    public fun get_tick(arg0: &0x2::table::Table<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, Tick>, arg1: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32) : &Tick {
        0x2::table::borrow<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, Tick>(arg0, arg1)
    }

    public fun index(arg0: &Tick) : 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32 {
        arg0.index
    }

    public fun is_initialized(arg0: &0x2::table::Table<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, Tick>, arg1: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32) : bool {
        0x2::table::contains<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, Tick>(arg0, arg1)
    }

    public fun liquidity_gross(arg0: &Tick) : u128 {
        arg0.liquidity_gross
    }

    public fun liquidity_net(arg0: &Tick) : 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::I128 {
        arg0.liquidity_net
    }

    public fun sqrt_price(arg0: &Tick) : u128 {
        arg0.sqrt_price
    }

    public fun tick_spacing_to_max_liquidity_per_tick(arg0: u32) : u128 {
        let v0 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from(arg0);
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::constants::max_u128() / ((0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::as_u32(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::div(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::sub(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::mul(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::div(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_math::max_tick(), v0), v0), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::mul(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::div(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_math::min_tick(), v0), v0)), v0)) + 1) as u128)
    }

    fun try_borrow_mut_tick(arg0: &mut 0x2::table::Table<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, Tick>, arg1: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32) : &mut Tick {
        if (!0x2::table::contains<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, Tick>(arg0, arg1)) {
            let v0 = Tick{
                index                : arg1,
                sqrt_price           : 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_math::get_sqrt_price_at_tick(arg1),
                liquidity_net        : 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::zero(),
                liquidity_gross      : 0,
                fee_growth_outside_x : 0,
                fee_growth_outside_y : 0,
            };
            0x2::table::add<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, Tick>(arg0, arg1, v0);
        };
        0x2::table::borrow_mut<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, Tick>(arg0, arg1)
    }

    public(friend) fun update(arg0: &mut 0x2::table::Table<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, Tick>, arg1: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg2: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg3: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::I128, arg4: u128, arg5: u128, arg6: bool, arg7: u128) : bool {
        let v0 = try_borrow_mut_tick(arg0, arg1);
        let v1 = v0.liquidity_gross;
        let v2 = if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::is_neg(arg3)) {
            let v3 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::abs_u128(arg3);
            assert!(v1 >= v3, 2);
            v1 - v3
        } else {
            v1 + 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::abs_u128(arg3)
        };
        assert!(v2 <= arg7, 1);
        if (v1 == 0) {
            if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::lte(arg1, arg2)) {
                v0.fee_growth_outside_x = arg4;
                v0.fee_growth_outside_y = arg5;
            };
        };
        v0.liquidity_gross = v2;
        let v4 = if (arg6) {
            0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::sub(v0.liquidity_net, arg3)
        } else {
            0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::add(v0.liquidity_net, arg3)
        };
        v0.liquidity_net = v4;
        v2 == 0 != v1 == 0
    }

    public fun verify_tick(arg0: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg1: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg2: u32) {
        let v0 = if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::abs_u32(arg0) % arg2 == 0) {
            if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::abs_u32(arg1) % arg2 == 0) {
                if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::lt(arg0, arg1)) {
                    if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::gte(arg0, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_math::min_tick())) {
                        0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::lte(arg1, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_math::max_tick())
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
    }

    // decompiled from Move bytecode v6
}

