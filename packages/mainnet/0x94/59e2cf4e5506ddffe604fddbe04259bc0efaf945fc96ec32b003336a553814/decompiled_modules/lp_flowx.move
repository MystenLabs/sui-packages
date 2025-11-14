module 0x9459e2cf4e5506ddffe604fddbe04259bc0efaf945fc96ec32b003336a553814::lp_flowx {
    struct FlowxWitness has drop {
        dummy_field: bool,
    }

    public(friend) fun mint_proxy_cap(arg0: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::Registry) : 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::ProxyCap {
        let v0 = FlowxWitness{dummy_field: false};
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::mint_proxy_cap<FlowxWitness>(arg0, v0)
    }

    public fun compound<T0, T1>(arg0: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::Registry, arg1: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::Collector<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: vector<0x1::string::String>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::tx_context::sender(arg11);
        compound_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v0, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::constants::compound_source(), arg10, arg11)
    }

    public(friend) fun compound_int<T0, T1>(arg0: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::Registry, arg1: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::Collector<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: vector<0x1::string::String>, arg10: address, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg2, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::fee_rate(arg4)));
        let (v1, v2, v3, v4) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::into_balance<T0>(arg5), 0x2::coin::into_balance<T1>(arg6), arg11, arg10, arg12, arg13);
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::assert_price(arg0, v0, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg2, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::fee_rate(arg4))));
        assert!(v1 >= arg7 && v2 >= arg8, 1);
        let v5 = mint_proxy_cap(arg0);
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::events::emit_compounded(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::pool_id(arg4), 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(arg4), v1, v2, arg9, &v5);
        (0x2::coin::from_balance<T0>(v3, arg13), 0x2::coin::from_balance<T1>(v4, arg13))
    }

    public fun rebalance<T0, T1>(arg0: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::Registry, arg1: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::Collector<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::PositionRegistry, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position, arg6: 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::RebalanceReceipt, arg7: u32, arg8: u32, arg9: 0x2::coin::Coin<T0>, arg10: 0x2::coin::Coin<T1>, arg11: u64, arg12: u64, arg13: vector<0x1::string::String>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position) {
        let v0 = 0x2::tx_context::sender(arg15);
        rebalance_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v0, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::constants::rebalance_source(), arg14, arg15)
    }

    public(friend) fun rebalance_int<T0, T1>(arg0: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::Registry, arg1: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::Collector<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::PositionRegistry, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position, arg6: 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::RebalanceReceipt, arg7: u32, arg8: u32, arg9: 0x2::coin::Coin<T0>, arg10: 0x2::coin::Coin<T1>, arg11: u64, arg12: u64, arg13: vector<0x1::string::String>, arg14: address, arg15: u64, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position) {
        assert!(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::is_empty(&arg5), 3);
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::open_position<T0, T1>(arg3, arg2, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::fee_rate(&arg5), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::from_u32(arg7), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::from_u32(arg8), arg4, arg17);
        let v1 = &mut v0;
        let (v2, v3, v4, v5) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg4, v1, 0x2::coin::into_balance<T0>(arg9), 0x2::coin::into_balance<T1>(arg10), arg15, arg14, arg16, arg17);
        assert!(v2 >= arg11 && v3 >= arg12, 1);
        let v6 = mint_proxy_cap(arg0);
        let (v7, v8, v9, v10, v11) = 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::destroy_rebalance_receipt(arg6, &v6);
        let v12 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg2, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::fee_rate(&arg5)));
        assert!(0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::math::get_liquidity_in_y(v2, v3, v12) >= v11, 1);
        assert!(v7 == 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(&arg5), 4);
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::assert_price(arg0, v10, v12);
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::events::emit_rebalanced(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::pool_id(&arg5), v7, 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(&v0), v8, v9, v2, v3, v10, v12, arg13, &v6);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::close_position(arg3, arg5, arg4, arg17);
        (0x2::coin::from_balance<T0>(v4, arg17), 0x2::coin::from_balance<T1>(v5, arg17), v0)
    }

    public fun start_rebalance<T0, T1>(arg0: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::Registry, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::RebalanceReceipt, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = mint_proxy_cap(arg0);
        let v1 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::liquidity(arg3);
        let (v2, v3) = if (v1 > 0) {
            0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::decrease_liquidity<T0, T1>(arg1, arg3, v1, 0, 0, 0x2::clock::timestamp_ms(arg5) + 1000, arg2, arg5, arg6);
            0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::collect<T0, T1>(arg1, arg3, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::coins_owed_x(arg3), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::coins_owed_y(arg3), arg2, arg5, arg6)
        } else {
            (0x2::coin::zero<T0>(arg6), 0x2::coin::zero<T1>(arg6))
        };
        let v4 = v3;
        let v5 = v2;
        (0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::new_rebalance_receipt(0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(arg3), 0x2::coin::value<T0>(&v5), 0x2::coin::value<T1>(&v4), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg1, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::fee_rate(arg3))), arg4, &v0), v5, v4)
    }

    fun swap_to_optimal<T0, T1>(arg0: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::Registry, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position, arg4: &mut 0x2::balance::Balance<T0>, arg5: &mut 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let (v0, v1, v2, _) = 0x9459e2cf4e5506ddffe604fddbe04259bc0efaf945fc96ec32b003336a553814::swap_math::optimal_swap<T0, T1>(arg2, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::as_u32(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::tick_lower_index(arg3)), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::as_u32(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::tick_upper_index(arg3)), 0x2::balance::value<T0>(arg4), 0x2::balance::value<T1>(arg5));
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
        let v12 = if (v2) {
            0x2::balance::value<T1>(&v10)
        } else {
            0x2::balance::value<T0>(&v11)
        };
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::assert_output(arg0, v1, v12);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(arg2, v9, v4, v5, arg1, arg7);
        0x2::balance::join<T0>(arg4, v11);
        0x2::balance::join<T1>(arg5, v10);
    }

    public fun zap_in<T0, T1>(arg0: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::Registry, arg1: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::Collector<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg2, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::fee_rate(arg4)));
        let v1 = 0x2::tx_context::sender(arg10);
        let (v2, v3, v4, v5) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::into_balance<T0>(arg5), 0x2::coin::into_balance<T1>(arg6), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::constants::zap_in_source(), v1, arg9, arg10);
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::assert_price(arg0, v0, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg2, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::fee_rate(arg4))));
        assert!(v2 >= arg7 && v3 >= arg8, 1);
        let v6 = mint_proxy_cap(arg0);
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::events::emit_zapped_in(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::pool_id(arg4), 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(arg4), v2, v3, &v6);
        (0x2::coin::from_balance<T0>(v4, arg10), 0x2::coin::from_balance<T1>(v5, arg10))
    }

    fun zap_in_int<T0, T1>(arg0: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::Registry, arg1: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::Collector<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position, arg5: 0x2::balance::Balance<T0>, arg6: 0x2::balance::Balance<T1>, arg7: u64, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::fee_pips(arg0, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::fee_rate(arg4), arg7);
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::collect_fees<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position, T0>(arg1, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::pool_id(arg4), 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(arg4), arg8, arg7, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::utils::split_balance_by_pips<T0>(&mut arg5, v0));
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::collect_fees<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position, T1>(arg1, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::pool_id(arg4), 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(arg4), arg8, arg7, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::utils::split_balance_by_pips<T1>(&mut arg6, v0));
        let v1 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg2, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::fee_rate(arg4));
        let v2 = &mut arg5;
        let v3 = &mut arg6;
        swap_to_optimal<T0, T1>(arg0, arg3, v1, arg4, v2, v3, arg9, arg10);
        let v4 = 0x2::coin::from_balance<T1>(arg6, arg10);
        let v5 = 0x2::coin::from_balance<T0>(arg5, arg10);
        let v6 = 0x2::coin::value<T0>(&v5);
        let v7 = 0x2::coin::value<T1>(&v4);
        assert!(v6 > 0 || v7 > 0, 0);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::increase_liquidity_v2<T0, T1>(arg2, arg4, &mut v5, &mut v4, 0, 0, 0x2::clock::timestamp_ms(arg9) + 1000, arg3, arg9, arg10);
        (v6 - 0x2::coin::value<T0>(&v5), v7 - 0x2::coin::value<T1>(&v4), 0x2::coin::into_balance<T0>(v5), 0x2::coin::into_balance<T1>(v4))
    }

    public fun zap_out<T0>(arg0: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::Registry, arg1: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::Collector<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::collect_fees<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position, T0>(arg1, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::pool_id(arg2), 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(arg2), 0x2::tx_context::sender(arg5), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::constants::zap_out_source(), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::utils::split_balance_by_pips<T0>(&mut v0, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::fee_pips(arg0, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::fee_rate(arg2), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::constants::zap_out_source())));
        assert!(0x2::balance::value<T0>(&v0) >= arg4, 1);
        let v1 = mint_proxy_cap(arg0);
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::events::emit_zapped_out(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::pool_id(arg2), 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(arg2), 0x1::type_name::with_original_ids<T0>(), 0x2::balance::value<T0>(&v0), &v1);
        0x2::coin::from_balance<T0>(v0, arg5)
    }

    // decompiled from Move bytecode v6
}

