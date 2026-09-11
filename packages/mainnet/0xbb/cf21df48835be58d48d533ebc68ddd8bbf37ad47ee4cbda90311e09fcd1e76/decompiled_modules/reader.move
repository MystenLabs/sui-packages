module 0xbbcf21df48835be58d48d533ebc68ddd8bbf37ad47ee4cbda90311e09fcd1e76::reader {
    fun bayswap_pool_locked<T0, T1, T2>(arg0: &0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::LiquidityPool<T0, T1, T2>) : bool {
        decode_locked(0x1::bcs::to_bytes<0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::LiquidityPool<T0, T1, T2>>(arg0))
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

    public fun current_stable<T0, T1, T2>(arg0: &0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg1: bool) : (u64, u64, u64, u64, u64, u64, u64, bool) {
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

    fun decode_locked(arg0: vector<u8>) : bool {
        assert!(0x1::vector::length<u8>(&arg0) == 89, 2);
        let v0 = *0x1::vector::borrow<u8>(&arg0, 72);
        assert!(v0 <= 1, 2);
        v0 == 1
    }

    // decompiled from Move bytecode v7
}

