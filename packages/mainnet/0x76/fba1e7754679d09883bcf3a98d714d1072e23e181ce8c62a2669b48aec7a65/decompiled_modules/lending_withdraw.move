module 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::lending_withdraw {
    public fun withdraw<T0>(arg0: &mut 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::market::Market, arg1: 0x2::coin::Coin<0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::pool::PoolLpCoin<T0>>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::market::handle_withdraw<T0>(arg0, 0x2::coin::into_balance<0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::pool::PoolLpCoin<T0>>(arg1), 0x2::clock::timestamp_ms(arg2) / 1000), arg3)
    }

    // decompiled from Move bytecode v6
}

