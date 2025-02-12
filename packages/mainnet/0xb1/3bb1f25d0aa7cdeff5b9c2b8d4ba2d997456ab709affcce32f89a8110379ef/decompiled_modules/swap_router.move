module 0xb13bb1f25d0aa7cdeff5b9c2b8d4ba2d997456ab709affcce32f89a8110379ef::swap_router {
    public fun swap_exact_x_to_y<T0, T1, T2>(arg0: &mut 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::Route, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u128, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::borrow_mut_current_path<T0, T1>(arg0);
        let v1 = 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::take_coin_in<T0, T1>(v0);
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg1, 0x1::vector::singleton<0x2::coin::Coin<T0>>(v1), 0x2::coin::value<T0>(&v1), 0, arg2, true, 0x2::tx_context::sender(arg5), 18446744073709551615, arg4, arg3, arg5);
        0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::utils::refund_if_necessary<T0>(v3, 0x2::tx_context::sender(arg5));
        0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::fill_coin_out<T0, T1>(v0, v2);
    }

    public fun swap_exact_y_to_x<T0, T1, T2>(arg0: &mut 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::Route, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u128, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::borrow_mut_current_path<T1, T0>(arg0);
        let v1 = 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::take_coin_in<T1, T0>(v0);
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg1, 0x1::vector::singleton<0x2::coin::Coin<T1>>(v1), 0x2::coin::value<T1>(&v1), 0, arg2, true, 0x2::tx_context::sender(arg5), 18446744073709551615, arg4, arg3, arg5);
        0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::utils::refund_if_necessary<T1>(v3, 0x2::tx_context::sender(arg5));
        0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::fill_coin_out<T1, T0>(v0, v2);
    }

    // decompiled from Move bytecode v6
}

