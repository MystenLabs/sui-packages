module 0x4e5c6becc249cf072528261fcae0e1a085efa9624bd3fe873f3fcc717f15e27a::magma {
    struct PoolInfo has copy, drop, store {
        pool_id: 0x2::object::ID,
        coin_a: u64,
        coin_b: u64,
        liquidity: u128,
        current_tick_index: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32,
        current_sqrt_price: u128,
        fee_rate: u64,
    }

    public fun get_pool_info<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>) {
        let (v0, v1) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::balances<T0, T1>(arg0);
        let v2 = PoolInfo{
            pool_id            : 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg0),
            coin_a             : v0,
            coin_b             : v1,
            liquidity          : 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::liquidity<T0, T1>(arg0),
            current_tick_index : 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg0),
            current_sqrt_price : 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0),
            fee_rate           : 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg0),
        };
        0x2::event::emit<PoolInfo>(v2);
    }

    // decompiled from Move bytecode v6
}

