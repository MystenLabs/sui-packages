module 0x149ac4f12f0a3fcfb6ccddf00d122da01c48f4b40040060bdb728e208e0b402e::swap_router {
    public fun swap_exact_x_to_y<T0, T1, T2>(arg0: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::Route, arg1: &mut 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::pool_v1::Pool<T0, T1, T2>, arg2: &0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::OracleHolder, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::borrow_mut_current_path<T0, T1>(arg0);
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::fill_coin_out<T0, T1>(v0, 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::pool_v1::swap_x_to_y<T0, T1, T2>(arg1, arg2, 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::take_coin_in<T0, T1>(v0), 0, arg3));
    }

    public fun swap_exact_y_to_x<T0, T1, T2>(arg0: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::Route, arg1: &mut 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::pool_v1::Pool<T0, T1, T2>, arg2: &0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::OracleHolder, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::borrow_mut_current_path<T1, T0>(arg0);
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::fill_coin_out<T1, T0>(v0, 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::pool_v1::swap_y_to_x<T0, T1, T2>(arg1, arg2, 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::take_coin_in<T1, T0>(v0), 0, arg3));
    }

    // decompiled from Move bytecode v6
}

