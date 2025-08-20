module 0x6f7f55edd8ae1aa551f44b2164a971684e5050d65b96eba00559070afbc5a02c::swap_router {
    public fun swap_exact_input<T0, T1>(arg0: &mut 0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::Route, arg1: &mut 0x799277aff682240a23ed14e2366731a6f4cf0d1897aa0e050ea3cc9abe28d769::pool_manager::PoolRegistry, arg2: u64, arg3: u128, arg4: &mut 0x799277aff682240a23ed14e2366731a6f4cf0d1897aa0e050ea3cc9abe28d769::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::borrow_mut_current_path<T0, T1>(arg0);
        let v1 = if (0x799277aff682240a23ed14e2366731a6f4cf0d1897aa0e050ea3cc9abe28d769::utils::is_ordered<T0, T1>()) {
            0x799277aff682240a23ed14e2366731a6f4cf0d1897aa0e050ea3cc9abe28d769::swap_router::swap_exact_x_to_y<T0, T1>(0x799277aff682240a23ed14e2366731a6f4cf0d1897aa0e050ea3cc9abe28d769::pool_manager::borrow_mut_pool<T0, T1>(arg1, arg2), 0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::take_coin_in<T0, T1>(v0), arg3, arg4, arg5, arg6)
        } else {
            0x799277aff682240a23ed14e2366731a6f4cf0d1897aa0e050ea3cc9abe28d769::swap_router::swap_exact_y_to_x<T1, T0>(0x799277aff682240a23ed14e2366731a6f4cf0d1897aa0e050ea3cc9abe28d769::pool_manager::borrow_mut_pool<T1, T0>(arg1, arg2), 0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::take_coin_in<T0, T1>(v0), arg3, arg4, arg5, arg6)
        };
        0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::fill_coin_out<T0, T1>(v0, 0x2::coin::from_balance<T1>(v1, arg6));
    }

    // decompiled from Move bytecode v6
}

