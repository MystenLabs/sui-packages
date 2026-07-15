module 0xca22b09fd3a6a9f93f090f5c4aa17c5e369fac16839f5575cfd2f582d17ba398::d {
    fun seq<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg0, arg1, arg2, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5), arg3, arg4, arg5);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2);
        (v0, v1)
    }

    public fun sxy<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::zero<T1>(arg3);
        let (v1, v2) = seq<T0, T1>(arg0, arg1, v0, 0, arg2, arg3);
        0xca22b09fd3a6a9f93f090f5c4aa17c5e369fac16839f5575cfd2f582d17ba398::u::tod<T0>(v1, 0x2::tx_context::sender(arg3));
        v2
    }

    public fun syx<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg3);
        let (v1, v2) = seq<T0, T1>(arg0, v0, arg1, 0, arg2, arg3);
        0xca22b09fd3a6a9f93f090f5c4aa17c5e369fac16839f5575cfd2f582d17ba398::u::tod<T1>(v2, 0x2::tx_context::sender(arg3));
        v1
    }

    // decompiled from Move bytecode v7
}

