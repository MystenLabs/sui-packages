module 0x31cdf35e684be4ff48e360b7250e65a1672a947e09fb8d43da4706d11bfeeb95::coin {
    public fun join<T0>(arg0: &mut 0x31cdf35e684be4ff48e360b7250e65a1672a947e09fb8d43da4706d11bfeeb95::locked::Locked<0x2::coin::Coin<T0>>, arg1: 0x31cdf35e684be4ff48e360b7250e65a1672a947e09fb8d43da4706d11bfeeb95::locked::Locked<0x2::coin::Coin<T0>>) {
        0x31cdf35e684be4ff48e360b7250e65a1672a947e09fb8d43da4706d11bfeeb95::locked::set_lock_end_timestamp_ms<0x2::coin::Coin<T0>>(arg0, 0x1::u64::max(0x31cdf35e684be4ff48e360b7250e65a1672a947e09fb8d43da4706d11bfeeb95::locked::lock_end_timestamp_ms<0x2::coin::Coin<T0>>(arg0), 0x31cdf35e684be4ff48e360b7250e65a1672a947e09fb8d43da4706d11bfeeb95::locked::lock_end_timestamp_ms<0x2::coin::Coin<T0>>(&arg1)));
        0x2::coin::join<T0>(0x31cdf35e684be4ff48e360b7250e65a1672a947e09fb8d43da4706d11bfeeb95::locked::borrow_mut<0x2::coin::Coin<T0>>(arg0), 0x31cdf35e684be4ff48e360b7250e65a1672a947e09fb8d43da4706d11bfeeb95::locked::force_unlock<0x2::coin::Coin<T0>>(arg1));
    }

    public fun split<T0>(arg0: &mut 0x31cdf35e684be4ff48e360b7250e65a1672a947e09fb8d43da4706d11bfeeb95::locked::Locked<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x31cdf35e684be4ff48e360b7250e65a1672a947e09fb8d43da4706d11bfeeb95::locked::Locked<0x2::coin::Coin<T0>> {
        0x31cdf35e684be4ff48e360b7250e65a1672a947e09fb8d43da4706d11bfeeb95::locked::new<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(0x31cdf35e684be4ff48e360b7250e65a1672a947e09fb8d43da4706d11bfeeb95::locked::borrow_mut<0x2::coin::Coin<T0>>(arg0), arg1, arg2), 0x31cdf35e684be4ff48e360b7250e65a1672a947e09fb8d43da4706d11bfeeb95::locked::lock_end_timestamp_ms<0x2::coin::Coin<T0>>(arg0), arg2)
    }

    public fun value<T0>(arg0: &0x31cdf35e684be4ff48e360b7250e65a1672a947e09fb8d43da4706d11bfeeb95::locked::Locked<0x2::coin::Coin<T0>>) : u64 {
        0x2::coin::value<T0>(0x31cdf35e684be4ff48e360b7250e65a1672a947e09fb8d43da4706d11bfeeb95::locked::borrow<0x2::coin::Coin<T0>>(arg0))
    }

    public fun lock<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x31cdf35e684be4ff48e360b7250e65a1672a947e09fb8d43da4706d11bfeeb95::locked::Locked<0x2::coin::Coin<T0>> {
        0x31cdf35e684be4ff48e360b7250e65a1672a947e09fb8d43da4706d11bfeeb95::locked::lock<0x2::coin::Coin<T0>>(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

