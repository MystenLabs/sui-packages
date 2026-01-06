module 0x589798bda2275d87d98345faed6a3ce8802a4c33a41ee94efbb3c58c69e68639::swap_router {
    public fun swap_exact_input<T0, T1>(arg0: &mut 0xb1fe8e3aa1378f52fc018f49193ab09e4fb7421e4bd76d563ebd6a35d08e5b6::universal_router::Route, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: u64, arg3: u128, arg4: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb1fe8e3aa1378f52fc018f49193ab09e4fb7421e4bd76d563ebd6a35d08e5b6::universal_router::borrow_mut_current_path<T0, T1>(arg0);
        let v1 = if (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::utils::is_ordered<T0, T1>()) {
            0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_x_to_y<T0, T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg1, arg2), 0xb1fe8e3aa1378f52fc018f49193ab09e4fb7421e4bd76d563ebd6a35d08e5b6::universal_router::take_coin_in<T0, T1>(v0), arg3, arg4, arg5, arg6)
        } else {
            0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_y_to_x<T1, T0>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T1, T0>(arg1, arg2), 0xb1fe8e3aa1378f52fc018f49193ab09e4fb7421e4bd76d563ebd6a35d08e5b6::universal_router::take_coin_in<T0, T1>(v0), arg3, arg4, arg5, arg6)
        };
        0xb1fe8e3aa1378f52fc018f49193ab09e4fb7421e4bd76d563ebd6a35d08e5b6::universal_router::fill_coin_out<T0, T1>(v0, 0x2::coin::from_balance<T1>(v1, arg6));
    }

    // decompiled from Move bytecode v6
}

