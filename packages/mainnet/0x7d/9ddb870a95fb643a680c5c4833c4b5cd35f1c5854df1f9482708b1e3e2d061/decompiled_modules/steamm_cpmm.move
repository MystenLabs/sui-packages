module 0x7d9ddb870a95fb643a680c5c4833c4b5cd35f1c5854df1f9482708b1e3e2d061::steamm_cpmm {
    struct PoolInfo has copy, drop, store {
        reserve_x: u64,
        reserve_y: u64,
        offset: u64,
    }

    public fun get_pool_info<T0, T1, T2: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T0, T1, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T2>) : (u64, u64, u64) {
        let (v0, v1) = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::balance_amounts<T0, T1, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T2>(arg0);
        let v2 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::offset<T0, T1, T2>(arg0);
        let v3 = PoolInfo{
            reserve_x : v0,
            reserve_y : v1,
            offset    : v2,
        };
        0x2::event::emit<PoolInfo>(v3);
        (v0, v1, v2)
    }

    // decompiled from Move bytecode v6
}

