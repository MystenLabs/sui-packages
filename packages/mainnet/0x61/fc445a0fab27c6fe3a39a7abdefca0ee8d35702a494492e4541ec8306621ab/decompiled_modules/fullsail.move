module 0x61fc445a0fab27c6fe3a39a7abdefca0ee8d35702a494492e4541ec8306621ab::fullsail {
    struct PoolInfo has copy, drop, store {
        pool_id: 0x2::object::ID,
        coin_a: u64,
        coin_b: u64,
        liquidity: u128,
        current_tick_index: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32,
        current_sqrt_price: u128,
        fee_rate: u64,
    }

    public fun get_pool_info<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>) {
        let (v0, v1) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::balances<T0, T1>(arg0);
        let v2 = PoolInfo{
            pool_id            : 0x2::object::id<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>>(arg0),
            coin_a             : v0,
            coin_b             : v1,
            liquidity          : 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::liquidity<T0, T1>(arg0),
            current_tick_index : 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_tick_index<T0, T1>(arg0),
            current_sqrt_price : 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_sqrt_price<T0, T1>(arg0),
            fee_rate           : 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::fee_rate<T0, T1>(arg0),
        };
        0x2::event::emit<PoolInfo>(v2);
    }

    // decompiled from Move bytecode v6
}

