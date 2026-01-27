module 0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::turbos {
    struct Pool<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
    }

    public fun get_pool_current_index_as_u32<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : u32 {
        abort 0
    }

    public fun get_pool_fee<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : u32 {
        abort 0
    }

    public fun get_pool_liquidity<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : u128 {
        abort 0
    }

    public fun get_pool_sqrt_price<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : u128 {
        abort 0
    }

    public fun get_pool_unlocked<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : bool {
        abort 0
    }

    // decompiled from Move bytecode v6
}

