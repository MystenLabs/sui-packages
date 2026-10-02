module 0x86f49ae486baa9ae29dee0c55227ddb64c1ba79b4cf937fa81f5cfc5f3940664::ferra {
    fun assert_spent<T0>(arg0: 0x2::coin::Coin<T0>) {
        assert!(0x2::coin::value<T0>(&arg0) == 0, 3);
        0x2::coin::destroy_zero<T0>(arg0);
    }

    public fun swap_a2b<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg1: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg0, arg1, true, 0, 0x2::coin::from_balance<T0>(arg3, arg4), 0x2::coin::zero<T1>(arg4), arg2, arg4);
        assert_spent<T0>(v0);
        0x2::coin::into_balance<T1>(v1)
    }

    public fun swap_b2a<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg1: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg0, arg1, false, 0, 0x2::coin::zero<T0>(arg4), 0x2::coin::from_balance<T1>(arg3, arg4), arg2, arg4);
        assert_spent<T1>(v1);
        0x2::coin::into_balance<T0>(v0)
    }

    // decompiled from Move bytecode v7
}

