module 0x29eb73994387dc360fc6dc40c73642e7106f66e2ae7c9c048c681fbf845525b::flowx_cpmm {
    struct PoolInfo has copy, drop, store {
        reserve_x: u64,
        reserve_y: u64,
    }

    public fun get_pool_info<T0, T1>(arg0: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container) : (u64, u64) {
        let (v0, v1) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_reserves<T0, T1>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_pair<T0, T1>(arg0));
        let v2 = PoolInfo{
            reserve_x : v0,
            reserve_y : v1,
        };
        0x2::event::emit<PoolInfo>(v2);
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

