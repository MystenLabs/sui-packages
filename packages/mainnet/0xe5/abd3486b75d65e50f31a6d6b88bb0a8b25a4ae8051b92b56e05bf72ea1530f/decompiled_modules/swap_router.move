module 0xe5abd3486b75d65e50f31a6d6b88bb0a8b25a4ae8051b92b56e05bf72ea1530f::swap_router {
    public fun swap_exact_x_to_y<T0, T1>(arg0: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::Route, arg1: &0x8c85cc6e2cecad2e0fad9e2d973889cf245aab35e5de0bfc8c4f3388be3d0acd::config::GlobalConfig, arg2: &mut 0x8c85cc6e2cecad2e0fad9e2d973889cf245aab35e5de0bfc8c4f3388be3d0acd::lb_pair::LBPair<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::borrow_mut_current_path<T0, T1>(arg0);
        let (v1, v2) = 0x8c85cc6e2cecad2e0fad9e2d973889cf245aab35e5de0bfc8c4f3388be3d0acd::lb_pair::swap<T0, T1>(arg1, arg2, true, 0, 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::take_coin_in<T0, T1>(v0), 0x2::coin::zero<T1>(arg4), arg3, arg4);
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::utils::refund_if_necessary<T0>(v1, 0x2::tx_context::sender(arg4));
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::fill_coin_out<T0, T1>(v0, v2);
    }

    public fun swap_exact_y_to_x<T0, T1>(arg0: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::Route, arg1: &0x8c85cc6e2cecad2e0fad9e2d973889cf245aab35e5de0bfc8c4f3388be3d0acd::config::GlobalConfig, arg2: &mut 0x8c85cc6e2cecad2e0fad9e2d973889cf245aab35e5de0bfc8c4f3388be3d0acd::lb_pair::LBPair<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::borrow_mut_current_path<T1, T0>(arg0);
        let (v1, v2) = 0x8c85cc6e2cecad2e0fad9e2d973889cf245aab35e5de0bfc8c4f3388be3d0acd::lb_pair::swap<T0, T1>(arg1, arg2, false, 0, 0x2::coin::zero<T0>(arg4), 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::take_coin_in<T1, T0>(v0), arg3, arg4);
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::utils::refund_if_necessary<T1>(v2, 0x2::tx_context::sender(arg4));
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::fill_coin_out<T1, T0>(v0, v1);
    }

    // decompiled from Move bytecode v6
}

