module 0xb800f5fbb88ad556ca8556b458b20b01ffbd5c776ffed4f0d671d43e882daad6::swap_router {
    public fun swap_exact_x_for_y<T0>(arg0: &mut 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::Route, arg1: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::borrow_mut_current_path<T0, 0x2::sui::SUI>(arg0);
        let (v1, v2) = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::sell_returns<T0>(arg1, 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::take_coin_in<T0, 0x2::sui::SUI>(v0), 0, arg2, arg3);
        0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::utils::refund_if_necessary<T0>(v2, 0x2::tx_context::sender(arg3));
        0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::fill_coin_out<T0, 0x2::sui::SUI>(v0, v1);
    }

    public fun swap_exact_y_to_x<T0>(arg0: &mut 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::Route, arg1: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg2: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::ThresholdConfig, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::borrow_mut_current_path<0x2::sui::SUI, T0>(arg0);
        let (v1, v2) = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::buy_returns_v2<T0>(arg1, arg2, 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::take_coin_in<0x2::sui::SUI, T0>(v0), arg3, arg4, arg5, arg6);
        0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::utils::refund_if_necessary<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg6));
        0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::fill_coin_out<0x2::sui::SUI, T0>(v0, v2);
    }

    // decompiled from Move bytecode v6
}

