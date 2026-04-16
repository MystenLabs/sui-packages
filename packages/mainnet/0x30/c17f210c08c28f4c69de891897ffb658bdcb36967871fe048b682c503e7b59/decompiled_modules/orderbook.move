module 0x30c17f210c08c28f4c69de891897ffb658bdcb36967871fe048b682c503e7b59::orderbook {
    public fun deepbook_swap_exact_base_for_quote<T0, T1, T2>(arg0: &mut 0x7f5dd4a0881b6016f904d74f736d482ec32364f8a4d1d93d98437b200d37fd03::execution::Session<T0, 0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg1: u64, arg2: u64, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T1, T2>(arg3, arg4, arg5, 0, arg6, arg7);
        let v3 = v2;
        let v4 = v1;
        0x7f5dd4a0881b6016f904d74f736d482ec32364f8a4d1d93d98437b200d37fd03::execution::refund_aux<T0, 0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, T1>(arg0, v0);
        if (0x7f5dd4a0881b6016f904d74f736d482ec32364f8a4d1d93d98437b200d37fd03::execution::uses_deep_pricing<T0, 0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0)) {
            let v5 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg3);
            0x7f5dd4a0881b6016f904d74f736d482ec32364f8a4d1d93d98437b200d37fd03::execution::record_leg_with_deep<T0, 0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, T1, T2>(arg0, arg1, 4, 0x2::object::id_to_address(&v5), arg2, 0x2::coin::value<T2>(&v4), 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v3));
        } else {
            let v6 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg3);
            0x7f5dd4a0881b6016f904d74f736d482ec32364f8a4d1d93d98437b200d37fd03::execution::record_leg<T0, 0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, T1, T2>(arg0, arg1, 4, 0x2::object::id_to_address(&v6), arg2, 0x2::coin::value<T2>(&v4));
        };
        (v4, v3)
    }

    public fun deepbook_swap_exact_quote_for_base<T0, T1, T2>(arg0: &mut 0x7f5dd4a0881b6016f904d74f736d482ec32364f8a4d1d93d98437b200d37fd03::execution::Session<T0, 0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg1: u64, arg2: u64, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: 0x2::coin::Coin<T2>, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T1, T2>(arg3, arg4, arg5, 0, arg6, arg7);
        let v3 = v2;
        let v4 = v0;
        0x7f5dd4a0881b6016f904d74f736d482ec32364f8a4d1d93d98437b200d37fd03::execution::refund_aux<T0, 0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, T2>(arg0, v1);
        if (0x7f5dd4a0881b6016f904d74f736d482ec32364f8a4d1d93d98437b200d37fd03::execution::uses_deep_pricing<T0, 0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0)) {
            let v5 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg3);
            0x7f5dd4a0881b6016f904d74f736d482ec32364f8a4d1d93d98437b200d37fd03::execution::record_leg_with_deep<T0, 0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, T2, T1>(arg0, arg1, 4, 0x2::object::id_to_address(&v5), arg2, 0x2::coin::value<T1>(&v4), 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v3));
        } else {
            let v6 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg3);
            0x7f5dd4a0881b6016f904d74f736d482ec32364f8a4d1d93d98437b200d37fd03::execution::record_leg<T0, 0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, T2, T1>(arg0, arg1, 4, 0x2::object::id_to_address(&v6), arg2, 0x2::coin::value<T1>(&v4));
        };
        (v4, v3)
    }

    // decompiled from Move bytecode v6
}

