module 0x4d7ab849c4dc9bcf6300672420777c48beadac45da6568d624919901208c9922::dsw {
    public fun d3a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::coin::into_balance<T1>(0x2::coin::zero<T1>(arg3))
    }

    // decompiled from Move bytecode v6
}

