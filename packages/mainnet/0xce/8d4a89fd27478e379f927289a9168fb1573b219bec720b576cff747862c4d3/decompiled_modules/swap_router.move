module 0xce8d4a89fd27478e379f927289a9168fb1573b219bec720b576cff747862c4d3::swap_router {
    public fun swap_exact_input<T0, T1>(arg0: &mut 0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::Route, arg1: &mut 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool_manager::PoolRegistry, arg2: u64, arg3: u128, arg4: &mut 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::borrow_mut_current_path<T0, T1>(arg0);
        let v1 = if (0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::utils::is_ordered<T0, T1>()) {
            0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::swap_router::swap_exact_x_to_y<T0, T1>(0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool_manager::borrow_mut_pool<T0, T1>(arg1, arg2), 0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::take_coin_in<T0, T1>(v0), arg3, arg4, arg5, arg6)
        } else {
            0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::swap_router::swap_exact_y_to_x<T1, T0>(0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool_manager::borrow_mut_pool<T1, T0>(arg1, arg2), 0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::take_coin_in<T0, T1>(v0), arg3, arg4, arg5, arg6)
        };
        0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::fill_coin_out<T0, T1>(v0, 0x2::coin::from_balance<T1>(v1, arg6));
    }

    // decompiled from Move bytecode v6
}

