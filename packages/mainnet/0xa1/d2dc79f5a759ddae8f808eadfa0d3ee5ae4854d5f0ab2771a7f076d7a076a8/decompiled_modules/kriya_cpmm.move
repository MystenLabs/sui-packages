module 0xa1d2dc79f5a759ddae8f808eadfa0d3ee5ae4854d5f0ab2771a7f076d7a076a8::kriya_cpmm {
    struct PoolInfo has copy, drop, store {
        reserve_x: u64,
        reserve_y: u64,
    }

    public fun get_pool_info<T0, T1>(arg0: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>) : (u64, u64) {
        let (v0, v1, _) = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::get_reserves<T0, T1>(arg0);
        let v3 = PoolInfo{
            reserve_x : v0,
            reserve_y : v1,
        };
        0x2::event::emit<PoolInfo>(v3);
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

