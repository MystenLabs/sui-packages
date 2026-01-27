module 0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::bluefin {
    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
    }

    public fun current_sqrt_price<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        abort 0
    }

    public fun current_tick_index_as_u32<T0, T1>(arg0: &Pool<T0, T1>) : u32 {
        abort 0
    }

    public fun get_fee_rate<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        abort 0
    }

    public fun liquidity<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        abort 0
    }

    // decompiled from Move bytecode v6
}

