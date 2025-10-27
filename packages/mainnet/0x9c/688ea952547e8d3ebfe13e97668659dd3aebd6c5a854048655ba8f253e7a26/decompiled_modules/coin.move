module 0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::coin {
    public fun join<T0>(arg0: &mut 0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<0x2::coin::Coin<T0>>, arg1: 0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<0x2::coin::Coin<T0>>) {
        0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::set_lock_end_timestamp_ms<0x2::coin::Coin<T0>>(arg0, 0x1::u64::max(0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::lock_end_timestamp_ms<0x2::coin::Coin<T0>>(arg0), 0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::lock_end_timestamp_ms<0x2::coin::Coin<T0>>(&arg1)));
        0x2::coin::join<T0>(0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::borrow_mut<0x2::coin::Coin<T0>>(arg0), 0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::force_unlock<0x2::coin::Coin<T0>>(arg1));
    }

    public fun split<T0>(arg0: &mut 0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<0x2::coin::Coin<T0>> {
        0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::new<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::borrow_mut<0x2::coin::Coin<T0>>(arg0), arg1, arg2), 0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::lock_end_timestamp_ms<0x2::coin::Coin<T0>>(arg0), arg2)
    }

    public fun value<T0>(arg0: &0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<0x2::coin::Coin<T0>>) : u64 {
        0x2::coin::value<T0>(0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::borrow<0x2::coin::Coin<T0>>(arg0))
    }

    public fun lock<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<0x2::coin::Coin<T0>> {
        0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::lock<0x2::coin::Coin<T0>>(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

