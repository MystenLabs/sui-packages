module 0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::coin {
    public fun join<T0>(arg0: &mut 0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::Locked<0x2::coin::Coin<T0>>, arg1: 0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::Locked<0x2::coin::Coin<T0>>) {
        0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::set_lock_end_timestamp_ms<0x2::coin::Coin<T0>>(arg0, 0x1::u64::max(0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::lock_end_timestamp_ms<0x2::coin::Coin<T0>>(arg0), 0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::lock_end_timestamp_ms<0x2::coin::Coin<T0>>(&arg1)));
        0x2::coin::join<T0>(0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::borrow_mut<0x2::coin::Coin<T0>>(arg0), 0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::force_unlock<0x2::coin::Coin<T0>>(arg1));
    }

    public fun split<T0>(arg0: &mut 0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::Locked<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::Locked<0x2::coin::Coin<T0>> {
        0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::new<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::borrow_mut<0x2::coin::Coin<T0>>(arg0), arg1, arg2), 0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::lock_end_timestamp_ms<0x2::coin::Coin<T0>>(arg0), arg2)
    }

    public fun value<T0>(arg0: &0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::Locked<0x2::coin::Coin<T0>>) : u64 {
        0x2::coin::value<T0>(0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::borrow<0x2::coin::Coin<T0>>(arg0))
    }

    public fun lock<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::Locked<0x2::coin::Coin<T0>> {
        0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::lock<0x2::coin::Coin<T0>>(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

