module 0x699684a44f7833bde1b62b9c1ba53da270869a2e70f21ba969b986d5859c4287::swap_router {
    public fun swap_exact_x_to_y<T0, T1>(arg0: &mut 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::Route, arg1: &mut 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::state::State, arg2: &mut 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::pool::Pool<T0, T1>, arg3: 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::quote::Quote<T0, T1>, arg4: vector<vector<u8>>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::borrow_mut_current_path<T0, T1>(arg0);
        let v1 = 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::take_coin_in<T0, T1>(v0);
        0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::utils::refund_if_necessary<T0>(v1, 0x2::tx_context::sender(arg6));
        0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::fill_coin_out<T0, T1>(v0, 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::converter::convert_base_for_quote<T0, T1>(arg1, arg2, &mut v1, arg3, arg4, arg5, arg6));
    }

    public fun swap_exact_y_to_x<T0, T1>(arg0: &mut 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::Route, arg1: &mut 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::state::State, arg2: &mut 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::pool::Pool<T0, T1>, arg3: 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::quote::Quote<T1, T0>, arg4: vector<vector<u8>>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::borrow_mut_current_path<T1, T0>(arg0);
        let v1 = 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::take_coin_in<T1, T0>(v0);
        0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::utils::refund_if_necessary<T1>(v1, 0x2::tx_context::sender(arg6));
        0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::fill_coin_out<T1, T0>(v0, 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::converter::convert_quote_for_base<T0, T1>(arg1, arg2, &mut v1, arg3, arg4, arg5, arg6));
    }

    // decompiled from Move bytecode v6
}

