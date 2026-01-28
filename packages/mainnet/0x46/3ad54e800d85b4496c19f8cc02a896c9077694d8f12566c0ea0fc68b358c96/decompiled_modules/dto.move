module 0x463ad54e800d85b4496c19f8cc02a896c9077694d8f12566c0ea0fc68b358c96::dto {
    struct RawPoolState has copy, drop, store {
        pool_id: 0x2::object::ID,
        sqrt_price: u128,
        current_tick: u32,
        liquidity: u128,
        fee_rate: u64,
        is_paused: bool,
    }

    public fun current_tick(arg0: &RawPoolState) : u32 {
        arg0.current_tick
    }

    public fun fee_rate(arg0: &RawPoolState) : u64 {
        arg0.fee_rate
    }

    public fun is_paused(arg0: &RawPoolState) : bool {
        arg0.is_paused
    }

    public fun liquidity(arg0: &RawPoolState) : u128 {
        arg0.liquidity
    }

    public fun new(arg0: 0x2::object::ID, arg1: u128, arg2: u32, arg3: u128, arg4: u64, arg5: bool) : RawPoolState {
        RawPoolState{
            pool_id      : arg0,
            sqrt_price   : arg1,
            current_tick : arg2,
            liquidity    : arg3,
            fee_rate     : arg4,
            is_paused    : arg5,
        }
    }

    public fun pool_id(arg0: &RawPoolState) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun sqrt_price(arg0: &RawPoolState) : u128 {
        arg0.sqrt_price
    }

    // decompiled from Move bytecode v6
}

