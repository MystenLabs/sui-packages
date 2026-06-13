module 0xa064bc34d5a434ffda59aa78ffa44520ce0c37a0904a5e2b0e22e5087d940e86::deepbookv3 {
    public fun swap<T0, T1>(arg0: &mut 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::SwapContext, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: bool, arg4: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
        };
    }

    public fun add_deep_price_point<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg2: &mut 0x2::clock::Clock) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::add_deep_price_point<T0, T1, T2, T3>(arg0, arg1, arg2);
    }

    public fun add_deep_price_point_v2<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg2: &0x2::clock::Clock) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::add_deep_price_point<T0, T1, T2, T3>(arg0, arg1, arg2);
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::SwapContext, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::take_balance<T0>(arg0, arg2);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::transfer_or_destroy_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, arg5);
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v2, v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg1, 0x2::coin::from_balance<T0>(v0, arg5), arg3, 0, arg4, arg5);
        let v5 = v3;
        let v6 = v2;
        let v7 = 0x2::coin::value<T0>(&v6);
        if (arg2 == 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::max_amount_in()) {
            0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::transfer_balance<T0>(0x2::coin::into_balance<T0>(v6), 0x2::tx_context::sender(arg5), arg5);
        } else {
            0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v6));
        };
        0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v5));
        0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::transfer_or_destroy_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v4, arg5);
        0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::emit_swap_event<T0, T1>(arg0, b"DEEPBOOKV3", 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), v1 - v7, 0x2::coin::value<T1>(&v5), v7);
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::SwapContext, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::take_balance<T1>(arg0, arg2);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::transfer_or_destroy_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, arg5);
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v2, v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg1, 0x2::coin::from_balance<T1>(v0, arg5), arg3, 0, arg4, arg5);
        let v5 = v3;
        let v6 = v2;
        let v7 = 0x2::coin::value<T1>(&v5);
        if (arg2 == 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::max_amount_in()) {
            0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::transfer_balance<T1>(0x2::coin::into_balance<T1>(v5), 0x2::tx_context::sender(arg5), arg5);
        } else {
            0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v5));
        };
        0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v6));
        0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::transfer_or_destroy_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v4, arg5);
        0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::emit_swap_event<T1, T0>(arg0, b"DEEPBOOKV3", 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), v1 - v7, 0x2::coin::value<T0>(&v6), v7);
    }

    // decompiled from Move bytecode v7
}

