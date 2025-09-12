module 0x65ef04cb01a39459ab5c20e2305b43d25fcf2e3679ee9b2777fd712a5c4de6e1::swap_router {
    public fun swap_exact_x_to_y<T0, T1>(arg0: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::Route, arg1: &0x8c85cc6e2cecad2e0fad9e2d973889cf245aab35e5de0bfc8c4f3388be3d0acd::config::GlobalConfig, arg2: &mut 0x8c85cc6e2cecad2e0fad9e2d973889cf245aab35e5de0bfc8c4f3388be3d0acd::lb_pair::LBPair<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::borrow_mut_current_path<T0, T1>(arg0);
        let (v1, v2) = 0x8c85cc6e2cecad2e0fad9e2d973889cf245aab35e5de0bfc8c4f3388be3d0acd::lb_pair::swap<T0, T1>(arg1, arg2, true, arg3, 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::take_coin_in<T0, T1>(v0), 0x2::coin::zero<T1>(arg5), arg4, arg5);
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::utils::refund_if_necessary<T0>(v1, 0x2::tx_context::sender(arg5));
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::fill_coin_out<T0, T1>(v0, v2);
    }

    public fun swap_exact_y_to_x<T0, T1>(arg0: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::Route, arg1: &0x8c85cc6e2cecad2e0fad9e2d973889cf245aab35e5de0bfc8c4f3388be3d0acd::config::GlobalConfig, arg2: &mut 0x8c85cc6e2cecad2e0fad9e2d973889cf245aab35e5de0bfc8c4f3388be3d0acd::lb_pair::LBPair<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::borrow_mut_current_path<T1, T0>(arg0);
        let (v1, v2) = 0x8c85cc6e2cecad2e0fad9e2d973889cf245aab35e5de0bfc8c4f3388be3d0acd::lb_pair::swap<T0, T1>(arg1, arg2, false, arg3, 0x2::coin::zero<T0>(arg5), 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::take_coin_in<T1, T0>(v0), arg4, arg5);
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::utils::refund_if_necessary<T1>(v2, 0x2::tx_context::sender(arg5));
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::fill_coin_out<T1, T0>(v0, v1);
    }

    // decompiled from Move bytecode v6
}

