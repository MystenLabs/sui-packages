module 0x75b931ee2c908ae7e9c4a4dfa0f0aa835ca8aaeaccacc4abe4c4b4525b4b56d8::dto {
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

