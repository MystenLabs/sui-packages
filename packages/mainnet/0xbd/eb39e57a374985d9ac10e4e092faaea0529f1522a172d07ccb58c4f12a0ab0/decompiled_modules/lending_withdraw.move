module 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::lending_withdraw {
    public fun withdraw<T0>(arg0: &mut 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::market::Market, arg1: 0x2::coin::Coin<0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::pool::PoolLpCoin<T0>>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::market::handle_withdraw<T0>(arg0, 0x2::coin::into_balance<0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::pool::PoolLpCoin<T0>>(arg1), 0x2::clock::timestamp_ms(arg2) / 1000), arg3)
    }

    // decompiled from Move bytecode v6
}

