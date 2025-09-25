module 0xdf636501c41297bc758de5c85458af9d57323bee8e626a065aceb5bc973aeec::swap_router {
    public fun swap_exact_input<T0, T1>(arg0: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::Route, arg1: &mut 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool_manager::PoolRegistry, arg2: u64, arg3: u128, arg4: &mut 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::borrow_mut_current_path<T0, T1>(arg0);
        let v1 = if (0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::utils::is_ordered<T0, T1>()) {
            0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::swap_router::swap_exact_x_to_y<T0, T1>(0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool_manager::borrow_mut_pool<T0, T1>(arg1, arg2), 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::take_coin_in<T0, T1>(v0), arg3, arg4, arg5, arg6)
        } else {
            0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::swap_router::swap_exact_y_to_x<T1, T0>(0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool_manager::borrow_mut_pool<T1, T0>(arg1, arg2), 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::take_coin_in<T0, T1>(v0), arg3, arg4, arg5, arg6)
        };
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::fill_coin_out<T0, T1>(v0, 0x2::coin::from_balance<T1>(v1, arg6));
    }

    // decompiled from Move bytecode v6
}

