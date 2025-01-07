module 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::gateway {
    public entry fun close_position<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::config::GlobalConfig, arg2: &mut 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::Pool<T0, T1>, arg3: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::position::Position, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::position::liquidity(&arg3);
        let v2 = 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::position::upper_tick(&arg3);
        let v3 = 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::position::lower_tick(&arg3);
        let v4 = 0x2::object::id<0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::position::Position>(&arg3);
        if (v1 > 0) {
            let (v5, v6, v7, v8) = 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut arg3, v1, arg0);
            0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::utils::transfer_balance<T0>(v7, arg4, arg5);
            0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::utils::transfer_balance<T1>(v8, arg4, arg5);
            0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::events::emit_liquidity_removed_event(0x2::object::id<0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::Pool<T0, T1>>(arg2), v4, v0, arg4, v5, v6, v1, 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::liquidity<T0, T1>(arg2), 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::liquidity<T0, T1>(arg2), 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::current_sqrt_price<T0, T1>(arg2), 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::current_tick_index<T0, T1>(arg2), v3, v2, 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::sequence_number<T0, T1>(arg2));
        };
        0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::position::close_position(arg3);
        0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::events::emit_position_close_event(0x2::object::id<0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::Pool<T0, T1>>(arg2), v4, v0, v3, v2);
    }

    public entry fun collect_fee<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::config::GlobalConfig, arg2: &mut 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::Pool<T0, T1>, arg3: &mut 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::position::Position, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let (_, _, v3, v4) = 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::collect_fee<T0, T1>(arg0, arg1, arg2, arg3, v0);
        0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::utils::transfer_balance<T0>(v3, v0, arg4);
        0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::utils::transfer_balance<T1>(v4, v0, arg4);
    }

    public entry fun create_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: vector<u8>, arg2: u32, arg3: u64, arg4: u64, arg5: u128, arg6: &mut 0x2::tx_context::TxContext) {
        0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::new<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun provide_liquidity<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::config::GlobalConfig, arg2: &mut 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::Pool<T0, T1>, arg3: &mut 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u128, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        let (v1, v2, v3, v4) = 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::add_liquidity<T0, T1>(arg1, arg2, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), arg8, arg0);
        assert!(v1 >= arg6 && v2 >= arg7, 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::errors::slippage_exceeds());
        0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::utils::transfer_balance<T0>(v3, v0, arg9);
        0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::utils::transfer_balance<T1>(v4, v0, arg9);
        0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::events::emit_liquidity_provided_event(0x2::object::id<0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::Pool<T0, T1>>(arg2), 0x2::object::id<0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::position::Position>(arg3), v0, v1, v2, arg8, 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::liquidity<T0, T1>(arg2), 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::liquidity<T0, T1>(arg2), 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::current_sqrt_price<T0, T1>(arg2), 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::current_tick_index<T0, T1>(arg2), 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::position::lower_tick(arg3), 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::position::upper_tick(arg3), 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::sequence_number<T0, T1>(arg2));
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::config::GlobalConfig, arg2: &mut 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::Pool<T0, T1>, arg3: &mut 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::position::Position, arg4: u128, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::remove_liquidity<T0, T1>(arg1, arg2, arg3, arg4, arg0);
        0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::utils::transfer_balance<T0>(v2, arg5, arg6);
        0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::utils::transfer_balance<T1>(v3, arg5, arg6);
        0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::events::emit_liquidity_removed_event(0x2::object::id<0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::Pool<T0, T1>>(arg2), 0x2::object::id<0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::position::Position>(arg3), 0x2::tx_context::sender(arg6), arg5, v0, v1, arg4, 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::liquidity<T0, T1>(arg2), 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::liquidity<T0, T1>(arg2), 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::current_sqrt_price<T0, T1>(arg2), 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::current_tick_index<T0, T1>(arg2), 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::position::lower_tick(arg3), 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::position::upper_tick(arg3), 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::sequence_number<T0, T1>(arg2));
    }

    // decompiled from Move bytecode v6
}

