module 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::deepbook {
    struct DeepBookAdapter has drop {
        dummy_field: bool,
    }

    public fun base_to_quote<T0, T1, T2, T3>(arg0: &0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::AgentPass, arg1: &0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry::Registry, arg2: 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::Swap<T0, T1, T2>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::Swap<T0, T1, T3> {
        let v0 = DeepBookAdapter{dummy_field: false};
        let (v1, v2, v3) = 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::lend<DeepBookAdapter, T0, T1, T2>(arg0, arg1, arg2, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T2, T3>(arg3), v0);
        let (v4, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T2, T3>(arg3, 0x2::coin::from_balance<T2>(v2, arg5), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5), 0, arg4, arg5);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v6);
        let v7 = DeepBookAdapter{dummy_field: false};
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::repay<DeepBookAdapter, T0, T1, T2, T3>(arg0, v1, v3, 0x2::coin::into_balance<T2>(v4), 0x2::coin::into_balance<T3>(v5), v7)
    }

    public fun quote_to_base<T0, T1, T2, T3>(arg0: &0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::AgentPass, arg1: &0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry::Registry, arg2: 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::Swap<T0, T1, T3>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::Swap<T0, T1, T2> {
        let v0 = DeepBookAdapter{dummy_field: false};
        let (v1, v2, v3) = 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::lend<DeepBookAdapter, T0, T1, T3>(arg0, arg1, arg2, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T2, T3>(arg3), v0);
        let (v4, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T2, T3>(arg3, 0x2::coin::from_balance<T3>(v2, arg5), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5), 0, arg4, arg5);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v6);
        let v7 = DeepBookAdapter{dummy_field: false};
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::repay<DeepBookAdapter, T0, T1, T3, T2>(arg0, v1, v3, 0x2::coin::into_balance<T3>(v5), 0x2::coin::into_balance<T2>(v4), v7)
    }

    // decompiled from Move bytecode v7
}

