module 0x913dd03cb2686a086c4b0cbdea5c8b16191c1299c32ddec9641df3d863edbdbb::withdraw {
    public fun withdraw<T0, T1>(arg0: &0x913dd03cb2686a086c4b0cbdea5c8b16191c1299c32ddec9641df3d863edbdbb::app::ProtocolApp, arg1: &mut 0x913dd03cb2686a086c4b0cbdea5c8b16191c1299c32ddec9641df3d863edbdbb::market::Market<T0>, arg2: &0x913dd03cb2686a086c4b0cbdea5c8b16191c1299c32ddec9641df3d863edbdbb::obligation::ObligationOwnerCap, arg3: &0x913dd03cb2686a086c4b0cbdea5c8b16191c1299c32ddec9641df3d863edbdbb::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun withdraw_as_coin<T0, T1>(arg0: &0x913dd03cb2686a086c4b0cbdea5c8b16191c1299c32ddec9641df3d863edbdbb::app::ProtocolApp, arg1: &mut 0x913dd03cb2686a086c4b0cbdea5c8b16191c1299c32ddec9641df3d863edbdbb::market::Market<T0>, arg2: &0x913dd03cb2686a086c4b0cbdea5c8b16191c1299c32ddec9641df3d863edbdbb::obligation::ObligationOwnerCap, arg3: &0x913dd03cb2686a086c4b0cbdea5c8b16191c1299c32ddec9641df3d863edbdbb::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 0
    }

    // decompiled from Move bytecode v7
}

