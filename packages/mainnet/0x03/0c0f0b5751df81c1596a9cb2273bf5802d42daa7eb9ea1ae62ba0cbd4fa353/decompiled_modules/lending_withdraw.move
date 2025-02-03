module 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::lending_withdraw {
    public fun withdraw<T0>(arg0: &mut 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::market::Market, arg1: 0x2::coin::Coin<0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::pool::PoolLpCoin<T0>>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::market::handle_withdraw<T0>(arg0, 0x2::coin::into_balance<0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::pool::PoolLpCoin<T0>>(arg1), 0x2::clock::timestamp_ms(arg2) / 1000), arg3)
    }

    // decompiled from Move bytecode v6
}

