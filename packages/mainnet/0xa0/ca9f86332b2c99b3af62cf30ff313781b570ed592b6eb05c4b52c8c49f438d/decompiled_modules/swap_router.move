module 0xa0ca9f86332b2c99b3af62cf30ff313781b570ed592b6eb05c4b52c8c49f438d::swap_router {
    public fun swap_exact_x_to_y<T0>(arg0: &mut 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::Route, arg1: &mut 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::Configuration, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::borrow_mut_current_path<T0, 0x2::sui::SUI>(arg0);
        let v1 = 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::take_coin_in<T0, 0x2::sui::SUI>(v0);
        let (v2, v3) = 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::sell_with_return<T0>(arg1, v1, 0x2::coin::value<T0>(&v1), 0, true, arg2, arg3);
        0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::utils::refund_if_necessary<T0>(v3, 0x2::tx_context::sender(arg3));
        0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::fill_coin_out<T0, 0x2::sui::SUI>(v0, v2);
    }

    public fun swap_exact_y_to_x<T0>(arg0: &mut 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::Route, arg1: &mut 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::Configuration, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::borrow_mut_current_path<0x2::sui::SUI, T0>(arg0);
        let v1 = 0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::take_coin_in<0x2::sui::SUI, T0>(v0);
        let (v2, v3) = 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::buy_with_return<T0>(arg1, v1, 0x2::coin::value<0x2::sui::SUI>(&v1), 0, true, arg2, arg3);
        0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::utils::refund_if_necessary<0x2::sui::SUI>(v2, 0x2::tx_context::sender(arg3));
        0x3a074af74ea4f10efe02ed2ec8041b2634cf590f791032310b47b47e2c085ad3::universal_router::fill_coin_out<0x2::sui::SUI, T0>(v0, v3);
    }

    // decompiled from Move bytecode v6
}

