module 0xb91d09b760cd9effc3d910476813efa9c416e14571a2b14eb459c8b701b85f7d::dto {
    struct PoolData has drop, store {
        pool_id: 0x2::object::ID,
        reserve_a: u64,
        reserve_b: u64,
        tick_index: u32,
        sqrt_price: u128,
        liquidity: u128,
        fee_rate: u64,
    }

    public fun new(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u32, arg4: u128, arg5: u128, arg6: u64) : PoolData {
        PoolData{
            pool_id    : arg0,
            reserve_a  : arg1,
            reserve_b  : arg2,
            tick_index : arg3,
            sqrt_price : arg4,
            liquidity  : arg5,
            fee_rate   : arg6,
        }
    }

    // decompiled from Move bytecode v6
}

