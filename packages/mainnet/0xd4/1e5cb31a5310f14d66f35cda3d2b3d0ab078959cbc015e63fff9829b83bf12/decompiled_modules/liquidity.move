module 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::liquidity {
    public fun add_liquidity<T0, T1>(arg0: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg1: &mut 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::Pool<T0, T1>, arg2: &mut 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::Position, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = add_liquidity_returns<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v2 = v1;
        let v3 = v0;
        if (0x2::coin::value<T0>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg8));
        } else {
            0x2::coin::destroy_zero<T0>(v3);
        };
        if (0x2::coin::value<T1>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg8));
        } else {
            0x2::coin::destroy_zero<T1>(v2);
        };
    }

    public(friend) fun add_liquidity_internal<T0, T1>(arg0: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg1: &mut 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::Pool<T0, T1>, arg2: &mut 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::Position, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::id<T0, T1>(arg1) == 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::pool_id(arg2), 0);
        let v0 = if (arg5) {
            0x2::coin::value<T0>(&arg3)
        } else {
            0x2::coin::value<T1>(&arg4)
        };
        let (v1, v2, v3) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::swap_math::get_liquidity_by_amount(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::lower_tick_index(arg2), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::upper_tick_index(arg2), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::sqrt_price<T0, T1>(arg1), v0, arg5);
        assert!(v2 > arg6, 2);
        assert!(v3 > arg7, 2);
        assert!(v1 > 0, 1);
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::add_liquidity<T0, T1>(arg1, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::lower_tick_index(arg2), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::upper_tick_index(arg2), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v2, arg8)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, v3, arg8)), v1);
        let (v4, v5) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::get_fee_growth_inside(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::borrow_tick_table<T0, T1>(arg1), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::lower_tick_index(arg2), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::upper_tick_index(arg2), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::tick_index<T0, T1>(arg1), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::fee_growth_global_x<T0, T1>(arg1), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::fee_growth_global_y<T0, T1>(arg1));
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::update(arg2, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from(v1), v4, v5);
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::events::emit_add_liquidity_event(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::id<T0, T1>(arg1), 0x2::tx_context::sender(arg8), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::id(arg2), v2, v3, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::sqrt_price<T0, T1>(arg1), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::liquidity<T0, T1>(arg1), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::reserve_x<T0, T1>(arg1), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::reserve_y<T0, T1>(arg1));
        (arg3, arg4)
    }

    public fun add_liquidity_returns<T0, T1>(arg0: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg1: &mut 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::Pool<T0, T1>, arg2: &mut 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::Position, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::enforce_liquidity_enabled(arg0);
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::enforce_min_version(arg0);
        add_liquidity_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun close_position<T0, T1>(arg0: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg1: &mut 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::Pool<T0, T1>, arg2: 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::Position, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::enforce_liquidity_enabled(arg0);
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::enforce_min_version(arg0);
        close_position_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public(friend) fun close_position_internal<T0, T1>(arg0: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg1: &mut 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::Pool<T0, T1>, arg2: 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::Position, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::id<T0, T1>(arg1) == 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::pool_id(&arg2), 0);
        let (v0, v1) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::collect::collect_fees<T0, T1>(arg0, arg1, &mut arg2, arg5);
        let v2 = &mut arg2;
        let (v3, v4) = remove_liquidity_internal<T0, T1>(arg0, arg1, v2, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::liquidity(&arg2), arg3, arg4, arg5);
        let v5 = v4;
        let v6 = v3;
        0x2::coin::join<T0>(&mut v6, v0);
        0x2::coin::join<T1>(&mut v5, v1);
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::close(arg2);
        (v6, v5)
    }

    public fun full_range_tick_range(arg0: u32) : (u32, u32) {
        let v0 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from_u32(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_math::tick_bound() % arg0);
        (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::as_u32(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::add(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_math::min_tick(), v0)), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::as_u32(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::sub(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_math::max_tick(), v0)))
    }

    public fun open_position<T0, T1>(arg0: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg1: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::Pool<T0, T1>, arg2: u32, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) : 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::Position {
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::enforce_liquidity_enabled(arg0);
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::enforce_min_version(arg0);
        open_position_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public(friend) fun open_position_internal<T0, T1>(arg0: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg1: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::Pool<T0, T1>, arg2: u32, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) : 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::Position {
        let v0 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from_u32(arg2);
        let v1 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from_u32(arg3);
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::verify_tick(v0, v1, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::tick_spacing<T0, T1>(arg1));
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::check_tick_range(v0, v1, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::tick_spacing<T0, T1>(arg1), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::constants::default_min_tick_range_factor());
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::new<T0, T1>(arg1, v0, v1, arg4)
    }

    public fun remove_liquidity<T0, T1>(arg0: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg1: &mut 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::Pool<T0, T1>, arg2: &mut 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::Position, arg3: u128, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = remove_liquidity_returns<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = v1;
        let v3 = v0;
        if (0x2::coin::value<T0>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg6));
        } else {
            0x2::coin::destroy_zero<T0>(v3);
        };
        if (0x2::coin::value<T1>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg6));
        } else {
            0x2::coin::destroy_zero<T1>(v2);
        };
    }

    public(friend) fun remove_liquidity_internal<T0, T1>(arg0: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg1: &mut 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::Pool<T0, T1>, arg2: &mut 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::Position, arg3: u128, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::id<T0, T1>(arg1) == 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::pool_id(arg2), 0);
        assert!(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::liquidity(arg2) >= arg3, 1);
        let (v0, v1) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::swap_math::get_amount_by_liquidity(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::lower_tick_index(arg2), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::upper_tick_index(arg2), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::tick_index<T0, T1>(arg1), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::sqrt_price<T0, T1>(arg1), arg3, false);
        assert!(v0 >= arg4 && v1 >= arg5, 2);
        let (v2, v3) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::remove_liquidity<T0, T1>(arg1, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::lower_tick_index(arg2), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::upper_tick_index(arg2), arg3, v0, v1);
        let (v4, v5) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::get_fee_growth_inside(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::borrow_tick_table<T0, T1>(arg1), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::lower_tick_index(arg2), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::upper_tick_index(arg2), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::tick_index<T0, T1>(arg1), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::fee_growth_global_x<T0, T1>(arg1), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::fee_growth_global_y<T0, T1>(arg1));
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::update(arg2, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::neg_from(arg3), v4, v5);
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::events::emit_remove_liquidity_event(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::id<T0, T1>(arg1), 0x2::tx_context::sender(arg6), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::id(arg2), v0, v1, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::sqrt_price<T0, T1>(arg1), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::liquidity<T0, T1>(arg1), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::reserve_x<T0, T1>(arg1), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::reserve_y<T0, T1>(arg1));
        (0x2::coin::from_balance<T0>(v2, arg6), 0x2::coin::from_balance<T1>(v3, arg6))
    }

    public fun remove_liquidity_returns<T0, T1>(arg0: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg1: &mut 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::Pool<T0, T1>, arg2: &mut 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::Position, arg3: u128, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::enforce_liquidity_enabled(arg0);
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::enforce_min_version(arg0);
        remove_liquidity_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v6
}

