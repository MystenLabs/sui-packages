module 0x4f4b051ac98c6bebf546b4c6144183e4227b21bda6ea3758df8cdfcf10773c84::types {
    struct PoolSnapshot has copy, drop, store {
        pool_id: address,
        dex_type: u8,
        sqrt_price: u128,
        liquidity: u128,
        current_tick_abs: u32,
        tick_is_positive: bool,
        reserve_a: u64,
        reserve_b: u64,
        fee_rate: u64,
        tick_spacing: u32,
        is_paused: bool,
    }

    struct PoolReadRequest has copy, drop, store {
        pool_id: address,
        dex_type: u8,
    }

    struct BatchReadResult has copy, drop, store {
        snapshots: vector<PoolSnapshot>,
        failed_count: u64,
    }

    public fun abs_and_sign_to_i32(arg0: u32, arg1: bool) : u32 {
        if (arg1) {
            arg0
        } else {
            (arg0 ^ 4294967295) + 1
        }
    }

    public fun add_snapshot(arg0: &mut BatchReadResult, arg1: PoolSnapshot) {
        0x1::vector::push_back<PoolSnapshot>(&mut arg0.snapshots, arg1);
    }

    public fun current_tick_abs(arg0: &PoolSnapshot) : u32 {
        arg0.current_tick_abs
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

    public fun dex_kriya_clmm() : u8 {
        4
    }

    public fun dex_momentum() : u8 {
        2
    }

    public fun dex_turbos() : u8 {
        5
    }

    public fun dex_type(arg0: &PoolSnapshot) : u8 {
        arg0.dex_type
    }

    public fun failed_count(arg0: &BatchReadResult) : u64 {
        arg0.failed_count
    }

    public fun fee_rate(arg0: &PoolSnapshot) : u64 {
        arg0.fee_rate
    }

    public fun i32_to_abs_and_sign(arg0: u32) : (u32, bool) {
        if (arg0 & 2147483648 != 0) {
            ((arg0 ^ 4294967295) + 1, false)
        } else {
            (arg0, true)
        }
    }

    public fun increment_failed(arg0: &mut BatchReadResult) {
        arg0.failed_count = arg0.failed_count + 1;
    }

    public fun is_paused(arg0: &PoolSnapshot) : bool {
        arg0.is_paused
    }

    public fun liquidity(arg0: &PoolSnapshot) : u128 {
        arg0.liquidity
    }

    public fun new_batch_result() : BatchReadResult {
        BatchReadResult{
            snapshots    : 0x1::vector::empty<PoolSnapshot>(),
            failed_count : 0,
        }
    }

    public fun new_read_request(arg0: address, arg1: u8) : PoolReadRequest {
        PoolReadRequest{
            pool_id  : arg0,
            dex_type : arg1,
        }
    }

    public fun new_snapshot(arg0: address, arg1: u8, arg2: u128, arg3: u128, arg4: u32, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: u32, arg10: bool) : PoolSnapshot {
        PoolSnapshot{
            pool_id          : arg0,
            dex_type         : arg1,
            sqrt_price       : arg2,
            liquidity        : arg3,
            current_tick_abs : arg4,
            tick_is_positive : arg5,
            reserve_a        : arg6,
            reserve_b        : arg7,
            fee_rate         : arg8,
            tick_spacing     : arg9,
            is_paused        : arg10,
        }
    }

    public fun pool_id(arg0: &PoolSnapshot) : address {
        arg0.pool_id
    }

    public fun reserve_a(arg0: &PoolSnapshot) : u64 {
        arg0.reserve_a
    }

    public fun reserve_b(arg0: &PoolSnapshot) : u64 {
        arg0.reserve_b
    }

    public fun snapshots(arg0: &BatchReadResult) : &vector<PoolSnapshot> {
        &arg0.snapshots
    }

    public fun sqrt_price(arg0: &PoolSnapshot) : u128 {
        arg0.sqrt_price
    }

    public fun tick_is_positive(arg0: &PoolSnapshot) : bool {
        arg0.tick_is_positive
    }

    public fun tick_spacing(arg0: &PoolSnapshot) : u32 {
        arg0.tick_spacing
    }

    // decompiled from Move bytecode v6
}

