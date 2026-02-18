module 0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::coin {
    public fun join<T0>(arg0: &mut 0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::Locked<0x2::coin::Coin<T0>>, arg1: 0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::Locked<0x2::coin::Coin<T0>>) {
        0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::set_lock_end_timestamp_ms<0x2::coin::Coin<T0>>(arg0, 0x1::u64::max(0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::lock_end_timestamp_ms<0x2::coin::Coin<T0>>(arg0), 0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::lock_end_timestamp_ms<0x2::coin::Coin<T0>>(&arg1)));
        0x2::coin::join<T0>(0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::borrow_mut<0x2::coin::Coin<T0>>(arg0), 0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::force_unlock<0x2::coin::Coin<T0>>(arg1));
    }

    public fun split<T0>(arg0: &mut 0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::Locked<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::Locked<0x2::coin::Coin<T0>> {
        0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::new<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::borrow_mut<0x2::coin::Coin<T0>>(arg0), arg1, arg2), 0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::lock_end_timestamp_ms<0x2::coin::Coin<T0>>(arg0), arg2)
    }

    public fun value<T0>(arg0: &0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::Locked<0x2::coin::Coin<T0>>) : u64 {
        0x2::coin::value<T0>(0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::borrow<0x2::coin::Coin<T0>>(arg0))
    }

    public fun lock<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::Locked<0x2::coin::Coin<T0>> {
        0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked::lock<0x2::coin::Coin<T0>>(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

