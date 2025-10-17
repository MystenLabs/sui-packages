module 0x89beb747facc3d538ce8d8481ac62c8d88969804d73a085fa51fafb3c298582::dsw {
    public fun d3a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::coin::into_balance<T1>(0x2::coin::zero<T1>(arg2))
    }

    public fun zdcc(arg0: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0)
    }

    // decompiled from Move bytecode v6
}

