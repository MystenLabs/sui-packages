module 0xd95433979e295b65b9a0aa943432a9a498c3a194aab0fe0ebd5d6ba546f9b0cb::dsw {
    public fun d3a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::coin::into_balance<T1>(0x2::coin::zero<T1>(arg3))
    }

    public fun zdcc(arg0: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0)
    }

    // decompiled from Move bytecode v6
}

