module 0x4f4b051ac98c6bebf546b4c6144183e4227b21bda6ea3758df8cdfcf10773c84::standalone_types {
    struct PoolData has copy, drop {
        pool_id: address,
        dex_type: u8,
        sqrt_price: u128,
        liquidity: u128,
        tick_bits: u32,
        reserve_a: u64,
        reserve_b: u64,
        fee_rate: u64,
        tick_spacing: u32,
    }

    public fun dex_bluefin() : u8 {
        1
    }

    public fun dex_cetus() : u8 {
        0
    }

    public fun dex_kriya() : u8 {
        3
    }

    public fun dex_momentum() : u8 {
        2
    }

    public fun dex_type(arg0: &PoolData) : u8 {
        arg0.dex_type
    }

    public fun fee_rate(arg0: &PoolData) : u64 {
        arg0.fee_rate
    }

    public fun liquidity(arg0: &PoolData) : u128 {
        arg0.liquidity
    }

    public fun new_pool_data(arg0: address, arg1: u8, arg2: u128, arg3: u128, arg4: u32, arg5: u64, arg6: u64, arg7: u64, arg8: u32) : PoolData {
        PoolData{
            pool_id      : arg0,
            dex_type     : arg1,
            sqrt_price   : arg2,
            liquidity    : arg3,
            tick_bits    : arg4,
            reserve_a    : arg5,
            reserve_b    : arg6,
            fee_rate     : arg7,
            tick_spacing : arg8,
        }
    }

    public fun pool_id(arg0: &PoolData) : address {
        arg0.pool_id
    }

    public fun reserve_a(arg0: &PoolData) : u64 {
        arg0.reserve_a
    }

    public fun reserve_b(arg0: &PoolData) : u64 {
        arg0.reserve_b
    }

    public fun sqrt_price(arg0: &PoolData) : u128 {
        arg0.sqrt_price
    }

    public fun tick_bits(arg0: &PoolData) : u32 {
        arg0.tick_bits
    }

    public fun tick_spacing(arg0: &PoolData) : u32 {
        arg0.tick_spacing
    }

    public fun tick_to_signed(arg0: u32) : (u32, bool) {
        if (arg0 & 2147483648 != 0) {
            ((arg0 ^ 4294967295) + 1, false)
        } else {
            (arg0, true)
        }
    }

    // decompiled from Move bytecode v6
}

