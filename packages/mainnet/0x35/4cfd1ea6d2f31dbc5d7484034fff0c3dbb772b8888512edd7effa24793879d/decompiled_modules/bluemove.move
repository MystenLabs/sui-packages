module 0x354cfd1ea6d2f31dbc5d7484034fff0c3dbb772b8888512edd7effa24793879d::bluemove {
    struct PoolInfo has copy, drop, store {
        reserve_x: u64,
        reserve_y: u64,
    }

    public fun get_pool_info<T0, T1>(arg0: &0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Pool<T0, T1>) : (u64, u64) {
        let (v0, v1) = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::token_reserves<T0, T1>(arg0);
        let v2 = PoolInfo{
            reserve_x : v0,
            reserve_y : v1,
        };
        0x2::event::emit<PoolInfo>(v2);
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

