module 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::collect {
    public fun collect_creator_fees<T0, T1>(arg0: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg1: &mut 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::enforce_min_version(arg0);
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::enforce_collect_enabled(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::coin_creator<T0, T1>(arg1);
        assert!(v0 == 0x1::option::extract<address>(&mut v1) && 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::is_hop_launch<T0, T1>(arg1), 2);
        let v2 = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::withdraw_creator_fees<T0, T1>(arg1);
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::events::emit_creator_fee_collect(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::id<T0, T1>(arg1), v0, 0x2::balance::value<T1>(&v2));
        0x2::coin::from_balance<T1>(v2, arg2)
    }

    public fun collect_fees<T0, T1>(arg0: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg1: &mut 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::Pool<T0, T1>, arg2: &mut 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::Position, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::enforce_min_version(arg0);
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::enforce_collect_enabled(arg0);
        assert!(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::id<T0, T1>(arg1) == 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::pool_id(arg2), 1);
        let (v0, v1) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::get_fee_growth_inside(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::borrow_tick_table<T0, T1>(arg1), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::lower_tick_index(arg2), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::upper_tick_index(arg2), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::tick_index<T0, T1>(arg1), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::fee_growth_global_x<T0, T1>(arg1), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::fee_growth_global_y<T0, T1>(arg1));
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::update(arg2, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::zero(), v0, v1);
        let (v2, v3) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::decrease_reserves<T0, T1>(arg1, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::owed_coin_x(arg2), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::owed_coin_y(arg2));
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::clear_owed_balance(arg2);
        (0x2::coin::from_balance<T0>(v2, arg3), 0x2::coin::from_balance<T1>(v3, arg3))
    }

    public fun collect_fees_locked<T0, T1>(arg0: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg1: &mut 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::Pool<T0, T1>, arg2: &mut 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::LockedPosition, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::enforce_min_version(arg0);
        assert!(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::fee_owner(arg2) == 0x2::tx_context::sender(arg3), 0);
        let v0 = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::get_position(arg2);
        collect_fees<T0, T1>(arg0, arg1, v0, arg3)
    }

    // decompiled from Move bytecode v6
}

