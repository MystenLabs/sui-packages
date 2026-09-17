module 0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::r_deepbook {
    public fun a2b<T0, T1>(arg0: &mut 0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::Session, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::assert_decided(arg0);
        if (!0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::armed(arg0)) {
            return 0x2::coin::zero<T0>(arg4)
        };
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg1, 0x2::coin::from_balance<T0>(0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::take<T0>(arg0, arg2), arg4), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), 0, arg3, arg4);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2);
        0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::put<T1>(arg0, arg2 + 1, 0x2::coin::into_balance<T1>(v1));
        v0
    }

    public fun b2a<T0, T1>(arg0: &mut 0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::Session, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::assert_decided(arg0);
        if (!0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::armed(arg0)) {
            return 0x2::coin::zero<T1>(arg4)
        };
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg1, 0x2::coin::from_balance<T1>(0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::take<T1>(arg0, arg2), arg4), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), 0, arg3, arg4);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2);
        0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::put<T0>(arg0, arg2 + 1, 0x2::coin::into_balance<T0>(v0));
        v1
    }

    // decompiled from Move bytecode v7
}

