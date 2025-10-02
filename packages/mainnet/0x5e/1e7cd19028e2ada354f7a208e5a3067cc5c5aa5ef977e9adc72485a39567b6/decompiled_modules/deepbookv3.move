module 0x5e1e7cd19028e2ada354f7a208e5a3067cc5c5aa5ef977e9adc72485a39567b6::deepbookv3 {
    public fun swap<T0, T1>(arg0: &mut 0x5e1e7cd19028e2ada354f7a208e5a3067cc5c5aa5ef977e9adc72485a39567b6::swap_context::SwapContext, arg1: &mut 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::GlobalConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5);
        if (arg3) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, v0, arg4, arg5);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, v0, arg4, arg5);
        };
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x5e1e7cd19028e2ada354f7a208e5a3067cc5c5aa5ef977e9adc72485a39567b6::swap_context::SwapContext, arg1: &mut 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::GlobalConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5e1e7cd19028e2ada354f7a208e5a3067cc5c5aa5ef977e9adc72485a39567b6::swap_context::take_balance<T0>(arg0);
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x5e1e7cd19028e2ada354f7a208e5a3067cc5c5aa5ef977e9adc72485a39567b6::swap_context::transfer_or_destroy_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, arg5);
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v1, v2, v3) = 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::deepbook_v3::swap_a2b_<T0, T1>(arg1, arg2, 0x2::coin::from_balance<T0>(v0, arg5), arg3, arg4, arg5);
        0x5e1e7cd19028e2ada354f7a208e5a3067cc5c5aa5ef977e9adc72485a39567b6::swap_context::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v1));
        0x5e1e7cd19028e2ada354f7a208e5a3067cc5c5aa5ef977e9adc72485a39567b6::swap_context::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2));
        0x5e1e7cd19028e2ada354f7a208e5a3067cc5c5aa5ef977e9adc72485a39567b6::swap_context::transfer_or_destroy_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v3, arg5);
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x5e1e7cd19028e2ada354f7a208e5a3067cc5c5aa5ef977e9adc72485a39567b6::swap_context::SwapContext, arg1: &mut 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::GlobalConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5e1e7cd19028e2ada354f7a208e5a3067cc5c5aa5ef977e9adc72485a39567b6::swap_context::take_balance<T1>(arg0);
        if (0x2::balance::value<T1>(&v0) == 0) {
            0x5e1e7cd19028e2ada354f7a208e5a3067cc5c5aa5ef977e9adc72485a39567b6::swap_context::transfer_or_destroy_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, arg5);
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v1, v2, v3) = 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::deepbook_v3::swap_b2a_<T0, T1>(arg1, arg2, 0x2::coin::from_balance<T1>(v0, arg5), arg3, arg4, arg5);
        0x5e1e7cd19028e2ada354f7a208e5a3067cc5c5aa5ef977e9adc72485a39567b6::swap_context::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2));
        0x5e1e7cd19028e2ada354f7a208e5a3067cc5c5aa5ef977e9adc72485a39567b6::swap_context::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v1));
        0x5e1e7cd19028e2ada354f7a208e5a3067cc5c5aa5ef977e9adc72485a39567b6::swap_context::transfer_or_destroy_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v3, arg5);
    }

    // decompiled from Move bytecode v6
}

