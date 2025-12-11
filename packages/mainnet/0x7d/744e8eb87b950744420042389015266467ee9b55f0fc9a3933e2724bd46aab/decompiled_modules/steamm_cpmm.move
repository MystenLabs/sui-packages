module 0x7d744e8eb87b950744420042389015266467ee9b55f0fc9a3933e2724bd46aab::steamm_cpmm {
    struct PoolInfo has copy, drop, store {
        reserve_x: u64,
        reserve_y: u64,
    }

    public fun get_pool_info<T0, T1, T2: store, T3: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T0, T1, T2, T3>) : (u64, u64) {
        let (v0, v1) = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::balance_amounts<T0, T1, T2, T3>(arg0);
        let v2 = PoolInfo{
            reserve_x : v0,
            reserve_y : v1,
        };
        0x2::event::emit<PoolInfo>(v2);
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

