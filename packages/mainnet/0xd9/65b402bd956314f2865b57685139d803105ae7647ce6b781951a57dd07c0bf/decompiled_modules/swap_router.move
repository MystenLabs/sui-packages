module 0xd965b402bd956314f2865b57685139d803105ae7647ce6b781951a57dd07c0bf::swap_router {
    public fun swap_exact_x_to_y<T0, T1>(arg0: &mut 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::Route, arg1: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::borrow_mut_current_path<T0, T1>(arg0);
        let v1 = 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::take_coin_in<T0, T1>(v0);
        0x2::coin::destroy_zero<T0>(v1);
        0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::fill_coin_out<T0, T1>(v0, 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_base_coin<T0, T1>(arg1, arg4, arg2, arg3, &mut v1, 0x2::coin::value<T0>(&v1), 0, arg5));
    }

    public fun swap_exact_y_to_x<T0, T1>(arg0: &mut 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::Route, arg1: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::borrow_mut_current_path<T1, T0>(arg0);
        let v1 = 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::take_coin_in<T1, T0>(v0);
        0x2::coin::destroy_zero<T1>(v1);
        0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::fill_coin_out<T1, T0>(v0, 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_quote_coin<T0, T1>(arg1, arg4, arg2, arg3, &mut v1, 0x2::coin::value<T1>(&v1), 0, arg5));
    }

    // decompiled from Move bytecode v6
}

