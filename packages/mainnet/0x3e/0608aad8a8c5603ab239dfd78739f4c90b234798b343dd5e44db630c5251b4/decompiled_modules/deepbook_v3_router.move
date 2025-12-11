module 0x3e0608aad8a8c5603ab239dfd78739f4c90b234798b343dd5e44db630c5251b4::deepbook_v3_router {
    public fun swap<T0, T1>(arg0: &mut 0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::SwapSession, arg1: &mut 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::GlobalConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: bool, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            swap_a_to_b<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7);
        } else {
            swap_b_to_a<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7);
        };
    }

    public fun swap_a_to_b<T0, T1>(arg0: &mut 0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::SwapSession, arg1: &mut 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::GlobalConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::take_balance<T0>(arg0, arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::utils::transfer_or_destroy_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4, arg6);
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v2, v3, v4) = 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::deepbook_v3::swap_a2b_<T0, T1>(arg1, arg2, 0x2::coin::from_balance<T0>(v0, arg6), arg4, arg5, arg6);
        let v5 = v3;
        let v6 = v2;
        let v7 = 0x2::coin::value<T0>(&v6);
        if (arg3 == 0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::max_amount_in()) {
            0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::utils::transfer_balance<T0>(0x2::coin::into_balance<T0>(v6), 0x2::tx_context::sender(arg6), arg6);
        } else {
            0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v6));
        };
        0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v5));
        0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::utils::transfer_or_destroy_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v4, arg6);
        0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::emit_swap_event<T0, T1>(arg0, b"deepbookv3-router", 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), v1 - v7, 0x2::coin::value<T1>(&v5), v7);
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut 0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::SwapSession, arg1: &mut 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::GlobalConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::take_balance<T1>(arg0, arg3);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::utils::transfer_or_destroy_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4, arg6);
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v2, v3, v4) = 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::deepbook_v3::swap_b2a_<T0, T1>(arg1, arg2, 0x2::coin::from_balance<T1>(v0, arg6), arg4, arg5, arg6);
        let v5 = v3;
        let v6 = v2;
        let v7 = 0x2::coin::value<T1>(&v5);
        if (arg3 == 0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::max_amount_in()) {
            0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::utils::transfer_balance<T1>(0x2::coin::into_balance<T1>(v5), 0x2::tx_context::sender(arg6), arg6);
        } else {
            0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v5));
        };
        0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v6));
        0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::utils::transfer_or_destroy_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v4, arg6);
        0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::emit_swap_event<T1, T0>(arg0, b"deepbookv3-router", 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), v1 - v7, 0x2::coin::value<T0>(&v6), v7);
    }

    // decompiled from Move bytecode v6
}

