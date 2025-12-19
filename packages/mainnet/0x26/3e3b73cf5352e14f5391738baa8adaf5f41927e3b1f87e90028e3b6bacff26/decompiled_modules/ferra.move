module 0x263e3b73cf5352e14f5391738baa8adaf5f41927e3b1f87e90028e3b6bacff26::ferra {
    struct PoolInfo has copy, drop, store {
        pool_id: 0x2::object::ID,
        coin_a: u64,
        coin_b: u64,
        liquidity: u128,
        current_tick_index: 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::I32,
        current_sqrt_price: u128,
        fee_rate: u64,
    }

    public fun get_pool_info<T0, T1>(arg0: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>) {
        let (v0, v1) = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::balances<T0, T1>(arg0);
        let v2 = PoolInfo{
            pool_id            : 0x2::object::id<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>>(arg0),
            coin_a             : 0x2::balance::value<T0>(v0),
            coin_b             : 0x2::balance::value<T1>(v1),
            liquidity          : 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::liquidity<T0, T1>(arg0),
            current_tick_index : 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::current_tick_index<T0, T1>(arg0),
            current_sqrt_price : 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::current_sqrt_price<T0, T1>(arg0),
            fee_rate           : 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::fee_rate<T0, T1>(arg0),
        };
        0x2::event::emit<PoolInfo>(v2);
    }

    // decompiled from Move bytecode v6
}

