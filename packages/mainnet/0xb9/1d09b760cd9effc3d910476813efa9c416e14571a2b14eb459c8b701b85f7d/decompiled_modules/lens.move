module 0xb91d09b760cd9effc3d910476813efa9c416e14571a2b14eb459c8b701b85f7d::lens {
    public fun get_kriya_pool<T0, T1>(arg0: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>) : vector<0xb91d09b760cd9effc3d910476813efa9c416e14571a2b14eb459c8b701b85f7d::dto::PoolData> {
        let (v0, v1, _) = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::get_reserves<T0, T1>(arg0);
        let v3 = 0x1::vector::empty<0xb91d09b760cd9effc3d910476813efa9c416e14571a2b14eb459c8b701b85f7d::dto::PoolData>();
        0x1::vector::push_back<0xb91d09b760cd9effc3d910476813efa9c416e14571a2b14eb459c8b701b85f7d::dto::PoolData>(&mut v3, 0xb91d09b760cd9effc3d910476813efa9c416e14571a2b14eb459c8b701b85f7d::dto::new(0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg0), v0, v1, 0, 0, 0, 0));
        v3
    }

    public fun get_turbos_pool<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>) : vector<0xb91d09b760cd9effc3d910476813efa9c416e14571a2b14eb459c8b701b85f7d::dto::PoolData> {
        let v0 = 0x1::vector::empty<0xb91d09b760cd9effc3d910476813efa9c416e14571a2b14eb459c8b701b85f7d::dto::PoolData>();
        0x1::vector::push_back<0xb91d09b760cd9effc3d910476813efa9c416e14571a2b14eb459c8b701b85f7d::dto::PoolData>(&mut v0, 0xb91d09b760cd9effc3d910476813efa9c416e14571a2b14eb459c8b701b85f7d::dto::new(0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0), 0, 0, 0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_liquidity<T0, T1, T2>(arg0), (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg0) as u64)));
        v0
    }

    // decompiled from Move bytecode v6
}

