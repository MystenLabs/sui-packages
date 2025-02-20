module 0x91600d48435b6d8788454b0b7a25ba0d00a79ee6466515f0383e2d22f0787ffa::swap_router {
    public fun swap_exact_x_to_y<T0, T1>(arg0: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::Route, arg1: &mut 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::state::State, arg2: &mut 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::pool::Pool<T0, T1>, arg3: 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::quote::Quote<T0, T1>, arg4: vector<vector<u8>>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::borrow_mut_current_path<T0, T1>(arg0);
        let v1 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::take_coin_in<T0, T1>(v0);
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::utils::refund_if_necessary<T0>(v1, 0x2::tx_context::sender(arg6));
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::fill_coin_out<T0, T1>(v0, 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::converter::convert_base_for_quote<T0, T1>(arg1, arg2, &mut v1, arg3, arg4, arg5, arg6));
    }

    public fun swap_exact_y_to_x<T0, T1>(arg0: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::Route, arg1: &mut 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::state::State, arg2: &mut 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::pool::Pool<T0, T1>, arg3: 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::quote::Quote<T1, T0>, arg4: vector<vector<u8>>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::borrow_mut_current_path<T1, T0>(arg0);
        let v1 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::take_coin_in<T1, T0>(v0);
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::utils::refund_if_necessary<T1>(v1, 0x2::tx_context::sender(arg6));
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::fill_coin_out<T1, T0>(v0, 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::converter::convert_quote_for_base<T0, T1>(arg1, arg2, &mut v1, arg3, arg4, arg5, arg6));
    }

    // decompiled from Move bytecode v6
}

