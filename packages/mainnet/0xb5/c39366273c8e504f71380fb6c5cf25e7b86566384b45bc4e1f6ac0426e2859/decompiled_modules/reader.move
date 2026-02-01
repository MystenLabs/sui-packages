module 0xb5c39366273c8e504f71380fb6c5cf25e7b86566384b45bc4e1f6ac0426e2859::reader {
    public fun read_pool<T0, T1>(arg0: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>) : (address, u64, u64, u64) {
        let (v0, v1, v2) = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::get_reserves<T0, T1>(arg0);
        (0x2::object::id_address<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg0), v0, v1, v2)
    }

    // decompiled from Move bytecode v6
}

