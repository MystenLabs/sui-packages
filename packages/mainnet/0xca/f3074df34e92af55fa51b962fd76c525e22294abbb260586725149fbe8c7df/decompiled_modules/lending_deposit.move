module 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::lending_deposit {
    public fun deposit<T0>(arg0: &mut 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::market::Market, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::pool::PoolLpCoin<T0>> {
        0x2::coin::from_balance<0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::pool::PoolLpCoin<T0>>(0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::market::handle_deposit<T0>(arg0, 0x2::coin::into_balance<T0>(arg1), 0x2::clock::timestamp_ms(arg2) / 1000), arg3)
    }

    // decompiled from Move bytecode v6
}

