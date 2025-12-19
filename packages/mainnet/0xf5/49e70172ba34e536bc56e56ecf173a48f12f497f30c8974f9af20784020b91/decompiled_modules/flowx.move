module 0xf549e70172ba34e536bc56e56ecf173a48f12f497f30c8974f9af20784020b91::flowx {
    struct PoolInfo has copy, drop, store {
        pool_id: 0x2::object::ID,
        coin_a: u64,
        coin_b: u64,
        liquidity: u128,
        current_tick_index: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32,
        current_sqrt_price: u128,
        fee_rate: u64,
    }

    public fun fetch_ticks_with_event<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::tick_index_current<T0, T1>(arg0);
        let (v1, v2) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::reserves<T0, T1>(arg0);
        let v3 = PoolInfo{
            pool_id            : 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>>(arg0),
            coin_a             : v1,
            coin_b             : v2,
            liquidity          : 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::liquidity<T0, T1>(arg0),
            current_tick_index : v0,
            current_sqrt_price : 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::get_sqrt_price_at_tick(v0),
            fee_rate           : 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_fee_rate<T0, T1>(arg0),
        };
        0x2::event::emit<PoolInfo>(v3);
    }

    // decompiled from Move bytecode v6
}

