module 0x30ecd56002e40d0c740544f4ae8a63c87500088243ef78cda5fdc683ba2ed21::bluemove {
    struct PoolInfo has copy, drop, store {
        reserve_x: u64,
        reserve_y: u64,
    }

    public fun get_pool_info<T0, T1>(arg0: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info) : (u64, u64) {
        let (v0, v1) = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::token_reserves<T0, T1>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::get_pool<T0, T1>(arg0));
        let v2 = PoolInfo{
            reserve_x : v0,
            reserve_y : v1,
        };
        0x2::event::emit<PoolInfo>(v2);
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

