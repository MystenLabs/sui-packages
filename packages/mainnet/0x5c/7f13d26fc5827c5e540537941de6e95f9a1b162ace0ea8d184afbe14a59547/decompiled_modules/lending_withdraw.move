module 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::lending_withdraw {
    public fun withdraw<T0>(arg0: &mut 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::market::Market, arg1: 0x2::coin::Coin<0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::pool::PoolLpCoin<T0>>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::market::handle_withdraw<T0>(arg0, 0x2::coin::into_balance<0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::pool::PoolLpCoin<T0>>(arg1), 0x2::clock::timestamp_ms(arg2) / 1000), arg3)
    }

    // decompiled from Move bytecode v6
}

