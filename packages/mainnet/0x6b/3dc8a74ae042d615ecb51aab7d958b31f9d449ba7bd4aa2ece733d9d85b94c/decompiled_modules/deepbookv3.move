module 0x6b3dc8a74ae042d615ecb51aab7d958b31f9d449ba7bd4aa2ece733d9d85b94c::deepbookv3 {
    public fun swap_a2b<T0, T1>(arg0: &mut 0x9caccba6a5e9570a7cd712fc849daff8a0290874d4e4bcc046391b9620a253c9::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::value<T0>(&arg2);
        let (v0, v1, v2) = 0x9caccba6a5e9570a7cd712fc849daff8a0290874d4e4bcc046391b9620a253c9::deepbook_v3::swap_a2b_<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        transfer_or_destroy_coin<T0>(v0, arg5);
        transfer_or_destroy_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2, arg5);
        v1
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x9caccba6a5e9570a7cd712fc849daff8a0290874d4e4bcc046391b9620a253c9::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x9caccba6a5e9570a7cd712fc849daff8a0290874d4e4bcc046391b9620a253c9::deepbook_v3::swap_b2a_<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        transfer_or_destroy_coin<T1>(v1, arg5);
        transfer_or_destroy_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2, arg5);
        v0
    }

    public fun transfer_or_destroy_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

