module 0x602ba58d26181e6400180531ddfb45d282782870bf8d6efab7952a3b9fadfb7e::reader {
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

    // decompiled from Move bytecode v7
}

