module 0x72564e3097c3c82d8de9df22956ca8607fe15c725733dd37423c913892a223c9::reader {
    fun bayswap_pool_locked<T0, T1, T2>(arg0: &0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::LiquidityPool<T0, T1, T2>) : bool {
        let v0 = 0x2::bcs::new(0x1::bcs::to_bytes<0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::LiquidityPool<T0, T1, T2>>(arg0));
        0x2::bcs::peel_address(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 2);
        0x2::bcs::peel_bool(&mut v0)
    }

    public fun current<T0, T1, T2>(arg0: &0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg1: bool) : (u128, u128, u64, u64) {
        assert!(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::is_uncorrelated<T0>(), 1);
        let v0 = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::borrow_pool<T1, T2, T0>(arg0);
        let (v1, v2, _) = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::get_amounts<T1, T2, T0>(v0);
        let (v4, v5) = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::get_fees_config<T1, T2, T0>(v0);
        let (v6, v7) = if (arg1) {
            (v1, v2)
        } else {
            (v2, v1)
        };
        ((v6 as u128), (v7 as u128), v4, v5)
    }

    public fun current_stable<T0, T1, T2>(arg0: &0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg1: bool) : (u64, u64, u64, u64, u128, u64, u64, bool) {
        assert!(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::is_stable<T0>(), 1);
        let v0 = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::borrow_pool<T1, T2, T0>(arg0);
        let (v1, v2, _) = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::get_amounts<T1, T2, T0>(v0);
        let (v4, v5) = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::get_scales<T1, T2, T0>(v0);
        let (v6, v7) = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::get_fees_config<T1, T2, T0>(v0);
        let (v8, v9, v10, v11) = if (arg1) {
            (v1, v2, v4, v5)
        } else {
            (v2, v1, v5, v4)
        };
        (v8, v9, v10, v11, 1000000000, v6, v7, bayswap_pool_locked<T1, T2, T0>(v0))
    }

    // decompiled from Move bytecode v7
}

