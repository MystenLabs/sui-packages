module 0xdb70ffa8b45a251005b64fc0af3f46ecc25817cf40a8b212809717b66c8dab05::lp_flowx {
    struct FlowxWitness has drop {
        dummy_field: bool,
    }

    public fun compound<T0, T1>(arg0: &mut 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::Registry, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::compound_fee_pips(arg0, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::fee_rate(arg3));
        let (v1, v2, v3, v4) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::constants::compound_fee_source(), v0, arg8, arg9);
        assert!(v1 >= arg6 && v2 >= arg7, 1);
        let v5 = init_witness();
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::events::emit_compounded<FlowxWitness>(arg0, &v5, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::pool_id(arg3), 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(arg3), v1, v2);
        (0x2::coin::from_balance<T0>(v3, arg9), 0x2::coin::from_balance<T1>(v4, arg9))
    }

    fun init_witness() : FlowxWitness {
        FlowxWitness{dummy_field: false}
    }

    public fun rebalance<T0, T1>(arg0: &mut 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::Registry, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::PositionRegistry, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position, arg5: u32, arg6: u32, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position) {
        let v0 = 0x2::coin::value<T0>(&arg7) > 0 || 0x2::coin::value<T1>(&arg8) > 0;
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::decrease_liquidity<T0, T1>(arg1, &mut arg4, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::liquidity(&arg4), 0, 0, 0x2::clock::timestamp_ms(arg11) + 1000, arg3, arg11, arg12);
        let v1 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::coins_owed_x(&arg4);
        let v2 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::coins_owed_y(&arg4);
        let (v3, v4) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::collect<T0, T1>(arg1, &mut arg4, v1, v2, arg3, arg11, arg12);
        0x2::coin::join<T0>(&mut arg7, v3);
        0x2::coin::join<T1>(&mut arg8, v4);
        let v5 = 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::rebalance_fee_pips(arg0, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::fee_rate(&arg4));
        let v6 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::open_position<T0, T1>(arg2, arg1, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::fee_rate(&arg4), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::from_u32(arg5), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::from_u32(arg6), arg3, arg12);
        let v7 = &mut v6;
        let (v8, v9, v10, v11) = zap_in_int<T0, T1>(arg0, arg1, arg3, v7, 0x2::coin::into_balance<T0>(arg7), 0x2::coin::into_balance<T1>(arg8), 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::constants::rebalance_fee_source(), v5, arg11, arg12);
        assert!(v8 >= arg9 && v9 >= arg10, 1);
        let v12 = init_witness();
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::events::emit_rebalanced<FlowxWitness>(arg0, &v12, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::pool_id(&arg4), 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(&arg4), 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(&v6), v1, v2, v8, v9, v0);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::close_position(arg2, arg4, arg3, arg12);
        (0x2::coin::from_balance<T0>(v10, arg12), 0x2::coin::from_balance<T1>(v11, arg12), v6)
    }

    fun swap_to_optimal<T0, T1>(arg0: &0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::Registry, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position, arg4: &mut 0x2::balance::Balance<T0>, arg5: &mut 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let (v0, v1, v2, _) = 0xdb70ffa8b45a251005b64fc0af3f46ecc25817cf40a8b212809717b66c8dab05::swap_math::optimal_swap<T0, T1>(arg2, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::as_u32(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::tick_lower_index(arg3)), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::as_u32(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::tick_upper_index(arg3)), 0x2::balance::value<T0>(arg4), 0x2::balance::value<T1>(arg5));
        if (v0 == 0 && v1 == 0) {
            return
        };
        let (v4, v5, v6) = if (v2) {
            (0x2::balance::split<T0>(arg4, v0), 0x2::balance::zero<T1>(), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_sqrt_price() + 1)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(arg5, v0), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_sqrt_price() - 1)
        };
        let (v7, v8, v9) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(arg2, v2, true, v0, v6, arg1, arg6, arg7);
        let v10 = v8;
        let v11 = v7;
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::assert_price(arg0, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, T1>(arg2), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, T1>(arg2));
        let v12 = if (v2) {
            0x2::balance::value<T1>(&v10)
        } else {
            0x2::balance::value<T0>(&v11)
        };
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::assert_output(arg0, v1, v12);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(arg2, v9, v4, v5, arg1, arg7);
        0x2::balance::join<T0>(arg4, v11);
        0x2::balance::join<T1>(arg5, v10);
    }

    public fun zap_in<T0, T1>(arg0: &mut 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::Registry, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::zap_fee_pips(arg0, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::fee_rate(arg3));
        let (v1, v2, v3, v4) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::constants::zap_in_fee_source(), v0, arg8, arg9);
        assert!(v1 >= arg6 && v2 >= arg7, 1);
        let v5 = init_witness();
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::events::emit_zapped_in<FlowxWitness>(arg0, &v5, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::pool_id(arg3), 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(arg3), v1, v2);
        (0x2::coin::from_balance<T0>(v3, arg9), 0x2::coin::from_balance<T1>(v4, arg9))
    }

    fun zap_in_int<T0, T1>(arg0: &mut 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::Registry, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::collect_fees<T0>(arg0, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::pool_id(arg3), &mut arg4, arg6, arg7);
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::collect_fees<T1>(arg0, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::pool_id(arg3), &mut arg5, arg6, arg7);
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg1, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::fee_rate(arg3));
        let v1 = &mut arg4;
        let v2 = &mut arg5;
        swap_to_optimal<T0, T1>(arg0, arg2, v0, arg3, v1, v2, arg8, arg9);
        let v3 = 0x2::coin::from_balance<T1>(arg5, arg9);
        let v4 = 0x2::coin::from_balance<T0>(arg4, arg9);
        let v5 = 0x2::coin::value<T0>(&v4);
        let v6 = 0x2::coin::value<T1>(&v3);
        assert!(v5 > 0 || v6 > 0, 0);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::increase_liquidity_v2<T0, T1>(arg1, arg3, &mut v4, &mut v3, 0, 0, 0x2::clock::timestamp_ms(arg8) + 1000, arg2, arg8, arg9);
        (v5 - 0x2::coin::value<T0>(&v4), v6 - 0x2::coin::value<T1>(&v3), 0x2::coin::into_balance<T0>(v4), 0x2::coin::into_balance<T1>(v3))
    }

    public fun zap_out<T0>(arg0: &mut 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::Registry, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::collect_fees<T0>(arg0, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::pool_id(arg1), &mut v0, 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::constants::zap_out_fee_source(), 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::zap_fee_pips(arg0, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::fee_rate(arg1)));
        assert!(0x2::balance::value<T0>(&v0) >= arg3, 1);
        let v1 = init_witness();
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::events::emit_zapped_out<FlowxWitness>(arg0, &v1, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::pool_id(arg1), 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(arg1), 0x1::type_name::get<T0>(), 0x2::balance::value<T0>(&v0));
        0x2::coin::from_balance<T0>(v0, arg4)
    }

    // decompiled from Move bytecode v6
}

