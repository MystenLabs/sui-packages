module 0x30ecd56002e40d0c740544f4ae8a63c87500088243ef78cda5fdc683ba2ed21::kriya_cpmm {
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

