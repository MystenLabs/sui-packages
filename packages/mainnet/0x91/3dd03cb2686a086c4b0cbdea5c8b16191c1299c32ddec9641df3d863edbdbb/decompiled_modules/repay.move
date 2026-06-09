module 0x913dd03cb2686a086c4b0cbdea5c8b16191c1299c32ddec9641df3d863edbdbb::repay {
    public fun repay<T0, T1>(arg0: &0x913dd03cb2686a086c4b0cbdea5c8b16191c1299c32ddec9641df3d863edbdbb::app::ProtocolApp, arg1: &0x913dd03cb2686a086c4b0cbdea5c8b16191c1299c32ddec9641df3d863edbdbb::obligation::ObligationOwnerCap, arg2: &mut 0x913dd03cb2686a086c4b0cbdea5c8b16191c1299c32ddec9641df3d863edbdbb::market::Market<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun repay_coin_refund<T0, T1>(arg0: &0x913dd03cb2686a086c4b0cbdea5c8b16191c1299c32ddec9641df3d863edbdbb::app::ProtocolApp, arg1: &0x913dd03cb2686a086c4b0cbdea5c8b16191c1299c32ddec9641df3d863edbdbb::obligation::ObligationOwnerCap, arg2: &mut 0x913dd03cb2686a086c4b0cbdea5c8b16191c1299c32ddec9641df3d863edbdbb::market::Market<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 0
    }

    // decompiled from Move bytecode v7
}

