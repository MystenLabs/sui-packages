module 0x1dbb8c7cb665dbe9581eacd6a6265a44ee7354004f6b03de40adb3d79a7d9946::swap_router {
    public fun swap_exact_x_to_y<T0, T1>(arg0: &mut 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::Route, arg1: &mut 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::state::State, arg2: &mut 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::pool::Pool<T0, T1>, arg3: 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::quote::Quote<T0, T1>, arg4: vector<vector<u8>>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::borrow_mut_current_path<T0, T1>(arg0);
        let v1 = 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::take_coin_in<T0, T1>(v0);
        0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::utils::refund_if_necessary<T0>(v1, 0x2::tx_context::sender(arg6));
        0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::fill_coin_out<T0, T1>(v0, 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::converter::convert_base_for_quote<T0, T1>(arg1, arg2, &mut v1, arg3, arg4, arg5, arg6));
    }

    public fun swap_exact_y_to_x<T0, T1>(arg0: &mut 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::Route, arg1: &mut 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::state::State, arg2: &mut 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::pool::Pool<T0, T1>, arg3: 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::quote::Quote<T1, T0>, arg4: vector<vector<u8>>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::borrow_mut_current_path<T1, T0>(arg0);
        let v1 = 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::take_coin_in<T1, T0>(v0);
        0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::utils::refund_if_necessary<T1>(v1, 0x2::tx_context::sender(arg6));
        0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::fill_coin_out<T1, T0>(v0, 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::converter::convert_quote_for_base<T0, T1>(arg1, arg2, &mut v1, arg3, arg4, arg5, arg6));
    }

    // decompiled from Move bytecode v6
}

